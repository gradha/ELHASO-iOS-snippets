#import "categories/UILabel+ELHASO.h"

#import "constants.h"

#import <QuartzCore/CALayer.h>

@implementation UILabel (ELHASO)

/** Creates a label with a special UIView background to be legible.
 * The function returns the pointer to the UIView parent that will
 * contain a single UILabel view with the specified text. The label
 * will have a shadow, and the returned view will be made with flexible
 * margins to autorotate correctly if centered on the screen. Pass
 * the bounds of the area you want the label to fit to. If you pass
 * YES as the fit parameter, however, the label will be reduced enough
 * to fit the minimum space inside the bounds you specified.
 *
 * The radius is to specify both the amount of border area and
 * rounded corner radius.
 */
+ (UIView*)round_text:(NSString*)text bounds:(CGRect)bounds fit:(BOOL)fit
	radius:(float)radius
{
	NSAssert(radius >= 0, @"Negative radius?");
	CGRect rect = bounds;
	/* If we have to fit the label, make the bounds smaller to have a border. */
	if (fit) {
		rect.size.width -= radius;
		rect.size.height -= radius;
	}

	UIView *back = [[[UIView alloc] initWithFrame:rect] autorelease];
	back.layer.cornerRadius = 10;
	back.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
	back.autoresizingMask = FLEXIBLE_MARGINS;

	UILabel *label = [[UILabel alloc] initWithFrame:rect];
	label.backgroundColor = [UIColor clearColor];
	label.textColor = [UIColor whiteColor];
	label.text = text;
	label.textAlignment = UITextAlignmentCenter;
	label.numberOfLines = 0;
	label.shadowColor = [UIColor blackColor];
	label.shadowOffset = CGSizeMake(1, 1);
	[back addSubview:label];
	if (fit) {
		[label sizeToFit];
		back.bounds = CGRectInset(label.bounds, -radius, -radius);
	} else {
		back.bounds = bounds;
	}
	[label release];
	return back;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
