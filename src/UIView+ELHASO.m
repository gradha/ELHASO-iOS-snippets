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

/** Centers a view inside another one.
 * Use this method to center a view inside another. For this method to work,
 * the receiver class has to be a direct subview of other. You should probably
 * call align_rect after calling this method to make sure pixel sizes are
 * integers.
 *
 * If other is nil, this method presumes you would have passed the superview as
 * other. If the receiver still has no parent, the method exits before doing
 * anything.
 */
- (void)center_inside:(UIView*)other
{
	if (!other)
		other = self.superview;
	if (!other)
		return;

	NSAssert(!self.superview || self.superview == other,
		@"Bad hierarchy, receiver needs to be orphan or child of other!");
	CGRect rect = self.bounds;
	rect.origin.x = other.bounds.size.width / 2.0f - rect.size.width / 2.0f;
	rect.origin.y = other.bounds.size.height / 2.0f - rect.size.height / 2.0f;
	self.frame = rect;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
