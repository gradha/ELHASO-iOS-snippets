#import <UIKit/UIKit.h>

/** Wrapper around UITableViewCell to have fast custom drawing.
 * You are supposed to inherit from this class then implement the draw_content
 * method without calling super.
 */

@interface ELHASO_cell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
	reuseIdentifier:(NSString *)reuseIdentifier;

- (void)draw_content:(CGRect)cell_rect;

@end
