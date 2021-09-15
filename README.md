# Liquid_Platform_Manager

A Cross-Platform Window Manager similar to GLFW

**---- How To Show A Window ----**

1. Initialize the platform layer
1. Create a loop to poll for events
1. destroy the window when no longer needed

**Platform_Init()**
```c
bool platform_init(platform_state* state, const char* app_name, int width, int height);
```
Initializes the platform layer and returns true on success

**Platform_Poll_Events()**
```c
bool platform_poll_events(platform_state* state);
```
Listens for platform-specific messages/events 

**Platform_Shutdown()**
```c
bool platform_shutdown(platform_state* state);
```
Destroys the platform instance and free's any memory if any has been allocated

**BASIC EXAMPLE OF HOW TO CREATE A WINDOW**

```c
int main(){

    platform_state state;
    if(platform_init(&state, "Basic Window", 640, 400)){
        while(state.isRunning){
            platform_poll_events(&state);
        }
    }
    platform_shutdown(&state);

    return 0;
}
```

**Platform_State?**

This is a structure that holds two variables.
* It contains a `void pointer*` to the `internal_state` which contains further information * It also contains a global variable of type `bool`, `isRunning` which holds true if platform is actively running or false if it is not.