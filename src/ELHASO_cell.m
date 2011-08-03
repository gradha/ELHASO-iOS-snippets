#import "ELHASO_cell.h"

#import "ELHASO.h"


/// Small subclass to handle custom drawing of cells.
@interface ELHASO_cell_view : UIView
@end

@implementation ELHASO_cell_view

- (void)drawRect:(CGRect)rect
{
	[(ELHASO_cell*)[self superview] draw_content:rect];
}

@end


@implementation ELHASO_cell

- (id)initWithIdentifier:(NSString *)identifier
{
	NSAssert(NO, @"This constructor is deprecated, don't use it!");
	[self doesNotRecognizeSelector:_cmd];
	[self release];
	return nil;
}

/** Default constructor.
 * Creates the content_view_ and adds it to the view.
 */
- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
		content_view_ = [[ELHASO_cell_view alloc]
			initWithFrame:self.contentView.bounds];
		content_view_.opaque = YES;
		content_view_.autoresizingMask = FLEXIBLE_SIZE;
		content_view_.autoresizesSubviews = YES;
		content_view_.contentMode = UIViewContentModeRedraw;
		[self addSubview:content_view_];
	}
	return self;
}

- (void)dealloc
{
	[content_view_ release];
	[super dealloc];
}

/** Special handler method because of drawContentView and inheritance.
 * Forces a refresh of our custom view.
 */
- (void)setNeedsDisplay
{
	[super setNeedsDisplay];
	[content_view_ setNeedsDisplay];
}

/** Method to draw the content of the cell.
 * You have to subclass it and implement it without calling super.
 */
- (void)draw_content:(CGRect)cell_rect
{
	[self doesNotRecognizeSelector:_cmd];
}

@end
