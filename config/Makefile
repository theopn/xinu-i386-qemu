#
# Make the Xinu configuration program
#

TOOLCHAIN_BASE	?=	../compile/.toolchain

CC	= gcc

# If pre-built .toolchain directory exists, use it.
# Otherwise, it's native or Docker compilation
ifeq ($(wildcard $(TOOLCHAIN_BASE)/bin/flex),)
	LEX  = flex
	YACC = bison -y
else
	LEX  = $(TOOLCHAIN_BASE)/bin/flex
	YACC = BISON_PKGDATADIR=$(TOOLCHAIN_BASE)/share/bison $(TOOLCHAIN_BASE)/bin/bison -y
endif

CFLAGS	= 
LFLAGS	=	-L$(TOOLCHAIN_BASE)/lib

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
