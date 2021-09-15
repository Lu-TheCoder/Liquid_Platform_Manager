#include <stdbool.h>
#include <stdio.h>

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
void platform_console_write();

//Writes messages to the platform console
void platform_console_write_error();
