#import "UINavigationController+ELHASO.h"

@implementation UINavigationController (ELHASO)

/** Unlike topViewController, this returns the controller at the base.
 * Returns nil if there was no controller available.
 */
- (UIViewController*)rootController
{
	if (self.viewControllers.count > 0)
		return [self.viewControllers objectAtIndex:0];

	return nil;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
