#import "UIActivity.h"

@implementation UIActivity

/** Returns an autoreleased already spinning white large indicator view.
 */
+ (UIActivity*)get_white_large
{
	UIActivity *activity = [[UIActivity alloc]
		initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	[activity startAnimating];
	return [activity autorelease];
}

/** Returns an autoreleased already spinning white indicator view.
 */
+ (UIActivity*)get_white
{
	UIActivity *activity = [[UIActivity alloc]
		initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	[activity startAnimating];
	return [activity autorelease];
}

/** Returns an autoreleased already spinning gray indicator view.
 */
+ (UIActivity*)get_gray
{
	UIActivity *activity = [[UIActivity alloc]
		initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	[activity startAnimating];
	return [activity autorelease];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
