PRGNAME     = potator

# define regarding OS, which compiler to use
EXESUFFIX = 
TOOLCHAIN = 
CC          = gcc
CCP         = g++
LD          = gcc

# add SDL dependencies
SDL_LIB     = 
SDL_INCLUDE = 

# change compilation / linking flag options
F_OPTS		=
CC_OPTS		= -O2 -fomit-frame-pointer -fdata-sections -ffunction-sections $(F_OPTS)
CFLAGS		= -I$(SDL_INCLUDE) $(CC_OPTS)
CXXFLAGS	=$(CFLAGS) 
LDFLAGS     = -lSDLmain -lSDL -lm -Wl,--as-needed -Wl,--gc-sections -flto

# Files to be compiled
SRCDIR    = ./common/m6502 ./common ./platform/opendingux
VPATH     = $(SRCDIR)
SRC_C   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.c))
SRC_CP   = $(foreach dir, $(SRCDIR), $(wildcard $(dir)/*.cpp))
OBJ_C   = $(notdir $(patsubst %.c, %.o, $(SRC_C)))
OBJ_CP   = $(notdir $(patsubst %.cpp, %.o, $(SRC_CP)))
OBJS     = $(OBJ_C) $(OBJ_CP)

# Rules to make executable
$(PRGNAME)$(EXESUFFIX): $(OBJS)  
	$(LD) $(CFLAGS) -o $(PRGNAME)$(EXESUFFIX) $^ $(LDFLAGS)

$(OBJ_C) : %.o : %.c
	$(CC) $(CFLAGS) -c -o $@ $<

$(OBJ_CP) : %.o : %.cpp
	$(CCP) $(CXXFLAGS) -c -o $@ $<

clean:
	rm -f $(PRGNAME)$(EXESUFFIX) *.o
