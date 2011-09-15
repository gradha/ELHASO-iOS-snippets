#import <Foundation/Foundation.h>

/** \class NSNotificationCenter
 * Adds some shortcut wrappers.
 */
@interface NSNotificationCenter (ELHASO)

- (void)refresh_observer:(id)observer selector:(SEL)selector
	name:(NSString*)name object:(id)object;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
