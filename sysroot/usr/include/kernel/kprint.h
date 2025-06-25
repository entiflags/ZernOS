#pragma once

#include <PinP/Formatter.h>
#include <kernel/tty.h>

#define kprint(...)	PinP::Formatter::print<TTY::putchar>(__VA_ARGS__)
#define kprintln(...) 	PinP::Formatter::println<TTY::putchar>(__VA_ARGS__)