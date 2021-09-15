#pragma once

#include "platform.h"
#include <stdarg.h>
#include <string.h>

typedef enum Log_level{
    LOG_FATAL = 0,
    LOG_ERROR = 1,
    LOG_WARN = 2,
    LOG_INFO = 3,
    LOG_DEBUG = 4,
    LOG_TRACE = 5
}Log_level;

void log_message(Log_level log_level, const char* message, ...);

#define LFATAL(message, ...) log_message(LOG_FATAL, message, ##__VA_ARGS__);

#define LERROR(message, ...) log_message(LOG_ERROR, message, ##__VA_ARGS__);

#define LWARN(message, ...) log_message(LOG_WARN, message, ##__VA_ARGS__);

#define LINFO(message, ...) log_message(LOG_INFO, message, ##__VA_ARGS__);

#define LDEBUG(message, ...) log_message(LOG_DEBUG, message, ##__VA_ARGS__);

#define LTRACE(message, ...) log_message(LOG_TRACE, message, ##__VA_ARGS__);
