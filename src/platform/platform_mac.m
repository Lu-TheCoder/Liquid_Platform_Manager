//C99 IMPORTS
#include "platform.h"
#include "platform_logger.h"

#ifdef __APPLE__

//OBJECTIVE C - IMPORTS
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>
#import <QuartzCore/CVDisplayLink.h>
#import <QuartzCore/CAMetalLayer.h>


CVReturn displayCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext);
static void platform_console_write_file(FILE* file, const char* message, int colour);

typedef struct internal_state internal_state;

typedef struct LiquidDisplayRefreshEvent {
	internal_state* handle;
	uint64_t delta;
	uint64_t now;
	uint64_t timeUntilDisplay;
} LiquidDisplayRefreshEvent;


typedef struct internal_state{
    void* window;
    void* view;

    void* displayLink;

    //display link
	void (*displayRefreshCallback)(LiquidDisplayRefreshEvent e);
	
}internal_state;

bool isAppRunning = false;

@interface ApplicationDelegate : NSObject <NSApplicationDelegate>
@end

@implementation ApplicationDelegate
// - (void)windowWillClose:(id)sender {

// }

-(void)applicationDidFinishLaunching:(NSNotification *)notification
{
@autoreleasepool {

	NSEvent* event = [NSEvent otherEventWithType:NSEventTypeApplicationDefined
										location:NSMakePoint(0, 0)
								   modifierFlags:0
										timestamp:0
									windowNumber:0
										context:nil
										subtype:0
											data1:0
											data2:0];
	[NSApp postEvent:event atStart:YES];
	
	[NSApp stop:self];
	NSLog(@"Finished Loading Window!");
} // autoreleasepool
}
@end


@interface View : NSView
{
	internal_state* handle;
}

-(instancetype) initWithHandle:(internal_state*) state Frame:(NSRect)frame;

- (BOOL)acceptsFirstMouse:(NSEvent *)event;

- (void)keyDown:(NSEvent *)event;
- (void)keyUp:(NSEvent *)event;

- (void)mouseEntered:(NSEvent *)event;
- (void)mouseExited:(NSEvent *)event;

- (void)mouseDown:(NSEvent *)event;
- (void)mouseMoved:(NSEvent *)event;
- (void)mouseUp:(NSEvent *)event;
- (void)rightMouseDown:(NSEvent *)event;
- (void)rightMouseUp:(NSEvent *)event;
- (void)otherMouseDown:(NSEvent *)event;
- (void)otherMouseUp:(NSEvent *)event;

- (void)scrollWheel:(NSEvent *)event;
@end

@implementation View

-(instancetype) initWithHandle:(internal_state*) state Frame:(NSRect)frame 
{
	
    self = [super initWithFrame:frame];
	if(self)
	{
		handle = state;
		//for mouseEnter/Exit
		[self addTrackingRect:frame owner:self userData:nil assumeInside:NO];
	}
	return self;
}

-(BOOL)acceptsFirstResponder
{
	return YES;
}

- (BOOL)acceptsFirstMouse:(NSEvent *)event
{
	return YES;
}

- (void)keyDown:(NSEvent *)event
{
    uint16 keyCode = [event keyCode];
    LINFO("Key pressed: '%i'\n", keyCode);

	// if(handle->keyDownCallback) {
	// 	PTLKeyDownEvent e = {handle, [event keyCode], [event isARepeat], [event modifierFlags]};
	// 	handle->keyDownCallback((PTLKeyDownEvent)e);
	// }
}
- (void)keyUp:(NSEvent *)event
{
    uint16 keyCode = [event keyCode];
    LINFO("Key up: '%i'\n", keyCode);
	// if(handle->keyUpCallback)
	// 	handle->keyUpCallback((PTLKeyUpEvent){handle, [event keyCode], [event isARepeat], [event modifierFlags]});
}
- (void)mouseEntered:(NSEvent *)event
{
    //NSLog(@"Mouse Entered at: (%f;%f)\n", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseEnterCallback)
	// 	handle->mouseEnterCallback((PTLMouseEnterEvent){handle, [event locationInWindow].x, [event locationInWindow].y, 1});
}
- (void)mouseExited:(NSEvent *)event
{
    //NSLog(@"Mouse Exited at: (%f;%f)\n", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseEnterCallback)
	// 	handle->mouseEnterCallback((PTLMouseEnterEvent){handle, [event locationInWindow].x, [event locationInWindow].y, 0});
}
- (void)mouseDown:(NSEvent *)event
{
   // NSLog(@"Mouse Down at: (%f;%f)\n", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseDownCallback)
	// 	handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)mouseMoved:(NSEvent *)event
{
   // NSLog(@"Mouse Moved: (%f;%f)\n", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseMoveCallback)
	// 	handle->mouseMoveCallback((PTLMouseMoveEvent){handle, [event locationInWindow].x, [event locationInWindow].y});
	
	// if(handle->mouseDeltaCallback)
	// 	handle->mouseDeltaCallback((PTLMouseDeltaEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event deltaX], [event deltaY]});
}
- (void) mouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)mouseUp:(NSEvent *)event
{
   // NSLog(@"Mouse Up at: (%f;%f)", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseUpCallback)
	// 	handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)rightMouseDown:(NSEvent *)event
{
   // NSLog(@"Right Mouse Down at: (%f;%f)", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseDownCallback)
	// 	handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)rightMouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)rightMouseUp:(NSEvent *)event
{
    //NSLog(@"Right Mouse Up at: (%f;%f)", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseUpCallback)
	// 	handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)otherMouseDown:(NSEvent *)event
{
    //NSLog(@"Other Mouse Down at: (%f;%f)", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseDownCallback)
	// 	handle->mouseDownCallback((PTLMouseDownEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}
- (void)otherMouseDragged:(NSEvent *)event
{
	[self mouseMoved:event];
}
- (void)otherMouseUp:(NSEvent *)event
{
   // NSLog(@"Other Mouse Up at: (%f;%f)", [event locationInWindow].x, [event locationInWindow].y);
	// if(handle->mouseUpCallback)
	// 	handle->mouseUpCallback((PTLMouseUpEvent){handle, [event locationInWindow].x, [event locationInWindow].y, [event buttonNumber]});
}

- (void)scrollWheel:(NSEvent *)event
{

   // NSLog(@"Mouse ScrollWheel Deltas: (%f;%f)", [event scrollingDeltaX], [event scrollingDeltaY]);
	// if(handle->scrollCallback)
	// {
	// 	double dx =[event scrollingDeltaX];
	// 	double dy =[event scrollingDeltaY];
	// 	if(![event hasPreciseScrollingDeltas])
	// 	{
	// 		dx *= 0.1;
	// 		dy *= 0.1;
	// 	}
	// 	handle->scrollCallback((PTLMouseScrollEvent){handle, [event locationInWindow].x, [event locationInWindow].y, dx, dy});
	// }
}

@end

@interface Window : NSWindow <NSWindowDelegate>

{
    internal_state* handle;
}


-(instancetype)initWithHandle:(internal_state*)state Width:(int)width Height:(int)height Title:(NSString*)title Mask:(int)mask;

@end


@implementation Window

-(instancetype)initWithHandle:(internal_state*)state Width:(int)width Height:(int)height Title:(NSString*)title Mask:(int)mask
{
    NSRect screenRect = [[NSScreen mainScreen] frame];
    NSRect windowSize = NSMakeRect((screenRect.size.width - width) * 0.5,
                                         (screenRect.size.height - height) * 0.5,
                                         width,
                                         height);
    self = [super initWithContentRect:windowSize styleMask:(NSWindowStyleMask)mask backing:NSBackingStoreBuffered defer:YES];
    if(self){
        static int windowIndex = 0;

        handle = state;
        self.title = title;
        self.hasShadow = YES;
        self.delegate = self;
        [self center];

        //Only first window gets a display link
        if(windowIndex == 0){
            CVDisplayLinkRef ref;
			CVDisplayLinkCreateWithActiveCGDisplays(&ref);
			CVDisplayLinkSetOutputCallback(ref, displayCallback, handle);
			CVDisplayLinkStart(ref);
			self->handle->displayLink = ref;
        }
        windowIndex++;
    }
    return self;
}

- (void)windowDidResize:(NSNotification *)notification
{
    LINFO("Window Resized: (%i;%i)\n", (uint32_t)self.frame.size.width, (uint32_t)self.frame.size.height);
	// if(handle->windowResizeCallback)
	// 	handle->windowResizeCallback((PTLWindowResizeEvent){handle, (uint32_t)self.frame.size.width, (uint32_t)self.frame.size.height});
	[self.contentView setFrameSize:self.frame.size];
}
- (void)windowDidMiniaturize:(NSNotification *)notification
{
	LINFO("Window Miniaturized.");
	// if(handle->windowMinimizeCallback)
	// 	handle->windowMinimizeCallback((PTLWindowMinimizeEvent){handle, 1});
}
- (void)windowDidDeminiaturize:(NSNotification *)notification
{
	LINFO("Window Deminiaturize.");
	// if(handle->windowMinimizeCallback)
	// 	handle->windowMinimizeCallback((PTLWindowMinimizeEvent){handle, 0});
}
-(void)windowDidBecomeKey:(NSNotification *)notification
{
     LINFO("Window Gained Focus.");
	// if(handle->windowFocusCallback)
	// 	handle->windowFocusCallback((PTLWindowFocusEvent){handle, 1});
}
-(void)windowDidResignKey:(NSNotification *)notification
{
     LINFO("Window Lost Focus.");
	// if(handle->windowFocusCallback)
	// 	handle->windowFocusCallback((PTLWindowFocusEvent){handle, 0});
}
- (BOOL)windowShouldClose:(NSWindow *)sender
{
     LINFO("Closing Window...");

     isAppRunning = false;
	// if(handle->windowCloseCallback)
	// 	handle->windowCloseCallback((PTLWindowCloseEvent){handle});

	[NSApp removeWindowsItem:self];
	return YES;
}
@end


CVReturn displayCallback(CVDisplayLinkRef displayLink, const CVTimeStamp *inNow, const CVTimeStamp *inOutputTime, CVOptionFlags flagsIn, CVOptionFlags *flagsOut, void *displayLinkContext)
{
	static uint64_t lastTime;
	if(((internal_state*)displayLinkContext)->displayRefreshCallback)
	{
		((internal_state*)displayLinkContext)->displayRefreshCallback((LiquidDisplayRefreshEvent){(internal_state*)displayLinkContext, (inNow->hostTime - lastTime), inNow->hostTime, (inOutputTime->hostTime - inNow->hostTime)});
	}
	lastTime = inNow->hostTime;
	return kCVReturnSuccess;
}

//Initializes the platform layer
bool platform_init(platform_state* state, const char* app_name, int width, int height){
    state->internal_state = calloc(1, sizeof(internal_state));
    internal_state* i_state = (internal_state*)state->internal_state;

    @autoreleasepool {
			
	//create the NSApp
	[NSApplication sharedApplication];
		
	//this allows the app to appear in dock, have menu, and have UI
	[NSApp setActivationPolicy:NSApplicationActivationPolicyRegular];
	
	//setup app delegate to be released at end of function.
	ApplicationDelegate* delegate = [[ApplicationDelegate alloc] init];
	[NSApp setDelegate:delegate];
	
	//run app
	[NSApp run];
    }//autoreleasepool
    
    Window* window = [[Window alloc] initWithHandle:i_state Width:width Height:height Title:[NSString stringWithUTF8String:app_name] Mask:NSWindowStyleMaskTitled |
                                                                            NSWindowStyleMaskClosable |
                                                                            NSWindowStyleMaskMiniaturizable |
                                                                            NSWindowStyleMaskResizable];

    View* view = [[View alloc] initWithHandle:i_state Frame:NSMakeRect(0, 0, width, height)];

    [window setBackgroundColor: NSColor.redColor];
    [window setContentView:view];
	[window makeKeyAndOrderFront:nil];
	[window setAcceptsMouseMovedEvents:YES];

    i_state->window = (void *)window;
	i_state->view = (void*)view;
    state->isRunning = true;
    isAppRunning = true;

	LDEBUG("Initialized Platform.");
    return true;
}

//Shutsdown and destroys the platform layer
void platform_shutdown(platform_state* state){
    state->isRunning = false;
    isAppRunning = false;
    state->internal_state = calloc(1, sizeof(internal_state));
    internal_state* i_state = (internal_state*)state->internal_state;
    
    free(i_state->window);
    
	LDEBUG("Platfrom Shutdown Successfully.");
}

//Listens to events/platform messages
bool platform_poll_events(platform_state* state){
    @autoreleasepool {
        NSEvent* Event;

        while(isAppRunning){
            Event = [NSApp nextEventMatchingMask: NSEventMaskAny
                                                untilDate: nil
                                                inMode: NSDefaultRunLoopMode
                                                dequeue: YES];
            
            uint16 keyCode = 0;
            switch([Event type]){
                default:
                [NSApp sendEvent: Event];
            }
        }
        state->isRunning = false;
    }
    return true;
}

//Gets the platform specific time
float platform_get_absolute_time(){
    return 0;
}

static void platform_console_write_file(FILE* file, const char* message, int colour) {
    // Colours: FATAL, ERROR, WARN, INFO, DEBUG, TRACE.
    const char* colour_strings[] = {"0;41", "1;31", "1;33", "1;32", "1;34", "1;36"};
    fprintf(file, "\033[%sm%s\033[0m", colour_strings[colour], message);
}

//Writes messages to the platform console
void platform_console_write(const char* message, int colour){
	platform_console_write_file(stdout, message, colour);
}

//Writes messages to the platform console
void platform_console_write_error(const char* message, int colour){
    platform_console_write_file(stderr, message, colour);
}

#endif // APPLE PLATFORM
