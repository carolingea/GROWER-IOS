
#import "VCinicial.h"
#import "VCmeetUps.h"

@interface VCinicial ()

@end

@implementation VCinicial{
    VCmeetUps * meets;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)btnCamara:(id)sender {
    NSLog(@"Camara");
}

- (IBAction)btnInsightMeetUps:(id)sender {
    meets = [self.storyboard instantiateViewControllerWithIdentifier:@"meetups"];
    [self showViewController:meets sender:nil];
    
}
@end
