
#import "VCfeedbacks.h"

@interface VCfeedbacks ()

@end

@implementation VCfeedbacks

- (void)viewDidLoad {
    [super viewDidLoad];
    [[_txtMensaje layer] setBorderWidth:0.5];
    [[_txtMensaje layer] setBorderColor:[[UIColor colorWithWhite:0.886 alpha:1.000]CGColor]];
    [[_txtMensaje layer] setCornerRadius:10];
    
    _email = [[MFMailComposeViewController alloc]init];
}

- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnEnviar:(id)sender {
    NSString * TituloEmail = @"Prueba";
    NSString * MensajeEmail = @"Prueba mensaje";
    NSArray * Destinatarios = [NSArray arrayWithObjects:@"carolina.delgado@imaginamos.com.co", nil];
    
    
    if([MFMailComposeViewController canSendMail])   //Si el dispositivo puede enviar un mensaje
    {
        
        
        
        //MFMailComposeViewController * email = [[MFMailComposeViewController alloc]init];
        
        
        _email.mailComposeDelegate = self;
        
        [_email setSubject:TituloEmail];
        [_email setMessageBody:MensajeEmail isHTML:NO];
        [_email setToRecipients:Destinatarios];
        [self presentViewController:_email animated:YES completion:nil];
    }
    else
    {
        NSLog(@"El dispositivo no puede enviar E-mails");
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result) {
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@",@"Finish!");
        
        //[APP cycleTheGlobalMailComposer];
    }];
}


@end
