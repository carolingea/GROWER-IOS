#import <UIKit/UIKit.h>

@interface VCvermeet : UIViewController
@property (strong, nonatomic) NSString * Titulo;
@property (strong, nonatomic) NSString * ID;
@property (strong, nonatomic) NSString * Imagen;
@property (weak, nonatomic) IBOutlet UIImageView *imgHeader;
@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UITextView *tvContenido;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loading;
- (IBAction)btnCerrar:(id)sender;

@end
