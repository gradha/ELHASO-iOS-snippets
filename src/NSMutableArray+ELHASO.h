#import "NSArray+ELHASO.h"

/** \class NSMutableArray
 * Once you get used to the nil-forgiving NSArray+ELHASO.h categories, don't
 * you wish you had forgiving modification methods?
 */
@interface NSMutableArray (ELHASO)

- (void)append:(id)object_or_nil;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
