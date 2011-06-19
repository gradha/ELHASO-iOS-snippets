#import "categories/NSString+ELHASO.h"

@implementation NSString (ELHASO)

/** Returns an URL with the last component removed.
 * Based on code found at:
 * http://stackoverflow.com/questions/1682919/removing-url-fragment-from-nsurl.
 */
- (NSString *)stringByRemovingFragment
{
	// Find that last component in the string from the end to
	// make sure to get the last one
	NSRange fragmentRange = [self rangeOfString:@"/" options:NSBackwardsSearch];
	if (fragmentRange.location != NSNotFound) {
	    // Chop the fragment.
	    return [self substringToIndex:fragmentRange.location];
	} else {
	    return self;
	}
}

/** Checks if the URL contained in the string is absolute.
 * Yet another perverted hack of the NSString class!
 * \return Returns YES if the URL is relative.
 */
- (BOOL)isRelativeURL
{
	NSURL *check_url = [NSURL URLWithString:self];
	return ([[check_url host] length] < 1);
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
