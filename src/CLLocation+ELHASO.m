#import "CLLocation+ELHASO.h"

#import "ELHASO.h"

#import <math.h>
#import <objc/runtime.h>


@implementation CLLocation (ELHASO)

/* Special compatibility initializer.
 * This brings the gap between ios 3.x and 4.x, where Apple deprecated
 * getDistanceFrom method. On 3.x the distanceFromLocation method doesn't
 * exist, so this initializer creates a link to it. On 4.x the method exists,
 * so class_addMethod does nothing. Also, this prevents the initializer from
 * requiring witnesses against double initialization.
 *
 * For more information see
 * http://0xced.blogspot.com/2010/09/cllocation-getdistancefrom-vs.html
 */
+ (void)initialize
{
	Method getDistanceFrom = class_getInstanceMethod([CLLocation class],
		@selector(getDistanceFrom:));

	if (class_addMethod([CLLocation class], @selector(distanceFromLocation:),
			method_getImplementation(getDistanceFrom),
			method_getTypeEncoding(getDistanceFrom))) {
		DLOG(@"Added distanceFromLocation: method as link to getDistanceFrom:");
	}
}

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

	const double distance = [self distanceFromLocation:location];

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
 * The returned bearing is in radians, with zero being north, PI/2 being east,
 * PI being south, etc. If something goes wrong or the specified location is
 * nil, returns zero. Note that returning negative values is valid too, so
 * -PI/2 would be west.
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
