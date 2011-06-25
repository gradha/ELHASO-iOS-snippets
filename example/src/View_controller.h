//
//  ExampleViewController.h
//  Example
//
//  Created by Grzegorz Adam Hankiewicz on 19/06/11.
//  Copyright 2011 Electric Hands Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExampleViewController : UIViewController
{
	BOOL is_running;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *doing;

- (IBAction)start_tests;

@end

