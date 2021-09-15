#include <stdio.h>
#include "platform/platform.h"


int main(){

    platform_state state;
    if(platform_init(&state, "Liquid Window", 200, 200)){
        while(state.isRunning){
            platform_poll_events(&state);
        }
    }
    platform_shutdown(&state);

    return 0;
}