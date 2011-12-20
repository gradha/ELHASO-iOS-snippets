#ifndef __ELHASO_MACRO_H__
#define __ELHASO_MACRO_H__

#import "ELHASO-types.h"

/// Returns the value var restrained to inclusive lower and higher limits.
#define MID(low,var,high)  (MIN(MAX(low, var), high))

/// Useful macro to get the number of elements in any array type.
#define DIM(x)	(sizeof((x)) / sizeof((x)[0]))

/// Environment variable shortcut, returns nil for non debug builds
#ifdef DEBUG
#define DEBUG_ENV_VAR(NAME) \
	((NSString*)[[[NSProcessInfo processInfo] environment] valueForKey:NAME])
#else
#define DEBUG_ENV_VAR(NAME) \
	((NSString*)nil)
#endif

#ifndef DLOG
/// Log only if the symbol DEBUG is defined.
#ifdef DEBUG
#define DLOG(...)			NSLog(__VA_ARGS__)
#else
#define DLOG(...)			do {} while (0)
#endif // DEBUG
#endif // DLOG

/// Log always, avoid stupid CamelCase.
#ifndef LOG
#define LOG(...)			NSLog(__VA_ARGS__)
#endif // LOG

/// Verifies if the mask value VAL is set in the variable.
#define IS_BIT(VAR,VAL)		((VAR) & (VAL))

/// Sets the mask value VAL to the variable.
#define SET_BIT(VAR,VAL)	((VAR) |= (VAL))

/// Clears the bits in mask value VAL of the variable.
#define DEL_BIT(VAR,VAL)	((VAR) &= ~(VAL))

/// Returns the emtpy string if the parameter is nil.
#define NON_NIL_STRING(VAR)	((nil == VAR) ? @"": VAR)

/// Make the default NSAssert show the expression triggering it.
#define LASSERT(COND,TEXT) \
	NSAssert(COND, @"" #COND @": " TEXT)

/// Experimenting with new runtime assert macro.
#ifdef DEBUG
#define RASSERT(COND,TEXT,EXPR)											\
	LASSERT(COND, TEXT)
#else
#define RASSERT(COND,TEXT,EXPR)											\
	if (!(COND)) {														\
		LOG(@"Runtime assertion %s, %@\nat %s:%s:%d", #COND, TEXT,		\
			__PRETTY_FUNCTION__, __FILE__, __LINE__);					\
		do {															\
			EXPR;														\
		} while (0);													\
	}
#endif

#define ASK_GETTER(OBJECT, GETTER, DEF)								\
	((![OBJECT respondsToSelector:@selector(GETTER)]) ? (DEF) :		\
		([OBJECT performSelector:@selector(GETTER)]))

#define IS_IPAD		(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/// Transforms degrees to radians. You need to import math.h.
#define DEG2RAD(X)              ((X) * M_PI / 180.0)
/// Transforms radians to degrees. You need to import math.h.
#define RAD2DEG(X)              ((X) * 180 / M_PI)

/// Maximum distance for objects, bigger than earth's diameter.
#define MAX_DISTANCE		(20000 * 1000)

/// Handy shortcut for all flexible margins in a view's autoresizingMask.
#define FLEXIBLE_MARGINS \
	(UIViewAutoresizingFlexibleTopMargin | \
	UIViewAutoresizingFlexibleBottomMargin | \
	UIViewAutoresizingFlexibleLeftMargin | \
	UIViewAutoresizingFlexibleRightMargin)

/// Handy shortcut for flexible size in a view's autoresizingMask.
#define FLEXIBLE_SIZE \
	(UIViewAutoresizingFlexibleHeight | \
	UIViewAutoresizingFlexibleWidth)

/// Stick this in code you want to assert if run on the main UI thread.
#define DONT_BLOCK_UI() \
	NSAssert(![NSThread isMainThread], @"Don't block the UI thread please!")

/// Stick this in code you want to assert if run on a background thread.
#define BLOCK_UI() \
	NSAssert([NSThread isMainThread], @"You aren't running in the UI thread!")

/// Size of the default scroll view scroll indicator.
#define SCROLLBAR_WIDTH			7

/// Handy macro to type less in viewDidUnload-like methods.
#define UNLOAD_VIEW(VAR) do {\
		[VAR removeFromSuperview];\
		[VAR release];\
		VAR = nil;\
	} while(0)

/// Like UNLOAD_VIEW() but for non-view objects.
#define UNLOAD_OBJECT(VAR) do {\
		[VAR release];\
		VAR = nil;\
	} while(0)

/// Safe casting of id objects to some other class type, returns nil on failure.
#define CAST(OBJ,CLASS) \
	(([(OBJ) isKindOfClass:[CLASS class]]) ? (CLASS*)((OBJ)) : nil)


/// Shortcut GCD macros to type less.
#define dispatch_async_low(BLOCK) \
	dispatch_async( \
		dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), BLOCK)

#define dispatch_async_default(BLOCK) \
	dispatch_async( \
		dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), BLOCK)

#define dispatch_async_high(BLOCK) \
	dispatch_async( \
		dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), BLOCK)

#define dispatch_async_ui(BLOCK) \
	dispatch_async(dispatch_get_main_queue(), BLOCK)


/// Prototypes of some miscelaneous C functions.
NSString *get_path(NSString *filename, DIR_TYPE dir_type);
void swizzle(Class c, SEL orig, SEL new);
int simulate_memory_warning(void);
void run_on_ui(dispatch_block_t block);
void wait_for_ui(dispatch_block_t block);

#endif // __ELHASO_MACRO_H__

// vim:tabstop=4 shiftwidth=4 syntax=objc
