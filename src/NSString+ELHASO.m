#import "NSString+ELHASO.h"

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

/** Returns the url encoded version of string.
 * Kudos to darronschall at
 * http://stackoverflow.com/questions/4814558/how-to-encode-an-url/4818363#4818363
 */
- (NSString*)urlEncode
{
	NSString *encodedString =
		(NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
			(CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]",
			kCFStringEncodingUTF8);
	return [encodedString autorelease];
}

/** Wrapper over urlEncode to parse multiple parameters.
 * This function will first split the string using whitespace, encode each
 * fragment and return them joined by plus signs, ideal for a google like URL
 * request. If your input doesn't have whitespace, this is the same as calling
 * urlEncode directly.
 */
- (NSString*)split_and_encode
{
	NSArray *parts = [self componentsSeparatedByCharactersInSet:
		[NSCharacterSet whitespaceAndNewlineCharacterSet]];

	if (parts.count < 2)
		return [self urlEncode];

	NSMutableArray *converted = [NSMutableArray arrayWithCapacity:parts.count];
	for (NSString *part in parts)
		[converted addObject:[part urlEncode]];
	return [converted componentsJoinedByString:@"+"];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
