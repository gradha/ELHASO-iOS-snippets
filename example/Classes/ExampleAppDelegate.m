//
//  ExampleAppDelegate.m
//  Example
//
//  Created by Grzegorz Adam Hankiewicz on 19/06/11.
//  Copyright 2011 Electric Hands Software. All rights reserved.
//

#import "ExampleAppDelegate.h"
#import "ExampleViewController.h"

@implementation ExampleAppDelegate

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
