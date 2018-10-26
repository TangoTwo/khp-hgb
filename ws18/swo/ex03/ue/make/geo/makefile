ifeq ($(OS), WINDOWS_NT)
	EXEEXT = .exe
else
	EXEEXT = 
endif

TARGET = prg$(EXEEXT)
CC = gcc
RM = rm -f
CFLAGS = -g -std=c11 -Wall -Wextra -Wpedantic -Wconversion -Werror=vla
LDFLAGS = -o
DEPENDFILE = .depend
.PHONY: depend clean

CFILES = $(wildcard *.c)
OFILES = $(CFILES: .c=.o)

%.o: %.c
	$(CC) -c $(CFLAGS) $<
	
all: $(TARGET)

$(TARGET): $(OFILES)
	$(CC) $(LDFLAGS) $@ $(CFLAGS) $(OFILES)

depend:
	$(CC) $(CFLAGS) $(CFILES) -MM > $(DEPENDFILE)
	
clean:
	@$(RM) *.o prg
	@echo "Cleaned up!"

-include $(DEPENDFILE)