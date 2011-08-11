#import <Foundation/Foundation.h>

/** \class NSDictionary
 * Appends typed JSON extraction helper methods.
 */
@interface NSDictionary (ELHASO)

- (UIImage*)get_image:(NSString*)key def:(UIImage*)def;
- (UIImage*)get_image_2x:(NSString*)key def:(UIImage*)def;
- (uint64_t)get_int64:(NSString*)key def:(uint64_t)def;
- (int)get_int:(NSString*)key def:(int)def;
- (unsigned int)get_uint:(NSString*)key def:(unsigned int)def;
- (float)get_float:(NSString*)key def:(float)def;
- (double)get_double:(NSString*)key def:(double)def;
- (BOOL)get_bool:(NSString*)key def:(BOOL)def;
- (NSString*)get_string:(NSString*)key def:(NSString*)def;
- (NSDictionary*)get_dict:(NSString*)key def:(NSDictionary*)def;
- (NSArray*)get_array:(NSString*)key def:(NSArray*)def;
- (NSArray*)get_array:(NSString*)key of:(Class)type def:(NSArray*)def;
- (CGSize)get_size:(NSString*)key def:(CGSize)def;
- (UIColor*)get_color:(NSString*)key def:(UIColor*)def;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
