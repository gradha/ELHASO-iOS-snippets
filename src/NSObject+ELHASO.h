#import <Foundation/Foundation.h>

/** \class NSObject
 * Appends some custom helpers to NSObject for block shortcuts.
 */
@interface NSObject (ELHASO)

- (void)after:(NSTimeInterval)delay perform:(void (^)(void))block;
- (void)run_block:(void (^)(void))block;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
