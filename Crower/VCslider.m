

#import "VCslider.h"

@interface VCslider ()

@end

@implementation VCslider

- (void)viewDidLoad {
    [super viewDidLoad];
    _svSlider.pagingEnabled = YES;
    _svSlider.delegate = self;
    [_viewLogin setHidden:YES];
    
    self.navigationController.navigationBar.hidden = YES;
    
    NSArray * imagenes = [[NSArray alloc]initWithObjects:@"slide1.jpg",@"slide2.jpg",@"slide3.jpg", @"LOGIN", nil];
    
    _pageSlider.numberOfPages = [imagenes count];
    
    
    for (int i=0; i<[imagenes count]; i++) {
        if ([[imagenes objectAtIndex:i] isEqual:@"LOGIN"]) {
            [_viewLogin setHidden:NO];
            _viewLogin.frame = CGRectMake(_svSlider.frame.size.width * i, 0, _svSlider.frame.size.width, _svSlider.frame.size.height);
        }
        else
        {
            UIImageView * imaview = [[UIImageView alloc]initWithFrame:CGRectMake(_svSlider.frame.size.width * i, 0, _svSlider.frame.size.width, _svSlider.frame.size.height)];
            imaview.image = [UIImage imageNamed:[imagenes objectAtIndex:i]];
            [_svSlider addSubview:imaview];
            _svSlider.contentSize = CGSizeMake(_svSlider.frame.size.width*[imagenes count], 0);
        }
            
        
        
    }
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    float pag = (scrollView.contentOffset.x)/(scrollView.frame.size.width);
    _pageSlider.currentPage = pag;
    
}



@end
