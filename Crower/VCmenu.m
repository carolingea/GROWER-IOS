

#import "VCmenu.h"
#import "VCterminos.h"
#import "VCaliados.h"
#import "VCfeedbacks.h"
#import "VCqueEsGrower.h"
#import "VCperfil.h"

@interface VCmenu ()

@end

@implementation VCmenu

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnPerfil:(id)sender {
    VCperfil * perfil = [[VCperfil alloc]init];
    perfil = [self.storyboard instantiateViewControllerWithIdentifier:@"vcperfil"];
    [self presentViewController:perfil animated:YES completion:nil];
}

- (IBAction)btnQueEsGrower:(id)sender {
    VCqueEsGrower * que = [[VCqueEsGrower alloc]init];
    // vcqueesgrower
    que = [self.storyboard instantiateViewControllerWithIdentifier:@"vcqueesgrower"];
    [self presentViewController:que animated:YES completion:nil];
}

- (IBAction)btnAliados:(id)sender {
    VCaliados * aliados = [[VCaliados alloc]init];
    aliados = [self.storyboard instantiateViewControllerWithIdentifier:@"vcaliados"];
    [self presentViewController:aliados animated:YES completion:nil];
}

- (IBAction)btnFeedback:(id)sender {
    VCfeedbacks * feedbacks = [[VCfeedbacks alloc]init];
    feedbacks = [self.storyboard instantiateViewControllerWithIdentifier:@"vcfeedbacks"];
    [self showViewController:feedbacks sender:nil];
    //[self presentViewController:feedbacks animated:YES completion:nil];
}

- (IBAction)btnTerminosCondiciones:(id)sender {
    VCterminos * terminos = [[VCterminos alloc]init];
    terminos = [self.storyboard instantiateViewControllerWithIdentifier:@"vcterminos"];
    [self presentViewController:terminos animated:YES completion:nil];
}
@end
