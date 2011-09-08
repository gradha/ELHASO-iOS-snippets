#import "NSArray+ELHASO.h"

#import "ELHASO.h"

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

/** Similar to get, but turns NSNull objects into nil values.
 * This is an additional wrapper on top of get:, useful when you deal with
 * sparse arrays. These tend to be of NSMutableArray class where for the empty
 * slots you put in an NSNull object. At a later time you will exchange the
 * NSNull object with something else. But in the meantime you don't want to
 * bother with tiresome NSNull checks.
 *
 * \return Returns nil if the object at the position is an NSNull object, or
 * the object get: would return otherwise.
 */
- (id)get_non_null:(int)pos
{
	NSObject *something = [self get:pos];
	if ([something isKindOfClass:[NSNull class]])
		return nil;
	else
		return something;
}

/** This method calls [NSMutable arrayWithCapacity] with the current capacity.
 * Note that if you are calling this on a nil pointer you will get nil
 * returned, so maybe this is not the method you are looking for! Also, a
 * minimum capacity of 4 will always be used.
 */
- (NSMutableArray*)get_holder
{
	return [NSMutableArray arrayWithCapacity:MIN(4, self.count)];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
