TARGET  := libutils.a
INCS = -I ../network, ../hiredis
include ../makefile.inc
$(TARGET) : $(OBJS)
	ar -rs $@ $^
