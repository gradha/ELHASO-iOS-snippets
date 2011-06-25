#import <UIKit/UIKit.h>

@class View_controller;

@interface App_delegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
	View_controller *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet View_controller *viewController;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
