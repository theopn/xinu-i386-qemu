#
# Make the Xinu configuration program
#

TOOLCHAIN_BASE := $(CURDIR)/../compile/.toolchain
TOOLCHAIN_BIN  := $(TOOLCHAIN_BASE)/bin
ifeq ($(wildcard $(TOOLCHAIN_BIN)/flex),)
	# No local toolchain found (Docker/Native). Fall back to system tools.
	LEX    = flex
	YACC   = bison -y
	LFLAGS = # Use the system's default libfl
else
	export BISON_PKGDATADIR := $(TOOLCHAIN_BASE)/share/bison
	LEX    = $(TOOLCHAIN_BIN)/flex
	YACC   = $(TOOLCHAIN_BIN)/bison -y
	LFLAGS = -L$(TOOLCHAIN_BASE)/lib
endif

CC	= gcc
CFLAGS	= 

#
# Name of the configuration program
#

CONFIG	= config

all:		conf.h conf.c

${CONFIG}:	lex.yy.c y.tab.c
		$(CC) -o $@ y.tab.c ${LFLAGS} -lfl

lex.yy.c:	config.l
		$(LEX) config.l

y.tab.c:	config.y
		$(YACC) config.y

clean:
		rm -f config lex.yy.c y.tab.c

conf.h:		config Configuration
		./config Configuration conf.c conf.h

conf.c:		config Configuration
		./config Configuration conf.c conf.h

install:	conf.h conf.c
		cp -p conf.h ../include
		cp -p conf.c ../system
