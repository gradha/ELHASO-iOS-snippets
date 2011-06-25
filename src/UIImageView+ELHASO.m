#import "UIImageView+ELHASO.h"

@implementation UIImageView (ELHASO)

/** Same as [UIImage imageNamed], but with an UIImageView.
 */
+ (UIImageView*)imageNamed:(NSString*)name
{
	return [[[UIImageView alloc] initWithImage:[UIImage imageNamed:name]]
		autorelease];
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
