//
//  CVmeetUpsContenidos.h
//  Crower
//  Created by Carolina Delgado on 13/06/16.


#import <UIKit/UIKit.h>

@interface VCmeetUpsContenidos : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

- (IBAction)btnCerrar:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
@property (weak, nonatomic) IBOutlet UICollectionView *ColContenidos;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (strong, nonatomic) NSString * ID;
@property (strong, nonatomic) NSString * Titulo;
@property (strong, nonatomic) NSString * Imagen;
@property (weak, nonatomic) IBOutlet UILabel *lblTituloCat;

@end
