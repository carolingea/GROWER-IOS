
#import "VCinicial.h"
#import "VCmeetUps.h"
#import "VCidea.h"

@interface VCinicial ()

@end

@implementation VCinicial{
    VCmeetUps * meets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
}

- (IBAction)btnCamara:(id)sender {
    /*NSLog(@"Camara");
    VCidea * controlador = [[VCidea alloc]init];
    controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"vcidea"];
     */
    //[self showViewController:controlador sender:nil];
    [self performSegueWithIdentifier:@"seg_ideas" sender:nil];
}

- (IBAction)btnInsightMeetUps:(id)sender {
    //meets = [self.storyboard instantiateViewControllerWithIdentifier:@"meetups"];
    //[self showViewController:meets sender:nil];
    [self performSegueWithIdentifier:@"seg_meetups" sender:nil];
    
}
@end
