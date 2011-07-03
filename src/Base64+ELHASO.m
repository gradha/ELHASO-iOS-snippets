/* vim: syntax=objc
 * Code taken from http://www.cocoadev.com/index.pl?BaseSixtyFour.
 * By cyrus.najmabadi@gmail.com, public domain.
 */

#import "Base64+ELHASO.h"

#define ArrayLength(x) (sizeof(x)/sizeof(*(x)))

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

NSString *Base64_encode_r(const uint8_t *input, NSInteger length)
{
	NSMutableData* data = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
	uint8_t* output = (uint8_t*)data.mutableBytes;

	for (NSInteger i = 0; i < length; i += 3) {
			NSInteger value = 0;
			for (NSInteger j = i; j < (i + 3); j++) {
					value <<= 8;

					if (j < length) {
							value |= (0xFF & input[j]);
					}
			}

			NSInteger f = (i / 3) * 4;
			output[f + 0] =										 encodingTable[(value >> 18) & 0x3F];
			output[f + 1] =										 encodingTable[(value >> 12) & 0x3F];
			output[f + 2] = (i + 1) < length ? encodingTable[(value >> 6)  & 0x3F] : '=';
			output[f + 3] = (i + 2) < length ? encodingTable[(value >> 0)  & 0x3F] : '=';
	}

	return [[[NSString alloc] initWithData:data
		encoding:NSASCIIStringEncoding] autorelease];
}

NSString *Base64_encode(NSData *rawBytes)
{
	return Base64_encode_r(rawBytes.bytes, rawBytes.length);
}

NSData *Base64_decode_r(const char *string, NSInteger inputLength)
{
	static char decodingTable[128];
	static BOOL virgin = YES;
	if (virgin) {
		memset(decodingTable, 0, ArrayLength(decodingTable));
		for (NSInteger i = 0; i < ArrayLength(encodingTable); i++) {
			decodingTable[encodingTable[i]] = i;
		}
		virgin = NO;
	}

	if ((string == NULL) || (inputLength % 4 != 0)) {
		return nil;
	}

	while (inputLength > 0 && string[inputLength - 1] == '=') {
		inputLength--;
	}

	NSInteger outputLength = inputLength * 3 / 4;
	NSMutableData* data = [NSMutableData dataWithLength:outputLength];
	uint8_t* output = data.mutableBytes;

	NSInteger inputPoint = 0;
	NSInteger outputPoint = 0;
	while (inputPoint < inputLength) {
		char i0 = string[inputPoint++];
		char i1 = string[inputPoint++];
		char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
		char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';

		output[outputPoint++] = (decodingTable[i0] << 2) | (decodingTable[i1] >> 4);
		if (outputPoint < outputLength) {
			output[outputPoint++] = ((decodingTable[i1] & 0xf) << 4) | (decodingTable[i2] >> 2);
		}
		if (outputPoint < outputLength) {
			output[outputPoint++] = ((decodingTable[i2] & 0x3) << 6) | decodingTable[i3];
		}
	}

	return data;
}

NSData *Base64_decode(NSString *string)
{
	return Base64_decode_r([string cStringUsingEncoding:NSASCIIStringEncoding],
		string.length);
}

