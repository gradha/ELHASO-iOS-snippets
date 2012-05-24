#import "EHTimer.h"

#import "ELHASO.h"
#import "MAZeroingWeakRef.h"


@interface EHTimer ()
/// The timer object.
@property (nonatomic, retain) NSTimer *timer;
/// The actual weak reference object to the delegate.
@property (nonatomic, retain) MAZeroingWeakRef *delegate;
/// The action to perform on the weak reference.
@property (nonatomic, assign) SEL action;
@end


@implementation EHTimer

@synthesize action = action_;
@synthesize delegate = delegate_;
@synthesize timer = timer_;

#pragma mark -
#pragma mark Life

/** Constructor, see the docs for the NSTimer constructor.
 * The only difference with regard to that method is that target will be
 * referenced weakly through a MAZeroingWeakRef object. The userInfo is still
 * retained as usual.
 */
- (id)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds
	target:(id)target selector:(SEL)aSelector userInfo:(id)userInfo
	repeats:(BOOL)repeats
{
	LASSERT([target respondsToSelector:aSelector], @"Invalid target/selector");
	if (!(self = [super init]))
		return nil;

	self.action = aSelector;
	self.delegate = [[[MAZeroingWeakRef alloc]
		initWithTarget:target] autorelease];
	if (!self.delegate) {
		DLOG(@"Couldn't create weak ref for %@", target);
		[self release];
		return nil;
	}

	self.timer = [[[NSTimer alloc] initWithFireDate:date
		interval:seconds target:self selector:@selector(fire_action:)
		userInfo:userInfo repeats:repeats] autorelease];
	if (!self.timer) {
		DLOG(@"Couldn't create timer for %@", target);
		[self release];
		return nil;
	}

	return self;
}

- (void)dealloc
{
	[timer_ invalidate];
	[timer_ release];
	[delegate_ release];
	[super dealloc];
}

#pragma mark -
#pragma mark Methods

/// Wrapper around NSTimer::fire.
- (void)fire
{
	[self.timer fire];
}

/// Wrapper around NSTimer::invalidate.
- (void)invalidate
{
	[self.timer invalidate];
}

/// Performs the fire action, if the weak reference is valid.
- (void)fire_action:(NSTimer*)theTimer
{
	id target = [self.delegate target];
	if (target)
		[target performSelector:self.action withObject:theTimer];
	else
		DLOG(@"Weak target for EHTimer %@ expired", self);
}

/** Wrapper to add the current timer to the runloop.
 * The wrapper adds the timer object rather than self.
 */
- (void)addToRunLoop:(NSRunLoop*)runloop forMode:(NSString*)mode
{
	[runloop addTimer:self.timer forMode:mode];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
