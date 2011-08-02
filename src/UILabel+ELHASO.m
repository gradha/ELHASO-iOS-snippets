#import "UILabel+ELHASO.h"

#import "ELHASO.h"
#import "NSArray+ELHASO.h"

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

/** Improved version with custom view on top.
 * This is a wrapper around the round_text:bounds:fit:radius: method. It will
 * modify the returned view to hold a custom view at the top. Usually you want
 * to pass an UIImageView here, but any kind of view will do. Whatever
 * parameters you are passing, the retuned view will resize itself if needed to
 * hold the additional view you are specifying.
 *
 * Note that the custom view you are passing has to be modified to be able to
 * fit inside the view: the frame/bounds will be modified (obviously) and the
 * contentMode property will be set to UIViewContentModeCenter to appear
 * centered inside the parent view if needed.
 *
 * Obvious as it may be, the returned view will have now two childs instead of
 * one: the first child is the label and the second one is the custom view.
 */
+ (UIView*)round_text:(NSString*)text bounds:(CGRect)bounds fit:(BOOL)fit
	radius:(float)radius view:(UIView*)custom_view
{
	UIView *base = [self round_text:text bounds:bounds fit:fit radius:radius];
	if (!custom_view) {
		//DLOG(@"Uh oh, you called round_text with a nil custom_view?");
		return base;
	}

	// First make sure the base contains what we expect.
	NSAssert(1 == base.subviews.count, @"What? I was expecting a single child");
	UILabel *label = [base.subviews get:0];
	NSAssert([label isKindOfClass:[UILabel class]], @"Unexpected child type");
	base.frame = base.bounds;
	CGRect rect = label.frame;

	// Think how much we have to increase the base view to fit the custom view.
	const float h_increase = custom_view.bounds.size.height + radius;
	const float w_increase = custom_view.bounds.size.width - rect.size.width;
	// Move the text label down and regrow everything else to fit the space.
	rect.origin.y += h_increase;
	if (w_increase > 0)
		rect.origin.x += (int)(w_increase / 2.0f);
	label.frame = rect;

	// Recenter subview inside area.
	if (w_increase < 0) {
		rect = custom_view.bounds;
		rect.size.width -= w_increase;
		custom_view.frame = rect;
	}
	custom_view.contentMode = UIViewContentModeCenter;
	[base addSubview:custom_view];

	// Reshape main view.
	rect = base.bounds;
	rect.size.height += h_increase;
	if (w_increase > 0)
		rect.size.width += w_increase;
	base.bounds = rect;

	return base;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
