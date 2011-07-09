#import <Foundation/Foundation.h>

/** \class NSString
 * Appends some custom helpers to NSString for URL management.
 */
@interface NSString (ELHASO)

- (NSString*)stringByRemovingFragment;
- (BOOL)isRelativeURL;
- (NSString*)urlEncode;
- (NSString*)split_and_encode;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
