/** \class UIImage
 * Appends some custom helpers to UIImage.
 */
@interface UIImage (ELHASO)

- (UIImage*)scale_to:(CGSize)size;
- (UIImage*)scale_to:(CGSize)size proportional:(BOOL)proportional;
- (void)draw_in_rect:(CGRect)rect mode:(UIViewContentMode)mode;

@end

// vim:tabstop=4 shiftwidth=4 syntax=objc
