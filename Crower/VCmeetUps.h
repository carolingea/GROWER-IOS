

#import <UIKit/UIKit.h>

@interface VCmeetUps : UIViewController<UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *ScrollSlider;
@property (weak, nonatomic) IBOutlet UICollectionView *ColeccionMeets;
@property (weak, nonatomic) IBOutlet UIPageControl *PaginasSlider;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;


@end
