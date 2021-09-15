# Liquid_Platform_Manager

A Cross-Platform Window Manager similar to GLFW written in **C99**

**---- How To Show A Window ----**

1. Initialize the platform layer
1. Create a loop to poll for events
1. destroy the window when no longer needed

**Platform_Init()**
Initializes the platform layer and returns true on success:
```c
bool platform_init(platform_state* state, const char* app_name, int width, int height);
```


**Platform_Poll_Events()**
Listens for platform-specific messages/events: 
```c
bool platform_poll_events(platform_state* state);
```


**Platform_Shutdown()**
Destroys the platform instance and free's any memory if any has been allocated:
```c
bool platform_shutdown(platform_state* state);
```


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
* It contains a `void pointer*` to the `internal_state` which contains further information.
* It also contains a global variable of type `bool`, `isRunning` which holds true if platform is actively running or false if it is not.


# Supported Platforms

Platforms|Support Status
----------|------------
MacOS | Supported
Windows | Pending
Linux | Pending

# Tasks 
This project is not completed and thus further updates will still be issued.
Here are some of the main tasks that still need to be completed.

- [x] ~~Add Mac Support~~
- [ ] Add Windows Support
- [ ] Add Linux Support
- [ ] Add Support for any Graphics Pipeline (Vulkan, OpengGL, DirectX) etc.
- [ ] Add Flexible Event System