# Name: Makefile
# Project: Project Soil
# Author: Ben Oxley <ben.oxley@gmail.com>

# DEVICE ....... The AVR device you compile for
# CLOCK ........ Target AVR clock rate in Hertz
# OBJECTS ...... The object files created from your source files. This list is
#                usually the same as the list of source files with suffix ".o".
# PROGRAMMER ... Options to avrdude which define the hardware you use for
#                uploading to the AVR and the interface where this hardware
#                is connected.
# FUSES ........ Parameters for avrdude to flash the fuses appropriately.

DEVICE     = AT90USB82
CLOCK      = 8000000
PROGRAMMER = -c avrispmkII -P /dev/tty.usbserial -B 1 -F
SOURCES	   = $(wildcard *.c)
FUSES      = -U hfuse:w:0xd7:m -U lfuse:w:0xf7:m

# End configuration

OBJECTS = $(SOURCES:.c=.o)
AVRDUDE = avrdude $(PROGRAMMER) -p $(DEVICE) -C /etc/avrdude.conf

# Disable warning of strict-aliasing since uIP type-puns
COMPILE = avr-gcc -Wall -Os -fno-strict-aliasing -gdwarf-2 -std=gnu99 -Wl,-u,vfprintf -lprintf_flt -lm -DF_CPU=$(CLOCK) -mmcu=atmega328p

# symbolic targets:
all:	main.hex

.c.o:
	$(COMPILE) -c $< -o $@

.S.o:
	$(COMPILE) -x assembler-with-cpp -c $< -o $@
# "-x assembler-with-cpp" should not be necessary since this is the default
# file type for the .S (with capital S) extension. However, upper case
# characters are not always preserved on Windows. To ensure WinAVR
# compatibility define the file type manually.

.c.s:
	$(COMPILE) -S $< -o $@

flash:	all
	$(AVRDUDE) -U flash:w:main.hex:i

eeprom: all
	$(AVRDUDE) -U eeprom:w:main.eep:i

fuse:
	$(AVRDUDE) $(FUSES)

# Xcode uses the Makefile targets "", "clean" and "install"
install: flash fuse

# if you use a bootloader, change the command below appropriately:
load: all
	bootloadHID main.hex

clean:
	rm -f main.hex main.elf main.eep $(OBJECTS)

# file targets:
main.elf: $(OBJECTS)
	$(COMPILE) -o main.elf $(OBJECTS)
	avr-size -C --mcu=${DEVICE} $@

main.hex: main.elf
	rm -f main.hex
	avr-objcopy -j .text -j .data -O ihex main.elf main.hex
	avr-objcopy -j .eeprom -O ihex main.elf main.eep
# If you have an EEPROM section, you must also create a hex file for the
# EEPROM and add it to the "flash" target.

# Targets for code debugging and analysis:
disasm:	main.elf
	avr-objdump -d main.elf

cpp:
	$(COMPILE) -E main.c