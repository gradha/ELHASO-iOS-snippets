#import "ELHASO.h"

#import "NSArray+ELHASO.h"

#import <assert.h>
#import <objc/runtime.h>
#import <objc/message.h>

/** Builds up the path of a file in a specific directory.
 * Note that making a path inside a DIR_BUNDLE will always fail if the file
 * doesn't exist (bundles are not allowed to be modified), while a path for
 * DIR_DOCS may succeed even if the file doesn't yet exists (useful to create
 * persistant configuration files).
 *
 * \return Returns an NSString with the path, or NULL if there was an error.
 * If you want to use the returned path with C functions, you will likely
 * call the method cStringUsingEncoding:1 on the returned object.
 */
NSString *get_path(NSString *filename, DIR_TYPE dir_type)
{
#ifdef DEBUG
	NSString *dir_name = nil;
#endif
	NSString *path = nil;

	switch (dir_type) {
		case DIR_BUNDLE:
			path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
#ifdef DEBUG
			dir_name = @"bundle";
#endif
			break;

		case DIR_DOCS:
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(
				NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths get:0];
			path = [documentsDirectory stringByAppendingPathComponent:filename];
#ifdef DEBUG
			dir_name = @"doc directory";
#endif
			break;
		}

		case DIR_CACHE:
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(
				NSCachesDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths get:0];
			path = [documentsDirectory stringByAppendingPathComponent:filename];
#ifdef DEBUG
			dir_name = @"cache directory";
#endif
			break;
		}

		case DIR_LIB:
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(
					NSLibraryDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths get:0];
			path = [documentsDirectory stringByAppendingPathComponent:filename];
#ifdef DEBUG
			dir_name = @"lib directory";
#endif
			break;
		}

		default:
			DLOG(@"Trying to use dir_type %d", dir_type);
			assert(0 && "Invalid get_path(dir_type).");
			return 0;
	}

#ifdef DEBUG
	if (!path)
		DLOG(@"File '%@' not found inside %@!", filename, dir_name);
#endif

	return path;
}

/** Swizzle function to replace methods at runtime.
 * http://stackoverflow.com/questions/1637604/method-swizzle-on-iphone-device
 */
void swizzle(Class c, SEL orig, SEL new)
{
	Method origMethod = class_getInstanceMethod(c, orig);
	Method newMethod = class_getInstanceMethod(c, new);

	if (class_addMethod(c, orig, method_getImplementation(newMethod),
			method_getTypeEncoding(newMethod))) {
		class_replaceMethod(c, new, method_getImplementation(origMethod),
			method_getTypeEncoding(origMethod));
	} else {
		method_exchangeImplementations(origMethod, newMethod);
	}
}

/** Simulates a memory warning when running under the simulator.
 * This doesn't work on non simulator environments. Idea taken from
 * http://idevrecipes.com/2011/05/04/debugging-magic-auto-simulate-memory-warnings/
 * \return Returns nonzero if the simulated memory warning was posisble.
 */
int simulate_memory_warning(void)
{
#if TARGET_IPHONE_SIMULATOR
#ifdef DEBUG
	CFNotificationCenterPostNotification(
		CFNotificationCenterGetDarwinNotifyCenter(),
		(CFStringRef)@"UISimulatedMemoryWarningNotification",
		NULL, NULL, true);
	return 1;
#endif
#endif
	return 0;
}

/** Conditional wrapper around dispatch_async_ui()
 * Sometimes you are writting code which can run in both the UI and a
 * background thread. To avoid tiresome ifs, you can run this function and pass
 * a block. If you are running on the main thread, the block will run
 * immediately, otherwise it will be queued on the main thread to run in the
 * near future.
 */
void run_on_ui(dispatch_block_t block)
{
	if ([NSThread isMainThread])
		block();
	else
		dispatch_async_ui(block);
}

/** Modified blocking version of run_on_ui().
 * This is nearly identical to run_on_ui(), the difference being that if you
 * are not running on the main thread, your code will wait for the ui thread
 * with dispatch_sync() to do what you are specifying in the block.
 *
 * Consider this a version where you want to make sure something is done on the
 * UI rather than asking the UI to do something but not caring exactly when.
 */
void wait_for_ui(dispatch_block_t block)
{
	if ([NSThread isMainThread])
		block();
	else
		dispatch_sync(dispatch_get_main_queue(), block);
}

// vim:tabstop=4 shiftwidth=4 syntax=objc
