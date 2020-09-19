NAME = app

#------------------------------------------------------------------------------

# change these to proper directories where each file should be
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(SRCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)

#------------------------------------------------------------------------------

CC = arm-none-eabi-gcc
AS = arm-none-eabi-as
LD = arm-none-eabi-ld

#------------------------------------------------------------------------------

LDFLAGS = -T linkerscript.ld

#------------------------------------------------------------------------------

CFLAGS_ARCH = -mthumb -march=armv7e-m+fp -mtune=cortex-m4 -mfpu=fpv4-sp-d16 -mfloat-abi=hard
CFLAGS_DEBUG = -ggdb
CFLAGS_OPT = -Og -ffunction-sections -fdata-sections
CLFAGS_WARN = -Wall -Wextra
CFLAGS_LINK = -nostartfiles -nodefaultlibs -nolibc -nostdlib -nostdinc
CFLAGS = -ffreestanding $(CFLAGS_ARCH) $(CFLAGS_DEBUG) $(CFLAGS_LINK) $(CLFAGS_WARN) -std=c11

#------------------------------------------------------------------------------
# Assembler flags
#------------------------------------------------------------------------------
ASFLAGS += -mthumb
ASFLAGS += -march=armv7e-m+fp
ASFLAGS += -mcpu=cortex-m4
ASFLAGS += -mfpu=fpv4-sp-d16
ASFLAGS += -mfloat-abi=hard
#------------------------------------------------------------------------------

.PHONY: directories clean

all: directories $(BINDIR)/$(NAME).elf

#------------------------------------------------------------------------------
directories: $(OBJDIR) $(BINDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(BINDIR):
	mkdir -p $(BINDIR)
#------------------------------------------------------------------------------

$(BINDIR)/$(NAME).elf: startup.o $(OBJECTS)
	$(LD) $(LDFLAGS) $(OBJDIR)/startup.o $(OBJECTS) -o $@

#------------------------------------------------------------------------------
# Startup secondary recipe
#------------------------------------------------------------------------------
startup.o: startup.S
	$(AS) $(ASFLAGS) $< -o $(OBJDIR)/$@
$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -c $< -o $@

#------------------------------------------------------------------------------
clean:
	rm $(OBJDIR)/*.o $(BINDIR)/$(NAME).elf
