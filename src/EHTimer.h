@class NSDate;
@class NSRunLoop;
@class NSTimer;

/** \class EHTimer
 * Wraps an NSTimer using a MAZeroingWeakRef object for the target to avoid
 * creating retain cycles mainly for UIViewController classes. This is not a
 * subclass because NSTimer specifies to not try to subclass it.
 *
 * Note that you still have to remember to release the EHTimer for repeated
 * timers, the use of the weak reference against the target only prevents the
 * retain cycle from the dealloc method being called on the target. In that
 * dealloc you should clean the timer (or somewhere else).
 */
@interface EHTimer : NSObject

- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds
	target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo
	repeats:(BOOL)repeats;

- (void)fire;
- (void)invalidate;
- (void)addToRunLoop:(NSRunLoop*)runloop forMode:(NSString*)mode;
- (NSTimer*)timer;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
