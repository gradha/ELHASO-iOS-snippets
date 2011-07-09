#import <UIKit/UIKit.h>

@interface View_controller : UIViewController
{
	BOOL is_running;
}

@property (nonatomic, retain) IBOutlet UILabel *label;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *doing;

- (IBAction)start_tests;
- (IBAction)push_table;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
