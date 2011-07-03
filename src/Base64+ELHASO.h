/* vim: syntax=objc
 * Code taken from http://www.cocoadev.com/index.pl?BaseSixtyFour.
 * By cyrus.najmabadi@gmail.com, public domain.
 */

#import <Foundation/Foundation.h>

NSString *Base64_encode_r(const uint8_t *input, NSInteger length);
NSString *Base64_encode(NSData *rawBytes);
NSData *Base64_decode_r(const char *string, NSInteger inputLength);
NSData *Base64_decode(NSString *string);

