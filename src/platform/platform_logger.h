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

#if LOG_WARN_ENABLED == 1
#define LWARN(message, ...) log_message(LOG_WARN, message, ##__VA_ARGS__);
#else
#define LWARN(message, ...)
#endif

#if LOG_INFO_ENABLED == 1
#define LINFO(message, ...) log_message(LOG_INFO, message, ##__VA_ARGS__);
#else
#define LINFO(message, ...)
#endif

#if LOG_DEBUG_ENABLED == 1
#define LDEBUG(message, ...) log_message(LOG_DEBUG, message, ##__VA_ARGS__);
#else
#define LDEBUG(message, ...)
#endif

#if LOG_TRACE_ENABLED == 1
#define LTRACE(message, ...) log_message(LOG_TRACE, message, ##__VA_ARGS__);
#else
#define LTRACE(message, ...)
#endif
