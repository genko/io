CC=gcc
CFLAGS=-c -Wall -Os -s
IFLAGS=-Ibasekit/source -Iiovm/source -Igarbagecollector/source -Icoroutine/source -Ibasekit/source/simd_cph/include
LDFLAGS=-lm -ldl -s
VM_S=$(wildcard iovm/source/*.c)
BASE_S=$(wildcard basekit/source/*.c)
COLL_S=$(wildcard garbagecollector/source/*.c)
COR_S=$(wildcard coroutine/source/*.c)
SOURCES=main.c $(VM_S) $(BASE_S) $(COLL_S) $(COR_S)
OBJECTS=$(SOURCES:.c=.o)
EXECUTABLE=io
PREFIX = $(DESTDIR)/usr
BINDIR = $(PREFIX)/bin


all: $(SOURCES) $(EXECUTABLE)

.PHONY : clean install
	
$(EXECUTABLE): $(OBJECTS) 
	$(CC) $(OBJECTS) -o $@ $(LDFLAGS)

.c.o:
	$(CC) $(IFLAGS) $(CFLAGS) $< -o $@

clean:
	find ./ -type f -name '*.o' -delete
	-rm io

install:
	install -D $(EXECUTABLE) $(BINDIR)/$(EXECUTABLE)
