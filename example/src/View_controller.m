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
#import "NSString+ELHASO.h"
#import "UIImage+ELHASO.h"
#import "UIImageView+ELHASO.h"
#import "UILabel+ELHASO.h"


#define LOGO_FILENAME		@"electric_hands_software_hand_logo.jpg"

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

- (void)run_nsarray_tests
{
	NSArray *t1 = [NSArray arrayWithObject:@"Test"];
	LOG(@"Getting first entry of NSArray '%@'", [t1 get:0]);
	LOG(@"Getting out of bonds entry of NSArray '%@'", [t1 get:1]);
	LOG(@"Repeating with NON_NIL_STRING '%@'",
		NON_NIL_STRING([t1 get:1]));
}

- (void)run_nsstring_tests
{
	NSArray *strings = [NSArray arrayWithObjects:@"http://elhaso.com/blah",
		@"http://elhaso.com/subhunt/index.en.html", @"../i/logo.png", nil];

	for (NSString *url in strings) {
		LOG(@"Url '%@'", url);
		LOG(@"\tbase url: %@", [url stringByRemovingFragment]);
		LOG(@"\tis relative? %@", [url isRelativeURL] ? @"Yes" : @"No");
	}
}

- (void)run_image_tests
{
	UIImageView *logo = [UIImageView imageNamed:LOGO_FILENAME];
	RASSERT(logo, @"Didn't load UIImageView!", return);
	LOG(@"UIImageView with %@", logo.image);

	CGSize size = CGSizeMake(30, 30);
	UIImage *smaller = [logo.image scale_to:size proportional:YES];
	LOG(@"Smaller logo scaled to %0.0fx%0.0f",
		smaller.size.width, smaller.size.height);

	size = CGSizeMake(300, 90);
	UIImage *bigger = [logo.image scale_to:size proportional:YES];
	LOG(@"Bigger logo scaled to %0.0fx%0.0f",
		bigger.size.width, bigger.size.height);
}

- (void)run_label_tests
{
	UIView *round = [UILabel round_text:@"Test"
		bounds:CGRectMake(0, 0, 100, 100) fit:YES radius:10];
	LOG(@"You might not have noticed, but I just created a rounded label!");
	LOG(@"%@", ASK_GETTER(round, recursiveDescription, nil));
}

- (void)run_tests
{
	LOG(@"Running the test suite...");

	// Testing some macros.
	DLOG(@"This message only seen if you are on your DEBUG build");
	LOG(@"This message seen always, did you see the previous DEBUG one?");
	LOG(@"Now we show a nil '%@' and a non-nil '%@' string.",
		nil, NON_NIL_STRING(nil));

	[self run_nsarray_tests];
	[self run_nsstring_tests];
	[self run_image_tests];
	[self run_label_tests];

	[doing stopAnimating];
	LOG(@"Finished all tests!");
	self.label.text = @"Did run all, check the log!";
	is_running = NO;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
