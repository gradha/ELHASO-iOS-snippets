#import "App_delegate.h"

@implementation App_delegate

@synthesize window;
@synthesize nav;


- (BOOL)application:(UIApplication *)application
	didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	// Add the view controller's view to the window and display.
	[self.window addSubview:nav.view];
	[self.window makeKeyAndVisible];

	return YES;
}


- (void)dealloc
{
	[nav release];
	[window release];
	[super dealloc];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
