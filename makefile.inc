SOURCE  := $(wildcard *.c)
OBJS    := $(patsubst %.c, %.o, $(SOURCE))
CC      := gcc
GG      := g++
CXXFLAGS  := -Wall -Wno-strict-aliasing -Wno-uninitialized -g -rdynamic -std=c++11
CFLAGS  := -fPIC -Wall -Wno-strict-aliasing -Wno-uninitialized -g -rdynamic -std=gnu99
LFLAGS  := -g -rdynamic


.PHONY : all clean install 

all : $(TARGET)

clean :
	rm -rf *.d *.o $(TARGET)

$(TARGET) : $(OBJS)
	$(CC) $(LFLAGS) -rdynamic -o $@ $(OBJS) $(LIBS)
.c.o :
	$(CC) $(CFLAGS) -rdynamic -c -o $@ $< $(INCS)

install :

