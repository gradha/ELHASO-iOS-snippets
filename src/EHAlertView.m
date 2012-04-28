#import "EHAlertView.h"

@implementation EHAlertView

/** Shows the alert, you can safely call this from background threads too.
 * If care is not taken to call the show method in the main thread, the alert
 * might not appear until an arbitrary time, where your application might seem
 * blocked waiting for the user popup/input.
 */
- (void)show
{
	if ([NSThread isMainThread]) {
		[super show];
	} else {
		[self performSelectorOnMainThread:@selector(show)
			withObject:nil waitUntilDone:NO];
	}
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
