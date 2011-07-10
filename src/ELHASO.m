#import "ELHASO.H"

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
	NSString *dir_name = nil;
	NSString *path = nil;

	switch (dir_type) {
		case DIR_BUNDLE:
			path = [[NSBundle mainBundle] pathForResource:filename ofType:nil];
			dir_name = @"bundle";
			break;

		case DIR_DOCS:
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(
				NSDocumentDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			path = [documentsDirectory stringByAppendingPathComponent:filename];
			dir_name = @"doc directory";
			break;
		}

		case DIR_CACHE:
		{
			NSArray *paths = NSSearchPathForDirectoriesInDomains(
				NSCachesDirectory, NSUserDomainMask, YES);
			NSString *documentsDirectory = [paths objectAtIndex:0];
			path = [documentsDirectory stringByAppendingPathComponent:filename];
			dir_name = @"cache directory";
			break;
		}

		default:
			DLOG(@"Trying to use dir_type %d", dir_type);
			assert(0 && "Invalid get_path(dir_type).");
			return 0;
	}

	if (!path)
		DLOG(@"File '%@' not found inside %@!", filename, dir_name);

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

// vim:tabstop=4 shiftwidth=4 syntax=objc
