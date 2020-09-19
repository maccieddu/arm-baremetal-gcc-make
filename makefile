NAME = app
#------------------------------------------------------------------------------
# Directories
#------------------------------------------------------------------------------
SRCDIR = src
OBJDIR = obj
BINDIR = bin
#------------------------------------------------------------------------------
# Files
#------------------------------------------------------------------------------
SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
#------------------------------------------------------------------------------
# Toolchain
#------------------------------------------------------------------------------
CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld
SZ = arm-none-eabi-size
#------------------------------------------------------------------------------
# Linker flags
#------------------------------------------------------------------------------
LDFLAGS += -T linkerscript.ld
LDFLAGS += --print-memory-usage
#------------------------------------------------------------------------------
# Assembler flags
#------------------------------------------------------------------------------
ASFLAGS += -mthumb
ASFLAGS += -march=armv7e-m+fp
ASFLAGS += -mcpu=cortex-m4
ASFLAGS += -mfpu=fpv4-sp-d16
ASFLAGS += -mfloat-abi=hard
#------------------------------------------------------------------------------
# Compiler architecture flags
#------------------------------------------------------------------------------
CFLAGS_ARCH += -mthumb
CFLAGS_ARCH += -march=armv7e-m+fp
CFLAGS_ARCH += -mtune=cortex-m4
CFLAGS_ARCH += -mfpu=fpv4-sp-d16
CFLAGS_ARCH += -mfloat-abi=hard
#------------------------------------------------------------------------------
# Compiler debugging flags
#------------------------------------------------------------------------------
CFLAGS_DBG += -ggdb
#------------------------------------------------------------------------------
# Compiler optimization flags
#------------------------------------------------------------------------------
CFLAGS_OPT += -Og
CFLAGS_OPT += -ffunction-sections
CFLAGS_OPT += -fdata-sections
#------------------------------------------------------------------------------
# Compiler warning flags
#------------------------------------------------------------------------------
CLFAGS_WARN += -Wall
CLFAGS_WARN += -Wextra
#------------------------------------------------------------------------------
# Compiler linking flags
#------------------------------------------------------------------------------
CFLAGS_LINK += -nostartfiles
CFLAGS_LINK += -nodefaultlibs
CFLAGS_LINK += -nolibc
CFLAGS_LINK += -nostdlib
#------------------------------------------------------------------------------
# Compiler directories flags
#------------------------------------------------------------------------------
CFLAGS_DIR += -nostdinc
#------------------------------------------------------------------------------
# Compiler dialect flags
#------------------------------------------------------------------------------
CFLAGS_DIAL += -std=c11
#------------------------------------------------------------------------------
# Compiler flags
#------------------------------------------------------------------------------
CFLAGS += -ffreestanding
CFLAGS += $(CFLAGS_ARCH)
CFLAGS += $(CFLAGS_DBG)
CFLAGS += $(CFLAGS_OPT)
CFLAGS += $(CLFAGS_WARN)
CFLAGS += $(CFLAGS_LINK)
CFLAGS += $(CFLAGS_DIR)
CFLAGS += $(CFLAGS_DIAL)
#------------------------------------------------------------------------------
# PHONY
#------------------------------------------------------------------------------
.PHONY: directories clean
#------------------------------------------------------------------------------
# Default recipe
#------------------------------------------------------------------------------
all: directories $(NAME) size
#------------------------------------------------------------------------------
# Create directories before build object files
#------------------------------------------------------------------------------
directories: $(OBJDIR) $(BINDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)
#------------------------------------------------------------------------------
# Primary app recipe
#------------------------------------------------------------------------------
$(NAME): $(BINDIR)/$(NAME).elf

$(BINDIR)/$(NAME).elf: startup.o $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJDIR)/startup.o $(OBJECTS) -o $@
#------------------------------------------------------------------------------
# Startup secondary recipe
#------------------------------------------------------------------------------
startup.o: startup.S
	$(AS) $(ASFLAGS) $< -o $(OBJDIR)/$@
#------------------------------------------------------------------------------
# Sources secondary recipes
#------------------------------------------------------------------------------
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@
#------------------------------------------------------------------------------
# Size secondary recipes
#------------------------------------------------------------------------------
size:
	$(SZ) $(OBJDIR)/*.o $(BINDIR)/$(NAME).elf
#------------------------------------------------------------------------------
clean:
	rm $(OBJDIR)/*.o $(BINDIR)/$(NAME).elf
#------------------------------------------------------------------------------
