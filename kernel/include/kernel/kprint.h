#pragma once

#include <PinP/Formatter.h>
#include <kernel/tty.h>

#define kprint		PinP::Formatter::print<TTY::putchar>
#define kprintln 	PinP::Formatter::println<TTY::putchar>