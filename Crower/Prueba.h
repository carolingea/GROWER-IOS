
#import <UIKit/UIKit.h>
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

@interface Prueba : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
{
    
}

@property (strong, nonatomic) IBOutlet UITableView *tabla;
@property (weak, nonatomic) IBOutlet UISearchBar *BarraBuscar;



@end
