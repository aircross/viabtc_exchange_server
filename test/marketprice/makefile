TARGET  := marketprice.exe
INCS = -I ../../network -I ../../utils -I ../../depends
LIBS = -L ../../network -lnetwork -Wl,-Bstatic  -Wl,-Bdynamic -lm -lpthread -ldl -lev -ljansson -lmpdec -lrdkafka -lz -lssl -lcrypto -lhiredis
include ../../makefile.inc
