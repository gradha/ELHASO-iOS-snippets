//
//  ExampleViewController.m
//  Example
//
//  Created by Grzegorz Adam Hankiewicz on 19/06/11.
//  Copyright 2011 Electric Hands Software. All rights reserved.
//

#import "ExampleViewController.h"

@implementation ExampleViewController

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
	[self performSelector:@selector(run_tests) withObject:nil afterDelay:1];
}

- (void)run_tests
{
	[doing stopAnimating];
	self.label.text = @"Did run all!";
	is_running = NO;
}

@end
