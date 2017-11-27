TARGET  := libutils.so
INCS = -I ../network  -I ../depends
include ../makefile.inc
$(TARGET) : $(OBJS)
#	ar -rs $@ $^
    $^ -fPIC -shared -o $@