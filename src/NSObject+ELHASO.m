#import "NSObject+ELHASO.h"

#import "ELHASO.h"

@implementation NSObject (ELHASO)

/** Runs a block after a specified amount of time.
 * This is just a wrapper over performSelector:withObject:afterdelay:. Based
 * on code found at
 * http://stackoverflow.com/questions/4007023/blocks-instead-of-performselectorwithobjectafterdelay,
 * which was based on Mike Ash's code. This doesn't use GDC at all, so it
 * depends on run loops and everything else related.
 *
 * Remember that since this uses a runloop to queue the block execution, this
 * has to be run from a thread with a run loop (ie. the method will assert when
 * not run from the ui thread).
 */
- (void)after:(NSTimeInterval)delay perform:(void (^)(void))block
{
	BLOCK_UI();
	block = [[block copy] autorelease];
	[self performSelector:@selector(run_block:)
		withObject:block afterDelay:delay];
}

/** Helper of after:perform:.
 * Simply runs the specified block, not very useful by itself.
 */
- (void)run_block:(void (^)(void))block
{
	block();
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
