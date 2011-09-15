#import "NSNotificationCenter+ELHASO.h"

@implementation NSNotificationCenter (ELHASO)

/** Adds an observer, previously removing one if it existed.
 * It is very handy to add an observer in the loadView method, but that has the
 * problem of views being unloaded in tight memory situations and the observers
 * not being unlinked. Then, the next time loadView is called, you add another
 * time yourself as observer, and get called twice. Repeat ad libitum.
 *
 * This method will first remove the observer for the specified parameters,
 * then add it, preventing multiple listeners for the same thing.
 */
- (void)refresh_observer:(id)observer selector:(SEL)selector
	name:(NSString*)name object:(id)object
{
	[self removeObserver:observer name:name object:object];
	[self addObserver:observer selector:selector name:name object:nil];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
