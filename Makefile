#
# Makefile for the PHP Tools
#
# By Rasmus Lerdorf
#

#
# Here are the configurable options.
#
# For BSDi systems, use: -DFLOCK
# For SVR4 systems (Solaris - SunOS 5.4), use: -DLOCKF
# For SunOS systems use: -DFLOCK -DFILEH
# For AIX systems use: -DLOCKF -DLOCKFH
# For Linux use: -DLOCKF
# For BSD 4.3 use: -DFLOCK -DFILEH -DDIRECT
#
# If you want to disable the <!--!command--> feature add this: -DNOSYSTEM

OPTIONS = -DFLOCK

# Generic compiler options
#CFLAGS	=	-g -O2 -Wall -DDEBUG $(OPTIONS)
CFLAGS =	-O2 $(OPTIONS)
CC =	gcc
# If you don't have gcc, use these instead:
#CFLAGS =	-g $(OPTIONS) 
#CC =	cc

PROJ	= 	php1/

TSOURCE =	$(PROJ)phpf.c $(PROJ)phpl.c $(PROJ)phplview.c $(PROJ)phplmon.c $(PROJ)common.c \
			$(PROJ)error.c $(PROJ)post.c $(PROJ)wm.c $(PROJ)common.h $(PROJ)config.h \
			$(PROJ)subvar.c $(PROJ)html_common.h $(PROJ)post.h $(PROJ)version.h $(PROJ)wm.h \
			$(PROJ)Makefile $(PROJ)README $(PROJ)License

SOURCE =	phpf.c phpl.c phplview.c phplmon.c common.c \
			error.c post.c wm.c common.h config.h \
			subvar.c html_common.h post.h version.h wm.h \
			Makefile README License

ALL: phpl.cgi phplmon.cgi phplview.cgi phpf.cgi

phpl.cgi:	phpl.o wm.o common.o post.o subvar.o error.o
		$(CC) -o $@ $^

phplmon.cgi:	phplmon.o common.o
		$(CC) -o $@ $^

phplview.cgi:	phplview.o common.o post.o error.o
		$(CC) -o $@ $^

phpf.cgi:	phpf.o post.o error.o
		$(CC) -o $@ $^ common.o

php.tar:	$(SOURCE)
		cd ..;tar -cf $(PROJ)php.tar $(TSOURCE);cd $(PROJ)

error.o:	error.c html_common.h
phpl.o:		phpl.c config.h
phplmon.o:	phplmon.c config.h
phplview.o:	phplview.c
wm.o:	wm.c
common.o:	common.c version.h common.h
post.o:		post.c html_common.h
phpf.o:		phpf.c html_common.h common.h
subvar.o:	subvar.c

clean:
	rm -f *.o *.cgi *.tar

