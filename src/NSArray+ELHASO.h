#import <Foundation/Foundation.h>

/** \class NSArray
 * Aren't you tired of using a long objectAtIndex method which on
 * top of being long to type fails when you get out of bounds?
 */
@interface NSArray (ELHASO)

- (id)get:(NSInteger)pos;
- (id)get_non_null:(NSInteger)pos;
- (NSMutableArray*)get_holder;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
