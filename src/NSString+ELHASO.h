#import <Foundation/Foundation.h>

/** \class NSString
 * Appends some custom helpers to NSString for URL management.
 */
@interface NSString (ELHASO)

- (NSString*)stringByRemovingFragment;
- (BOOL)isRelativeURL;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
