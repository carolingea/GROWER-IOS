

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
    VCmeetUps * controlador = [[VCmeetUps alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"meetups"];
    [self presentViewController:controlador animated:YES completion:nil];
}

- (IBAction)btnInsights:(id)sender {
    
}

- (IBAction)btnVideos:(id)sender {
    VCidea * controlador = [[VCidea alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"vcidea"];
    [self presentViewController:controlador animated:YES completion:nil];
}

- (IBAction)btnBuscar:(id)sender {
}

- (IBAction)btnPerfil:(id)sender {
    VCmenu * controlador = [[VCmenu alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"vcmenu"];
    [self presentViewController:controlador animated:YES completion:nil];
}
@end
