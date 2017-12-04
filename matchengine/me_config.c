/*
 * Description: 
 *     History: yang@haipo.me, 2017/03/16, create
 */
# include <curl/curl.h>
# include "me_config.h"

struct settings settings;


static int load_assets(json_t *root, const char *key)
{
    json_t *node = json_object_get(root, key);
    if (!node || !json_is_array(node)) {
        return -__LINE__;
    }

    settings.asset_num = json_array_size(node);
    settings.assets = malloc(sizeof(struct asset) * settings.asset_num);
    for (size_t i = 0; i < settings.asset_num; ++i) {
        json_t *row = json_array_get(node, i);
        if (!json_is_object(row))
            return -__LINE__;
        ERR_RET_LN(read_cfg_str(row, "name", &settings.assets[i].name, NULL));
        ERR_RET_LN(read_cfg_int(row, "prec_save", &settings.assets[i].prec_save, true, 0));
        ERR_RET_LN(read_cfg_int(row, "prec_show", &settings.assets[i].prec_show, false, settings.assets[i].prec_save));
        if (strlen(settings.assets[i].name) > ASSET_NAME_MAX_LEN)
            return -__LINE__;
    }

    return 0;
}

static int load_markets(json_t *root, const char *key)
{
    json_t *node = json_object_get(root, key);
    if (!node || !json_is_array(node)) {
        return -__LINE__;
    }

    settings.market_num = json_array_size(node);
    settings.markets = malloc(sizeof(struct market) * settings.market_num);
    for (size_t i = 0; i < settings.market_num; ++i) {
        json_t *row = json_array_get(node, i);
        if (!json_is_object(row))
            return -__LINE__;
        ERR_RET_LN(read_cfg_str(row, "name", &settings.markets[i].name, NULL));
        ERR_RET_LN(read_cfg_int(row, "fee_prec", &settings.markets[i].fee_prec, false, 4));
        ERR_RET_LN(read_cfg_mpd(row, "min_amount", &settings.markets[i].min_amount, "0.01"));

        json_t *stock = json_object_get(row, "stock");
        if (!stock || !json_is_object(stock))
            return -__LINE__;
        ERR_RET_LN(read_cfg_str(stock, "name", &settings.markets[i].stock, NULL));
        ERR_RET_LN(read_cfg_int(stock, "prec", &settings.markets[i].stock_prec, true, 0));

        json_t *money = json_object_get(row, "money");
        if (!money || !json_is_object(money))
            return -__LINE__;
        ERR_RET_LN(read_cfg_str(money, "name", &settings.markets[i].money, NULL));
        ERR_RET_LN(read_cfg_int(money, "prec", &settings.markets[i].money_prec, true, 0));
    }

    return 0;
}

static int read_config_from_json(json_t *root)
{
    int ret;
    ret = read_cfg_bool(root, "debug", &settings.debug, false, false);
    if (ret < 0) {
        printf("read debug config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_process(root, "process", &settings.process);
    if (ret < 0) {
        printf("load process config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_log(root, "log", &settings.log);
    if (ret < 0) {
        printf("load log config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_alert(root, "alert", &settings.alert);
    if (ret < 0) {
        printf("load alert config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_rpc_svr(root, "svr", &settings.svr);
    if (ret < 0) {
        printf("load svr config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_cli_svr(root, "cli", &settings.cli);
    if (ret < 0) {
        printf("load cli config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_mysql(root, "db_log", &settings.db_log);
    if (ret < 0) {
        printf("load log db config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_cfg_mysql(root, "db_history", &settings.db_history);
    if (ret < 0) {
        printf("load history db config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_assets(root, "assets");
    if (ret < 0) {
        printf("load assets config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = load_markets(root, "markets");
    if (ret < 0) {
        printf("load markets config fail: %d\n", ret);
        return -__LINE__;
    }
    ret = read_cfg_str(root, "brokers", &settings.brokers, NULL);
    if (ret < 0) {
        printf("load brokers fail: %d\n", ret);
        return -__LINE__;
    }
    ret = read_cfg_int(root, "slice_interval", &settings.slice_interval, false, 86400);
    if (ret < 0) {
        printf("load slice_interval fail: %d", ret);
        return -__LINE__;
    }
    ret = read_cfg_int(root, "slice_keeptime", &settings.slice_keeptime, false, 86400 * 3);
    if (ret < 0) {
        printf("load slice_keeptime fail: %d", ret);
        return -__LINE__;
    }
    ret = read_cfg_int(root, "history_thread", &settings.history_thread, false, 10);
    if (ret < 0) {
        printf("load history_thread fail: %d", ret);
        return -__LINE__;
    }

    ERR_RET_LN(read_cfg_real(root, "cache_timeout", &settings.cache_timeout, false, 0.45));

    return 0;
}

int init_config(const char *path)
{
    json_error_t error;
    json_t *root = json_load_file(path, 0, &error);
    if (root == NULL) {
        printf("json_load_file from: %s fail: %s in line: %d\n", path, error.text, error.line);
        return -__LINE__;
    }
    if (!json_is_object(root)) {
        json_decref(root);
        return -__LINE__;
    }

    int ret = read_config_from_json(root);
    if (ret < 0) {
        json_decref(root);
        return ret;
    }
    json_decref(root);

    return 0;
}

int parse_sy_reply(sds* reply){	
	int retCode=0;
	json_t *result = json_loads(reply, 0, NULL);
	if (result == NULL){
		printf("parse_sy_reply, json_loads fail\n");
		return = -__LINE__;
	}

	read_cfg_int(result, "Code", &retCode, true, 0);
	if(1100 != retCode){
		printf("parse_sy_reply, 1100 != retCode\n");
		return = -__LINE__;
	}

	json_t *content_node = json_object_get(root, "Content");
    if (!content_node || !json_is_object(content_node)) {
		printf("parse_sy_reply, content_node get faild \n");
        return -__LINE__;
    }

	ret = read_config_from_json(content_node);

	return 0;
}

size_t config_callback(void *ptr, size_t size, size_t nmemb, void *userdata){
    sds *reply = userdata;
    *reply = sdscatlen(*reply, ptr, size * nmemb);
    return size * nmemb;
}

int get_config_from_url(){
	int ret=0
	sds reply = sdsempty();

	CURL *curl = curl_easy_init();
	curl_easy_setopt(curl, CURLOPT_URL, url);	
	curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, config_callback);
	curl_easy_setopt(curl, CURLOPT_WRITEDATA, &reply);

	CURLcode ret = curl_easy_perform(curl);
	if (ret != CURLE_OK) {
		printf("get_config_from_url curl_easy_perform fail: %s\n", curl_easy_strerror(ret));
		ret = -__LINE__;
		goto cleanup;
	}
	
	ret = parse_sy_reply(&reply);
        
	cleanup:
	curl_easy_cleanup(curl);
	sdsfree(reply);

	return ret;
}

int read_sy_config(json_t *root){
	ERR_RET(read_cfg_str(root, "config_url", &settings.sy_config_url, NULL));
	ERR_RET(get_config_from_url());
	return 0;
}

int init_config_from_url(){
    json_error_t error;
	char* config_url = NULL;
    json_t *root = json_load_file(path, 0, &error);
    if (root == NULL) {
        printf("init_config_from_url from: %s fail: %s in line: %d\n", path, error.text, error.line);
        return -__LINE__;
    }
    if (!json_is_object(root)) {
        json_decref(root);
        return -__LINE__;
    }

    int ret = read_url_from_json(root);
    if (ret < 0) {
        json_decref(root);
        return ret;
    }
    json_decref(root);

    return 0;

}

