#pragma once

#include <stdbool.h>
#include <stdio.h>

#if defined(_DEBUG)
#define RELEASE_BUILD 1
#else
#define RELEASE_BUILD 0
#endif

#define LOG_WARN_ENABLED 1
#define LOG_INFO_ENABLED 1
#define LOG_DEBUG_ENABLED 1
#define LOG_TRACE_ENABLED 1

#if RELEASE_BUILD
#define LOG_DEBUG_ENABLED 0
#define LOG_TRACE_ENABLED 0
#endif

typedef struct platform_state{
    void* internal_state;
    bool isRunning;
}platform_state;

//Initializes the platform layer
bool platform_init(platform_state* state, const char* app_name, int width, int height);

//Shutsdown and destroys the platform layer
void platform_shutdown(platform_state* state);

//Listens to events/platform messages
bool platform_poll_events(platform_state* state);

//Gets the platform specific time
float platform_get_absolute_time();

//Writes messages to the platform console
void platform_console_write(const char* message, int colour);

//Writes messages to the platform console
void platform_console_write_error(const char* message, int colour);
