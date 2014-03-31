#import <UIKit/UIKit.h>

/** Wrapper around UITableViewCell to have fast custom drawing.
 * You are supposed to inherit from this class then implement the draw_content
 * method without calling super. On iOS7 you need access to the
 * ELHASO_cell_view property so you can remove it, since just not drawing
 * anything leaves an opaque black rectangle in the view.
 */
@class ELHASO_cell_view;

@interface ELHASO_cell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier;

- (void)draw_content:(CGRect)cell_rect;

/// Allows removing the view for special cases.
@property (nonatomic, retain) ELHASO_cell_view *fast_view;


@end
