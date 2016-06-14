

#import <UIKit/UIKit.h>

@interface VClogin : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtUsuario;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIView *viewLogin;

- (IBAction)btnIngresar:(id)sender;
- (IBAction)btnRecordar:(id)sender;
- (IBAction)btnRegistrar:(id)sender;

@end
