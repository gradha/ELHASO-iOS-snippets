//
//  ExampleViewController.m
//  Example
//
//  Created by Grzegorz Adam Hankiewicz on 19/06/11.
//  Copyright 2011 Electric Hands Software. All rights reserved.
//

#import "View_controller.h"

#import "ELHASO.h"
#import "NSArray+ELHASO.h"

@implementation View_controller

@synthesize label;
@synthesize doing;

- (void)dealloc
{
	[label dealloc];
	[doing dealloc];
	[super dealloc];
}

- (void)viewDidLoad
{
	self.label.text = @"";
}

- (void)start_tests
{
	if (is_running)
		return;

	is_running = YES;
	[doing startAnimating];
	self.label.text = @"";
	[self performSelector:@selector(run_tests) withObject:nil afterDelay:0];
}

- (void)run_tests
{
	LOG(@"Running the test suite...");

	// Testing log macros.
	DLOG(@"This message only seen if you are on your DEBUG build");
	LOG(@"This message seen always, did you see the previous DEBUG one?");

	// Testing NON_NIL_STRING and NSArray getter.
	NSArray *t1 = [NSArray arrayWithObject:@"Test"];
	LOG(@"Getting first entry of NSArray '%@'", [t1 get:0]);
	LOG(@"Getting bad entry of NSArray '%@'", [t1 get:1]);
	LOG(@"Repeating with NON_NIL_STRING '%@'",
		NON_NIL_STRING([t1 get:1]));

	[doing stopAnimating];
	self.label.text = @"Did run all!";
	is_running = NO;
}

@end
