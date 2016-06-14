//  Created by Carolina Delgado on 24/05/16.


#import <UIKit/UIKit.h>

@interface VCslider : UIViewController<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *svSlider;
@property (weak, nonatomic) IBOutlet UIImageView *ivImagen;
@property (weak, nonatomic) IBOutlet UIPageControl *pageSlider;

@property (weak, nonatomic) IBOutlet UIView *viewLogin;

@end

