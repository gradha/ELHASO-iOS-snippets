#import <UIKit/UIKit.h>

/** \class EHAlertView
 * Overrides the show method to work safely from background threads.
 */
@interface EHAlertView : UIAlertView

- (void)show;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
