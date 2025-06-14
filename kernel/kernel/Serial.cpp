#include <kernel/IO.h>
#include <kernel/kprint.h>
#include <kernel/Serial.h>

#define COM1 0x3f8

namespace Serial
{
	static bool s_initialized = false;
	
	void initialize()
	{
		IO::outb(COM1 + 1, 0x00);
		IO::outb(COM1 + 3, 0x80);
		IO::outb(COM1 + 0, 0x03);
		IO::outb(COM1 + 1, 0x00);
		IO::outb(COM1 + 3, 0x03);
		IO::outb(COM1 + 2, 0xC7);
		IO::outb(COM1 + 4, 0x0B);
		IO::outb(COM1 + 4, 0x1E);
		IO::outb(COM1 + 0, 0xAE);
		
		//check if serial is faulty
		if(IO::inb(COM1 + 0) != 0xAE) {
			kprint("Could not initialize COM1 serial port\n");
			return;
		}
		
		IO::outb(COM1 + 4, 0x0F);
		s_initialized = true;
	}
	
	int is_transmit_empty()
	{
		return IO::inb(COM1 + 5) & 0x20;
	}
	
	void serial_putc(char c)
	{
		if (!s_initialized)
			return;
		while (is_transmit_empty() == 0);
		IO::outb(COM1, c);
	}
}