#import "Root_table_controller.h"

#import "ELHASO.h"

#import "NSArray+ELHASO.h"


@implementation Root_table_controller

NSArray *_options;

+ (void)initialize
{
	if (!_options)
		_options = [[NSArray alloc]
			initWithObjects:@"The root view controller?",
			@"Rounded rect labels",
			nil];
}

- (void)loadView
{
	[super loadView];

	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	[self.tableView reloadData];
}

- (void)dealloc
{
	[super dealloc];
}

/** Hook to simulate memory warnings after we are visible.
 */
- (void) viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
	simulate_memory_warning();
}

- (UITableViewCell *)tableView:(UITableView *)tableView
	cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *identifier = @"root_cell";

	UITableViewCell *cell = [tableView
		dequeueReusableCellWithIdentifier:identifier];

	if (cell == nil)
		cell = [[[UITableViewCell alloc]
			initWithStyle:UITableViewCellStyleDefault
			reuseIdentifier:identifier] autorelease];

	NSString *title = [_options get:indexPath.row];
	cell.textLabel.text = NON_NIL_STRING(title);
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	return cell;
}


- (NSInteger)tableView:(UITableView *)tableView
	numberOfRowsInSection:(NSInteger)section
{
	if (0 == section)
		return _options.count;
	else
		return 0;
}

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
