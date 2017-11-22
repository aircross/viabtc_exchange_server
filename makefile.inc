SOURCE  := $(wildcard *.c)
OBJS    := $(patsubst %.c, %.o, $(SOURCE))
CC      := gcc
CXXFLAGS  := -Wall -Wno-strict-aliasing -Wno-uninitialized -g -rdynamic -std=c++11
LFLAGS  := -g -rdynamic


.PHONY : all clean install 

all : $(TARGET)

clean :
	rm -rf *.d *.o $(TARGET)

$(TARGET) : $(OBJS)
	$(CC) $(LFLAGS) -o $@ $(OBJS) $(LIBS)
.c.o :
	$(CC) $(CFLAGS) -c -o $@ $< $(INCS)

install :

