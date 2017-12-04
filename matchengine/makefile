TARGET  := matchengine.exe
INCS = -I ../network -I ../utils -I ../depends
LIBS = -L ../utils -lutils -L ../network -lnetwork -Wl,-Bstatic -Wl,-Bdynamic -lm -lpthread -ldl -lev -ljansson -lmpdec -lmysqlclient -lz -lrdkafka -lssl -lcrypto -lhiredis -lcurl
include ../makefile.inc
