
#import <UIKit/UIKit.h>

@interface VCregistrar : UIViewController<UITextFieldDelegate>

- (IBAction)btnRegistrarse:(id)sender;
- (IBAction)btnMostrarClave:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUsuario;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *vistaRegistro;

@end
