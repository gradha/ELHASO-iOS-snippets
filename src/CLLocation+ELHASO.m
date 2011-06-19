#import "categories/CLLocation+ELHASO.h"

#import "constants.h"
#import "macro.h"

#import <math.h>

@implementation CLLocation (ELHASO)

/** Returns the distance to a location.
 * Pass YES as the do_round parameter if you want to round the returned
 * value according to the added accuracy loss of both locations
 * (current, and other), pass NO if you want to presume the accuracy
 * is perfect.
 *
 * For the rounded distance, the distance is rounded up to the
 * nearest multiple of distances according to an internal table. By
 * default you should expect things rounded up between 5m and 100m.
 *
 * Returns MAX_DISTANCE if the parameter is nil or the distance
 * can't be calculated.
 */
- (double)distance_to:(CLLocation*)location do_round:(BOOL)do_round
{
	if (!location)
		return MAX_DISTANCE;

	static BOOL virgin = YES;
	static BOOL old_method = NO;

	if (virgin) {
		if ([location respondsToSelector:@selector(distanceFromLocation:)]) {
			old_method = NO;
			DLOG(@"First CLLocation, using new distance methods");
		} else {
			old_method = YES;
			DLOG(@"First CLLocation, using old distance methods");
		}
		virgin = NO;
	}

	const double distance = old_method ? [self getDistanceFrom:location] :
		[self distanceFromLocation:location];

	if (!do_round)
		return distance;

	/* By default round to 100m, which is good enough for large distances. */
	double rounder = 1 / 100.0;
	double expander = 100;
	const double accuracy = self.horizontalAccuracy +
		location.horizontalAccuracy;

	if (accuracy < 200) {
		rounder = 1 / 5.0;
		expander = 5;
	} else if (accuracy < 500) {
		rounder = 1 / 25.0;
		expander = 25;
	}

	double new_distance = ceil(distance * rounder) * expander;
	NSAssert(new_distance >= distance, @"What? Less distance is proportional?");

	//DLOG(@"Accuracy %0.0f, new_distance %0.1fm, diff %0.0f",
		//accuracy, new_distance, new_distance - distance);
	return new_distance;
}

/** Returns the bearing to the specified location.
 * The returned bearing is in radians, with zero being north, PI/2
 * being east, PI being south, etc. If something goes wrong or the
 * specified location is nil, returns zero.
 *
 * Credit goes to Movable Type Scripts at
 * http://www.movable-type.co.uk/scripts/latlong.html for explanation
 * and pseudo code.
 */
- (double)bearing_to:(CLLocation*)location
{
	if (!location)
		return 0;

	const double dlon = DEG2RAD(
		location.coordinate.longitude - self.coordinate.longitude);
	const double lat1 = DEG2RAD(self.coordinate.latitude);
	const double lat2 = DEG2RAD(location.coordinate.latitude);
	const double cos_lat2 = cos(lat2);
	const double y = sin(dlon) * cos_lat2;
	const double x = cos(lat1) * sin(lat2) - sin(lat1) * cos_lat2 * cos(dlon);
	return atan2(y, x);
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
