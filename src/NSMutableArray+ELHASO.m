#import "NSMutableArray+ELHASO.h"

#import "ELHASO.h"

@implementation NSMutableArray (ELHASO)

/// Adds the object to the array only if it is not nil.
- (void)append:(id)object_or_nil
{
	if (object_or_nil)
		[self addObject:object_or_nil];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
