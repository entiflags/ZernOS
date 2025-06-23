#pragma once

#include <PinP/Formatter.h>

#define dprint		PinP::Formatter::print<Serial::serial_putc>
#define dprintln	PinP::Formatter::println<Serial::serial_putc>

namespace Serial
{
	void initialize();
	void serial_putc(char);
}