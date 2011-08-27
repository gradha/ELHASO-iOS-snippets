#import <UIKit/UIKit.h>

/** \class UIActivity
 * Appends some custom helpers to UIActivity.
 */
@interface UIActivity : UIActivityIndicatorView

+ (UIActivity*)get_white_large;
+ (UIActivity*)get_white;
+ (UIActivity*)get_gray;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
