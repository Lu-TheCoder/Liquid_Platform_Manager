#pragma once

#include <stdbool.h>
#include <stdio.h>

typedef enum LOG_LEVEL{
    FATAL = 0,
    ERROR = 1,
    WARN = 2,
    INFO = 3,
    DEBUG = 4,
    TRACE = 5
}LOG_LEVEL;

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
