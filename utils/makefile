TARGET  := libutils.so
INCS = -I ../network  -I ../depends
include ../makefile.inc
$(TARGET) : $(OBJS)
#	ar -rs $@ $^
    gcc $^ -fPIC -shared -o -g -rdynamic $@