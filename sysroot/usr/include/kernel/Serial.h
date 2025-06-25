#pragma once

#include <PinP/Formatter.h>
#include <kernel/PIT.h>

#define dprintln(...)																										\
	do {																													\
		PinP::Formatter::print<Serial::serial_putc>("[{5.3}] {}({}):  ", (float)PIT::ms_since_boot(), __FILE__, __LINE__);	\
		PinP::Formatter::println<Serial::serial_putc>(__VA_ARGS__);															\
	} while(false)

#define dwarnln(...)											\
	do {														\
		PinP::Formatter::print<Serial::serial_putc>("\e[33m");	\
		dprintln(__VA_ARGS__);									\
		PinP::Formatter::print<Serial::serial_putc>("\e[m");		\
	} while(false)

#define derrorln(...)											\
	do {														\
		PinP::Formatter::print<Serial::serial_putc>("\e[31m");	\
		dprintln(__VA_ARGS__);									\
		PinP::Formatter::print<Serial::serial_putc>("\e[m");		\
	} while(false)

namespace Serial
{
	void initialize();
	void serial_putc(char);
}