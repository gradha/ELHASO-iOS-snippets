#import "UIView+ELHASO.h"

#import "ELHASO.h"

@implementation UIView (ELHASO)

/** Aligns the frame to pixel boundaries.
 * This simply takes the frame rect and makes sure that the origin and size
 * have integer values. Useful after using the center position attribute on a
 * random size view which somehow aligns to subpixels and looks blurry.
 */
- (void)align_rect
{
	CGRect rect = self.frame;
	rect.origin.x = floorf(rect.origin.x);
	rect.origin.y = floorf(rect.origin.y);
	rect.size.width = roundf(rect.size.width);
	rect.size.height = roundf(rect.size.height);
	self.frame = rect;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
