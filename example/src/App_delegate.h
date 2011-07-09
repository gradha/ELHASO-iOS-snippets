#import <UIKit/UIKit.h>

@class View_controller;

@interface App_delegate : NSObject <UIApplicationDelegate>
{
	UIWindow *window;
	UINavigationController *nav;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *nav;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
