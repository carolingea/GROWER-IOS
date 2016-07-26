

#import "VCmenuHeader.h"
#import "VCmenu.h"
#import "VCmeetUps.h"
#import "VCidea.h"

@interface VCmenuHeader ()

@end

@implementation VCmenuHeader

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (IBAction)btnTodo:(id)sender {
}

- (IBAction)btnMeetUps:(id)sender {
    /*VCmeetUps * controlador = [[VCmeetUps alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"meetups"];
    [self presentViewController:controlador animated:YES completion:nil];
     */
    [self performSegueWithIdentifier:@"seq_menumeet" sender:self];
}

- (IBAction)btnInsights:(id)sender {
    [self performSegueWithIdentifier:@"seq_menumeet" sender:self];
    
}

- (IBAction)btnVideos:(id)sender {
    /*VCidea * controlador = [[VCidea alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"vcidea"];
    [self presentViewController:controlador animated:YES completion:nil];
     */
    [self performSegueWithIdentifier:@"seq_menuvideo" sender:self];
}

- (IBAction)btnBuscar:(id)sender {
}

- (IBAction)btnPerfil:(id)sender {
    
    /*VCmenu * controlador = [[VCmenu alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"vcmenu"];
    [self presentViewController:controlador animated:YES completion:nil];
    */
    [self performSegueWithIdentifier:@"seg_menumorado" sender:self];
    
}
@end
