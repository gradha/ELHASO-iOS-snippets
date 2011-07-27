#import <UIKit/UIKit.h>

/** \class UILabel
 * Appends some custom helpers to UILabel.
 */
@interface UILabel (ELHASO)

+ (UIView*)round_text:(NSString*)text bounds:(CGRect)bounds
	fit:(BOOL)fit radius:(float)radius;

+ (UIView*)round_text:(NSString*)text bounds:(CGRect)bounds fit:(BOOL)fit
	radius:(float)radius view:(UIView*)custom_view;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
