#import "View_controller.h"

#import "Root_table_controller.h"

#import "CLLocation+ELHASO.h"
#import "ELHASO.h"
#import "NSArray+ELHASO.h"
#import "NSDictionary+ELHASO.h"
#import "NSObject+ELHASO.h"
#import "NSString+ELHASO.h"
#import "UIImage+ELHASO.h"
#import "UIImageView+ELHASO.h"
#import "UILabel+ELHASO.h"

#import <math.h>


#define LOGO_FILENAME		@"electric_hands_software_hand_logo.jpg"


@interface View_controller ()

- (void)run_tests;

@end


@implementation View_controller

@synthesize label;
@synthesize doing;

- (void)dealloc
{
	[label dealloc];
	[doing dealloc];
	[super dealloc];
}

- (void)viewDidLoad
{
	self.label.text = @"";
}

- (void)start_tests
{
	if (is_running)
		return;

	is_running = YES;
	[doing startAnimating];
	self.label.text = @"";
	// Note that running the examples already tests NSObject delayed block
	// execution category.
	[self after:0 perform:^{ [self run_tests]; }];
}

- (void)push_table
{
	LOG(@"Pushing further tests...");
	UITableViewController *c = [Root_table_controller new];
	[self.navigationController pushViewController:c animated:YES];
	[c release];
}

- (void)run_nsarray_tests
{
	NSArray *t1 = [NSArray arrayWithObjects:@"Test", [NSNull null], nil];
	LOG(@"Getting first entry of NSArray '%@'", [t1 get:0]);
	LOG(@"Getting out of bonds entry of NSArray '%@'", [t1 get:10]);
	LOG(@"Repeating with NON_NIL_STRING '%@'",
		NON_NIL_STRING([t1 get:10]));
	LOG(@"Getting second entry of NSArray '%@'",
		NON_NIL_STRING([t1 get:1]));
	LOG(@"What if we dislike NSNull objects? '%@'",
		NON_NIL_STRING([t1 get_non_null:1]));
}

- (void)run_nsstring_tests
{
	NSArray *strings = [NSArray arrayWithObjects:@"http://elhaso.com/blah",
		@"http://elhaso.com/subhunt/index.en.html", @"../i/logo.png", nil];

	for (NSString *url in strings) {
		LOG(@"Url '%@'", url);
		LOG(@"\tbase url: %@", [url stringByRemovingFragment]);
		LOG(@"\tis relative? %@", [url isRelativeURL] ? @"Yes" : @"No");
	}

	NSString *base_search = @"http://www.google.com/search?q=";
	NSString *user_input = @"Electric Hands Software Submarine Hunt";
	LOG(@"With the base url %@ and params '%@'...", base_search, user_input);
	LOG(@"...we will request %@", [NSString stringWithFormat:@"%@%@",
		base_search, [user_input split_and_encode]]);
}

- (void)run_image_tests
{
	UIImageView *logo = [UIImageView imageNamed:LOGO_FILENAME];
	RASSERT(logo, @"Didn't load UIImageView!", return);
	LOG(@"UIImageView with %@", logo.image);

	CGSize size = CGSizeMake(30, 30);
	UIImage *smaller = [logo.image scale_to:size proportional:YES];
	LOG(@"Smaller logo scaled to %0.0fx%0.0f",
		smaller.size.width, smaller.size.height);

	size = CGSizeMake(300, 90);
	UIImage *bigger = [logo.image scale_to:size proportional:YES];
	LOG(@"Bigger logo scaled to %0.0fx%0.0f",
		bigger.size.width, bigger.size.height);
}

- (void)run_label_tests
{
	UIView *round = [UILabel round_text:@"Test"
		bounds:CGRectMake(0, 0, 100, 100) fit:YES radius:10];
	LOG(@"You might not have noticed, but I just created a rounded label!");
	LOG(@"%@", ASK_GETTER(round, recursiveDescription, nil));

	round = [UILabel round_text:@"Test"
		bounds:CGRectMake(0, 0, 100, 100) fit:YES radius:10
		view:[UIImageView imageNamed:LOGO_FILENAME]];
	LOG(@"And another one I created has even a cute logo");
}

- (void)run_location_tests
{
	CLLocation *madrid = [[CLLocation alloc]
		initWithCoordinate:(CLLocationCoordinate2D){40.415291, -3.684266}
		altitude:0 horizontalAccuracy:50 verticalAccuracy:0
		timestamp:[NSDate date]];

	CLLocation *bilbao = [[CLLocation alloc]
		initWithCoordinate:(CLLocationCoordinate2D){43.263023, -2.935055}
		altitude:0 horizontalAccuracy:500 verticalAccuracy:0
		timestamp:[NSDate date]];

	LOG(@"Distance between Madrid and Bilbao: %0.1fkm",
		[madrid distance_to:bilbao do_round:YES] / 1000.0);
	LOG(@"Bearing from Madrid to Bilbao: %0.6f rad, %0.1f degrees",
		[madrid bearing_to:bilbao], RAD2DEG([madrid bearing_to:bilbao]));
	LOG(@"Bearing from Bilbao to Madrid: %0.6f rad, %0.1f degrees",
		[bilbao bearing_to:madrid], RAD2DEG([bilbao bearing_to:madrid]));

	[madrid release];
	[bilbao release];
}

- (void)run_dictionary_tests
{
	// Presume the following dictionary is the result of JSON parsing action...
	// ...and pretend these are no the ugly macros you are searching for.
#define NUM(X)		[NSNumber numberWithInt:X]
#define UNUM(X)		[NSNumber numberWithUnsignedInt:X]
#define ARRAY(...)	[NSArray arrayWithObjects:__VA_ARGS__]
#define DICT(...)	[NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__]

	NSDictionary *data = DICT(
		ARRAY(NUM(255), NUM(0), NUM(0), nil), @"red_color",
		ARRAY(NUM(128), NUM(128), nil), @"rect_size",
		ARRAY(NUM(1), NUM(2), NUM(3), NUM(4), NUM(5), nil), @"valid_int_array",
		ARRAY(NUM(1), @"Saboteur!", NUM(3), nil), @"invalid_array",
		UNUM(-1), @"uint",
		DICT(@"value", @"a string", NUM(4), @"a number", nil), @"dictionary",
		@"Visit http://elhaso.com/ please!", @"just a lame ad",
		[NSNumber numberWithBool:false], @"true_story_bro",
		[NSNumber numberWithDouble:M_PI], @"pi_double",
		[NSNumber numberWithFloat:M_PI], @"pi_float",
		[NSDecimalNumber
			decimalNumberWithString:@"1152921504606846976"], @"long_long",
@"iVBORw0KGgoAAAANSUhEUgAAABkAAAAcCAIAAAAbRoOHAAAAB3RJTUUH2wcDFgU4WWamqwAAAAlw"
@"SFlzAAAK8AAACvABQqw0mAAABEtJREFUSMeNVdtv21QYz//BI7wgECpau2Zt3bVNCg8r2iXQLSvr"
@"ZckmNMQQgz0M9gI8FFGtXNY9TGhcBg8DmjRpnG4dIUioYkt6iWOn6dZuvWwdbUeJ7WPHSRxfOOfY"
@"dbOSBGzn+OTz59/3+6626VUPkf4BTA2puq5qOlrgAW/w1Moo26wdVtva4xMemfAJMOLOrTMaQkMa"
@"4r0xrYJhW+mfogz4qUu5x9QWlM7d6gcBt7xBYzq6QF/l/Yeyi1HTYhUsaY0Gfhf36zl1S5JNDwP/"
@"kYK4YYDzkfeEwOvSRvK/eUEIlvRmgt2WJPdngh0+qGlF6B7iFb+YGe3WrEhUwULhWCB5n0suSoak"
@"IK5lfnbhrYKe3gmCyYv/K17YeJH1HSps3jMkslLI+DotDtLiuLR4UyvDCWMZ6UOrhsFgUG59mluO"
@"Wkz/HumytLP3b+RXYxV5qUpeSPvgiqrGML46IU1ftjQ2/UetaIqzP0kPJipiCUtRYfiAwFy1NJR8"
@"bjPcZ2n8ZcYLcWYnPsrOBw0fzXo0HUY3m5zPsAE3G/KUJgemMs/OQyLFgsD+eFBVFfimIgPO3ylM"
@"XbKs4j5QFUXV4KkqNvhAehTjfK7cWsxCE/7o56LvozxuprmR14SliCyusjdO8aSHi563TCIA6Pj8"
@"AhuLy1bsc4+ZTLBX02RFQ7nPUldguYP0teztCzx5HAS7uZGjgDwO9zy2YUZD05JHjiVq7PGnnl75"
@"6lubEQroTm5lgiNPKoqEW/o7EOoDwS4+1MuHTwLSywe7QdiLhNNDlo9zp88mX6hNunv4yRnFqK+t"
@"5tPBL+9yYQ+YHwXjb/Jhj0B6AVxHe7nfPywsR/lQNx90S7gmoO08EOPPPLtxPWJ6rKq20nYQV8aF"
@"0T4QwhRID+JC9rI330YvazLrezUTecfSf3Tl66X+C0ZtGqX55JwoyGzgMPIo7GXH3sjOXOZCHjir"
@"qA6XnC/ysQFFEpke73pwTNWVyed2iw9XlfI9hLlx42fYsJcPdBYVXlz5TdXlxL79TJNj4a0zhbwy"
@"Y29NNRIPPhmk2l+ZrG80q67SnBBjg1ywK3c/Emt9uZhXqY4DqSYH3exMNrRSjW3M3naGaKfsBN3s"
@"mD3m2S7VsnNCSF8TYv30vsNMszNhJ2YJJ0MgLJpwQAneoytlb1kc+Lw0b2V45TfjTI+bbmpLGRDN"
@"DoaAq5PBF43hoCTxfB0/d6fyzMFDHjBpqqYev2xQcJpY5ookVG3D3XPn/z0Od/ISlldmXrTP4hgx"
@"JZcFl9y15+7psxhm59doxyxEYyfRAqPjNOICN9uIUFjbuPDBx+bU0J4I1g4fzfw+/OZ7ZlejQYTB"
@"8WIM6IbWuROntgdnte9jif+wY6k6giHaTNdwNhO79xZ3fD6rzHvd6ghdXxz8Yrqmjq4naKINsqNq"
@"7OvkdU2vMOrLYmlbUx/+ilJu+cuhVIdruuWlpYHPjCFTBesfGMH49PssFWoAAAAASUVORK5CYII=",
		@"png_image", nil);

	LOG(@"Going to test dictionary accessors with %@", data);
	LOG(@"The red color is: %@", [data get_color:@"red_color" def:nil]);

	LOG(@"Converted a pair of ints to size %@",
		NSStringFromCGSize([data get_size:@"rect_size" def:CGSizeZero]));

	LOG(@"The value of the unsigned int is %u", [data get_uint:@"uint" def:0]);
	LOG(@"Get an array of ints: %@",
		[data get_array:@"valid_int_array" of:[NSNumber class] def:nil]);

	LOG(@"We fail to get a validated array of heterogenous objects: %@",
		[data get_array:@"invalid_array" of:[NSNumber class] def:nil]);

	LOG(@"But we can get it without type checks: %@",
		[data get_array:@"invalid_array" def:nil]);

	LOG(@"Oh, a shiny dictionary! %@", [data get_dict:@"dictionary" def:nil]);

	LOG(@"Spam in your log strings! %@",
		[data get_string:@"just a lame ad" def:nil]);

	LOG(@"Wasn't that a shameless plug? %@",
		[data get_bool:@"true_story_bro" def:true] ? @"YES" : @"NO");

	LOG(@"This is our double: %0.15f", [data get_double:@"pi_double" def:0]);
	LOG(@"This is our float: %f", [data get_double:@"pi_float" def:0]);
	LOG(@"This is our int64: %lld", [data get_int64:@"long_long" def:0]);
	LOG(@"Embedded image: %@", [data get_image:@"png_image" def:nil]);
}

- (void)run_misc_tests
{
	LOG(@"Running misc tests...");

	// If you remove "InBackground" in the next call, it will assert.
	[self performSelectorInBackground:@selector(run_in_background)
		withObject:nil];

	NSString *png = @"electric_hands_software_hand_logo.jpg";
	LOG(@"Let's build hypothetical paths to the file %@", png);
	LOG(@"Bundle: %@", get_path(png, DIR_BUNDLE));
	LOG(@"Docs: %@", get_path(png, DIR_DOCS));
	LOG(@"Cache: %@", get_path(png, DIR_CACHE));
	LOG(@"Lib: %@", get_path(png, DIR_LIB));
	LOG(@"Running simulated memory warning... %@",
		simulate_memory_warning() ? @"YES" : @"NO");
}

- (void)run_in_background
{
	// Please remember that DONT_BLOCK_UI won't do anything in release mode!
	DONT_BLOCK_UI();
	DLOG(@"If you read this, it means we are not blocking the user interface");
}

- (void)run_tests
{
	LOG(@"Running the test suite...");

	// Testing some macros.
	DLOG(@"This message only seen if you are on your DEBUG build");
	LOG(@"This message seen always, did you see the previous DEBUG one?");
	LOG(@"Now we show a nil '%@' and a non-nil '%@' string.",
		nil, NON_NIL_STRING(nil));

	[self run_nsarray_tests];
	[self run_nsstring_tests];
	[self run_image_tests];
	[self run_label_tests];
	[self run_location_tests];
	[self run_dictionary_tests];
	[self run_misc_tests];

	[doing stopAnimating];
	LOG(@"Finished all tests!");
	self.label.text = @"Did run all, check the log!";
	is_running = NO;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
