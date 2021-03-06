# makefile for building LUA
# see INSTALL for installation instructions
# see ../Makefile and LUAconf.h for further customization

# == CHANGE THE SETTINGS BELOW TO SUIT YOUR ENVIRONMENT =======================

# Warnings valid for both C and C++
CWARNSCPP= \
	-Wextra \
	-Wshadow \
	-Wsign-compare \
	-Wundef \
	-Wwrite-strings \
	-Wredundant-decls \
	-Wdisabled-optimization \
	-Wdouble-promotion \
 	-Wstrict-aliasing=3 \
 	-Wno-aggressive-loop-optimizations \
 	-Wlogical-op \
	-Werror \
	# -pedantic   # warns if we use jump tables \
	# the next warnings generate too much noise, so they are disabled
	# -Wconversion  -Wno-sign-conversion \
	# -Wsign-conversion \
	# -Wstrict-overflow=2 \
	# -Wformat=2 \
	# -Wcast-qual \

# The next warnings are neither valid nor needed for C++
CWARNSC= -Wdeclaration-after-statement \
	-Wmissing-prototypes \
	-Wnested-externs \
	-Wstrict-prototypes \
	-Wc++-compat \
	-Wold-style-definition \


CWARNS= $(CWARNSCPP) $(CWARNSC)


# -DEXTERNMEMCHECK -DHARDSTACKTESTS -DHARDMEMTESTS -DTRACEMEM='"tempmem"'
# -g -DLUA_USER_H='"ltests.h"'
# -pg -malign-double
# -DLUA_USE_CTYPE -DLUA_USE_APICHECK
# ('-ftrapv' for runtime checks of integer overflows)
# -fsanitize=undefined -ftrapv -fno-inline
TESTS= -DLUA_USER_H='"ltests.h"' -O0


# LOCAL = $(TESTS) $(CWARNS) -g



# enable Linux goodies
MYCFLAGS= $(LOCAL) -std=c99 -DLUA_USE_LINUX -DLUA_USE_READLINE
MYLDFLAGS= $(LOCAL) -Wl,-E
MYLIBS= -ldl -lreadline


CC= gcc
CFLAGS= -Wall -O2 $(MYCFLAGS) -Wfatal-errors -fno-stack-protector -fno-common
AR= ar rc
RANLIB= ranlib
RM= rm -f



# == END OF USER SETTINGS. NO NEED TO CHANGE ANYTHING BELOW THIS LINE =========


LIBS = -lm

CORE_T=	liblua.a
CORE_O=	lapi.o lcode.o lctype.o ldebug.o ldo.o ldump.o lfunc.o lgc.o llex.o \
	lmem.o lobject.o lopcodes.o lparser.o lstate.o lstring.o ltable.o \
	ltm.o lundump.o lvm.o lzio.o ltests.o
AUX_O=	lauxlib.o
LIB_O=	lbaselib.o ldblib.o liolib.o lmathlib.o loslib.o ltablib.o lstrlib.o \
	lutf8lib.o loadlib.o lcorolib.o linit.o

LUA_T=	LUA
LUA_O=	lua.o

# LUAC_T=	luac
# LUAC_O=	luac.o print.o

ALL_T= $(CORE_T) $(LUA_T) $(LUAC_T)
ALL_O= $(CORE_O) $(LUA_O) $(LUAC_O) $(AUX_O) $(LIB_O)
ALL_A= $(CORE_T)

all:	$(ALL_T)

o:	$(ALL_O)

a:	$(ALL_A)

$(CORE_T): $(CORE_O) $(AUX_O) $(LIB_O)
	$(AR) $@ $?
	$(RANLIB) $@

$(LUA_T): $(LUA_O) $(CORE_T)
	$(CC) -o $@ $(MYLDFLAGS) $(LUA_O) $(CORE_T) $(LIBS) $(MYLIBS) $(DL)

$(LUAC_T): $(LUAC_O) $(CORE_T)
	$(CC) -o $@ $(MYLDFLAGS) $(LUAC_O) $(CORE_T) $(LIBS) $(MYLIBS)

clean:
	rcsclean -u
	$(RM) $(ALL_T) $(ALL_O)

depend:
	@$(CC) $(CFLAGS) -MM *.c

echo:
	@echo "CC = $(CC)"
	@echo "CFLAGS = $(CFLAGS)"
	@echo "AR = $(AR)"
	@echo "RANLIB = $(RANLIB)"
	@echo "RM = $(RM)"
	@echo "MYCFLAGS = $(MYCFLAGS)"
	@echo "MYLDFLAGS = $(MYLDFLAGS)"
	@echo "MYLIBS = $(MYLIBS)"
	@echo "DL = $(DL)"

$(ALL_O): makefile

# DO NOT EDIT
# automatically made with 'gcc -MM l*.c'

lapi.o: lapi.c lprefix.h LUA.h LUAconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h lstring.h \
 ltable.h lundump.h lvm.h
lauxlib.o: lauxlib.c lprefix.h LUA.h LUAconf.h lauxlib.h
lbaselib.o: lbaselib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lcode.o: lcode.c lprefix.h LUA.h LUAconf.h lcode.h llex.h lobject.h \
 llimits.h lzio.h lmem.h lopcodes.h lparser.h ldebug.h lstate.h ltm.h \
 ldo.h lgc.h lstring.h ltable.h lvm.h
lcorolib.o: lcorolib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lctype.o: lctype.c lprefix.h lctype.h LUA.h LUAconf.h llimits.h
ldblib.o: ldblib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
ldebug.o: ldebug.c lprefix.h LUA.h LUAconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h lcode.h llex.h lopcodes.h lparser.h \
 ldebug.h ldo.h lfunc.h lstring.h lgc.h ltable.h lvm.h
ldo.o: ldo.c lprefix.h LUA.h LUAconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h lopcodes.h \
 lparser.h lstring.h ltable.h lundump.h lvm.h
ldump.o: ldump.c lprefix.h LUA.h LUAconf.h lobject.h llimits.h lstate.h \
 ltm.h lzio.h lmem.h lundump.h
lfunc.o: lfunc.c lprefix.h LUA.h LUAconf.h lfunc.h lobject.h llimits.h \
 lgc.h lstate.h ltm.h lzio.h lmem.h
lgc.o: lgc.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lgc.h lstring.h ltable.h
linit.o: linit.c lprefix.h LUA.h LUAconf.h LUAlib.h lauxlib.h
liolib.o: liolib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
llex.o: llex.c lprefix.h LUA.h LUAconf.h lctype.h llimits.h ldebug.h \
 lstate.h lobject.h ltm.h lzio.h lmem.h ldo.h lgc.h llex.h lparser.h \
 lstring.h ltable.h
lmathlib.o: lmathlib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lmem.o: lmem.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lgc.h
loadlib.o: loadlib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lobject.o: lobject.c lprefix.h LUA.h LUAconf.h lctype.h llimits.h \
 ldebug.h lstate.h lobject.h ltm.h lzio.h lmem.h ldo.h lstring.h lgc.h \
 lvm.h
lopcodes.o: lopcodes.c lprefix.h lopcodes.h llimits.h LUA.h LUAconf.h
loslib.o: loslib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lparser.o: lparser.c lprefix.h LUA.h LUAconf.h lcode.h llex.h lobject.h \
 llimits.h lzio.h lmem.h lopcodes.h lparser.h ldebug.h lstate.h ltm.h \
 ldo.h lfunc.h lstring.h lgc.h ltable.h
lstate.o: lstate.c lprefix.h LUA.h LUAconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h ldebug.h ldo.h lfunc.h lgc.h llex.h \
 lstring.h ltable.h
lstring.o: lstring.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h \
 lobject.h llimits.h ltm.h lzio.h lmem.h ldo.h lstring.h lgc.h
lstrlib.o: lstrlib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
ltable.o: ltable.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lgc.h lstring.h ltable.h lvm.h
ltablib.o: ltablib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
ltests.o: ltests.c lprefix.h LUA.h LUAconf.h lapi.h llimits.h lstate.h \
 lobject.h ltm.h lzio.h lmem.h lauxlib.h lcode.h llex.h lopcodes.h \
 lparser.h lctype.h ldebug.h ldo.h lfunc.h lstring.h lgc.h ltable.h \
 LUAlib.h
ltm.o: ltm.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lgc.h lstring.h ltable.h lvm.h
lua.o: lua.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lundump.o: lundump.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h \
 lobject.h llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lstring.h lgc.h \
 lundump.h
lutf8lib.o: lutf8lib.c lprefix.h LUA.h LUAconf.h lauxlib.h LUAlib.h
lvm.o: lvm.c lprefix.h LUA.h LUAconf.h ldebug.h lstate.h lobject.h \
 llimits.h ltm.h lzio.h lmem.h ldo.h lfunc.h lgc.h lopcodes.h lstring.h \
 ltable.h lvm.h ljumptab.h
lzio.o: lzio.c lprefix.h LUA.h LUAconf.h llimits.h lmem.h lstate.h \
 lobject.h ltm.h lzio.h

# (end of Makefile)
