#import "categories/NSArray+ELHASO.h"

#import "macro.h"

@implementation NSArray (ELHASO)

/** Returns the object at the specified position or nil.
 * Out of bound errors are logged if negative, or ignored when positive. This
 * method doesn't perform any synchronisation on the array, so don't use it if
 * the array may be modified underneath.
 */
- (id)get:(int)pos
{
	if (pos < 0) {
		DLOG(@"Trying to get negative index from array, got nil.");
		return nil;
	}
	if (pos >= self.count) {
		//DLOG(@"Tried to get index %d out of %d elements, got nil.",
			//pos, self.count);
		return nil;
	}

	return [self objectAtIndex:pos];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
