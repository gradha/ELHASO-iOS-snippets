#import <UIKit/UIKit.h>

/** \class EHActivityView
 * Appends some custom helpers to UIActivityIndicatorView.
 */
@interface EHActivityView : UIActivityIndicatorView

+ (EHActivityView*)get_white_large;
+ (EHActivityView*)get_white;
+ (EHActivityView*)get_gray;

- (void)set_translucent:(CGSize)size corner:(int)radius;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
