#import <CoreLocation/CoreLocation.h>

/** \class CoreLocation
 * Adds some convenience methods to reduce coding and perform
 * additional calculations between location points.
 */
@interface CLLocation (ELHASO)

- (double)distance_to:(CLLocation*)location do_round:(BOOL)do_round;
- (double)bearing_to:(CLLocation*)location;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
