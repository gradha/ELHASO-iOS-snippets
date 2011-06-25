#import "App_delegate.h"
#import "View_controller.h"

@implementation App_delegate

@synthesize window;
@synthesize viewController;


- (BOOL)application:(UIApplication *)application
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Override point for customization after application launch.

	// Add the view controller's view to the window and display.
	[self.window addSubview:viewController.view];
	[self.window makeKeyAndVisible];

	return YES;
}


- (void)dealloc
{
	[viewController release];
	[window release];
	[super dealloc];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
