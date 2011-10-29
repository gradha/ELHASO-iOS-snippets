#import "NSDictionary+ELHASO.h"

#import "Base64+ELHASO.h"
#import "ELHASO.h"

#import <UIKit/UIKit.h>


@implementation NSDictionary (ELHASO)

/** Returns an UIImage from the dictionary.
 * The UIImage is presumed to be base64 encoded as a string.
 * Returns nil if there were problems. Retain the image if you need it.
 */
- (UIImage*)get_image:(NSString*)key def:(UIImage*)def
{
	NSString* base64 = [self get_string:key def:nil];
	if (base64)
		return [UIImage imageWithData:Base64_decode(base64)];
	else
		return nil;
}

/** Returns an UIImage from the dictionary for retina displays.
 * By default base64 decoded images are returned for the normal
 * scale. This wrapper will regenerate the image with a scale of 2.0
 * for retina displays.
 */
- (UIImage*)get_image_2x:(NSString*)key def:(UIImage*)def
{
	UIImage *image = [self get_image:key def:def];
	if (!image)
		return nil;

	RASSERT([image
		respondsToSelector:@selector(initWithCGImage:scale:orientation:)],
		@"Weird, asked for retina display image, but SDK is lesser than 4.0?",
		return image);

	return [[[UIImage alloc] initWithCGImage:image.CGImage scale:2.0
		orientation:UIImageOrientationUp] autorelease];
}

/** Returns an unsigned 64bit integer from the dictionary.
 * If the object is not found, returns the default value.
 */
- (uint64_t)get_int64:(NSString*)key def:(uint64_t)def
{
	id int_object = [self objectForKey:key];
	if (int_object) {
		if ([int_object isKindOfClass:[NSDecimalNumber class]]) {
			return [int_object doubleValue];
		} else if ([int_object isKindOfClass:[NSNumber class]]) {
			return [int_object longLongValue];
		} else {
			DLOG(@"Expecting int64 in JSON, got %@ '%@'",
				[int_object class], int_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns an integer from the dictionary.
 * If the object is not found, returns the default value.
 */
- (int)get_int:(NSString*)key def:(int)def
{
	id int_object = [self objectForKey:key];
	if (int_object) {
		if ([int_object isKindOfClass:[NSNumber class]]) {
			return [int_object intValue];
		} else {
			DLOG(@"Expecting int in JSON, got %@ '%@'",
				[int_object class], int_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns an unsigned int from the dictionary.
 * If the object is not found, returns the default value.
 */
- (unsigned int)get_uint:(NSString*)key def:(unsigned int)def
{
	id int_object = [self objectForKey:key];
	if (int_object) {
		if ([int_object isKindOfClass:[NSNumber class]]) {
			return [int_object unsignedIntValue];
		} else {
			DLOG(@"Expecting int in JSON, got %@ '%@'",
				[int_object class], int_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns a float from the dictionary.
 * If the object is not found, returns the default value.
 */
- (float)get_float:(NSString*)key def:(float)def
{
	id float_object = [self objectForKey:key];
	if (float_object) {
		if ([float_object isKindOfClass:[NSNumber class]]) {
			return [float_object floatValue];
		} else {
			DLOG(@"Expecting float in JSON, got %@ '%@'",
				[float_object class], float_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns a double from the dictionary.
 * If the object is not found, or has a different type, returns the
 * default value.
 */
- (double)get_double:(NSString*)key def:(double)def
{
	id double_object = [self objectForKey:key];
	if (double_object) {
		if ([double_object isKindOfClass:[NSNumber class]]) {
			return [double_object doubleValue];
		} else {
			DLOG(@"Expecting double in JSON, got %@ '%@'",
				[double_object class], double_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns a bool from the dictionary.
 * If the object is not found, or has a different type, returns the
 * default value.
 */
- (BOOL)get_bool:(NSString*)key def:(BOOL)def
{
	id int_object = [self objectForKey:key];
	if (int_object) {
		if ([int_object isKindOfClass:[NSNumber class]]) {
			return [int_object boolValue];
		} else {
			DLOG(@"Expecting bool in JSON, got %@ '%@'",
				[int_object class], int_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns a string from the dictionary.
 * If the object is not found, or has a different type, returns the
 * default value.
 */
- (NSString*)get_string:(NSString*)key def:(NSString*)def
{
	id str_object = [self objectForKey:key];
	if (str_object) {
		if ([str_object isKindOfClass:[NSString class]]) {
			return str_object;
		} else {
			DLOG(@"Expecting string in JSON, got %@ '%@'",
				[str_object class], str_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns a dictionary from the dictionary.
 * If the object is not found, or has a different type, returns the
 * default value.
 *
 * Note: hierarchychal type checks are not performed. You are advised
 * to review the value types of the returned dictionary.
 */
- (NSDictionary*)get_dict:(NSString*)key def:(NSDictionary*)def
{
	id dict_object = [self objectForKey:key];
	if (dict_object) {
		if ([dict_object isKindOfClass:[NSDictionary class]]) {
			return dict_object;
		} else {
			DLOG(@"Expecting dictionary in JSON, got %@ '%@'",
				[dict_object class], dict_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Returns an array from the dictionary.
 * If the object is not found, or has a different type, returns the
 * default value.
 *
 * Note: hierarchychal type checks are not performed. You are advised
 * to review the value types of the returned array.
 */
- (NSArray*)get_array:(NSString*)key def:(NSArray*)def
{
	id array_object = [self objectForKey:key];
	if (array_object) {
		if ([array_object isKindOfClass:[NSArray class]]) {
			return array_object;
		} else {
			DLOG(@"Expecting array in JSON, got %@ '%@'",
				[array_object class], array_object);
			return def;
		}
	} else {
		return def;
	}
}

/** Wrapper over get_array:def: which veryfies the type of the objects.
 * While the json standard allows having arrays of different types, in practice
 * most of the times your array will have all elements be of the same type. By
 * using this method the array will be thrown out if any of its members doesn't
 * confork to the specified class.
 *
 * Note that due to how the JSON wrapper  works, you can't differentiate basic
 * types like floats from bools or ints, at most you can make sure the items
 * are NSNumber objects.
 *
 * This method presumes the default parameter for the array is already valid,
 * so in the case of returning def it won't be checked for type consistency.
 *
 * \return Returns the array, or def if the array didn't exist or didn't
 * conform to the expected type.
 */
- (NSArray*)get_array:(NSString*)key of:(Class)type def:(NSArray*)def
{
	NSArray *ret = [self get_array:key def:def];
	if (ret == def)
		return ret;

	if (ret.count < 1)
		return ret;

	int f = 0;
	for (id tester in ret) {
		if (![tester isKindOfClass:type]) {
			DLOG(@"Got array in JSON, but element at position "
				@"%d was expected to be of type %@ and was %@ instead.\nThe "
				@"array was:%@", f, type, [tester class], ret);
			return def;
		}
		f++;
	}
	return ret;
}

/** Returns an integer pair as size from the dictionary.
 * If the object is not found, returns the default value.
 */
- (CGSize)get_size:(NSString*)key def:(CGSize)def
{
	id object = [self objectForKey:key];
	if (![object isKindOfClass:[NSArray class]])
		return def;

	NSArray *array = object;
	if (2 != [array count])
		return def;

	id v1 = [array objectAtIndex:0];
	id v2 = [array objectAtIndex:1];
	if (![v1 isKindOfClass:[NSNumber class]]) return def;
	if (![v2 isKindOfClass:[NSNumber class]]) return def;

	CGSize box = { [v1 intValue], [v2 intValue] };
	return box;
}

/** Returns a color (as array of three RGB integers) from the dictionary.
 * If the array is not found or doesn't have three numeric components which can
 * be expressed as a float value between 0 and 255 inclusive, the default value
 * will be returned. The function doesn't do clamping, so you could have 300 as
 * component in the JSON and... who knows.
 */
- (UIColor*)get_color:(NSString*)key def:(UIColor*)def
{
	id object = [self objectForKey:key];
	if (![object isKindOfClass:[NSArray class]])
		return def;

	NSArray *array = object;
	if (3 != [array count])
		return def;

	id v1 = [array objectAtIndex:0];
	id v2 = [array objectAtIndex:1];
	id v3 = [array objectAtIndex:2];
	if (![v1 isKindOfClass:[NSNumber class]]) return def;
	if (![v2 isKindOfClass:[NSNumber class]]) return def;
	if (![v3 isKindOfClass:[NSNumber class]]) return def;

	return [UIColor colorWithRed:[v1 floatValue] / 255.0f
		green:[v2 floatValue] / 255.0f blue:[v3 floatValue] / 255.0f alpha:1];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
