
#import "VCfeedbacks.h"
#import "Utilerias.h"

@interface VCfeedbacks ()

@end

@implementation VCfeedbacks
{
    Utilerias * Util;
    NSDictionary * info;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[_txtMensaje layer] setBorderWidth:0.5];
    [[_txtMensaje layer] setBorderColor:[[UIColor colorWithWhite:0.886 alpha:1.000]CGColor]];
    [[_txtMensaje layer] setCornerRadius:10];
    _email = [[MFMailComposeViewController alloc]init];
    info = [[NSBundle mainBundle]infoDictionary];
    Util = [[Utilerias alloc]init];
    
    
}


- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnEnviar:(id)sender {
    NSString * TituloEmail = _txtAsunto.text;
    NSString * EmailEmail = _txtEmail.text;
    NSString * MensajeEmail = _txtMensaje.text;
    NSArray * Destinatarios = [NSArray arrayWithObjects:info[@"EMAILfeedback"], nil];
    
    
    if(![_txtAsunto.text isEqualToString:@""] && ![_txtMensaje.text isEqualToString:@""] && ![_txtEmail.text isEqualToString:@""])
    {
        if([MFMailComposeViewController canSendMail])   //Si el dispositivo puede enviar un mensaje
        {
            _email.mailComposeDelegate = self;
            [_email setSubject:TituloEmail];
            [_email setMessageBody: [NSString stringWithFormat:@"Email: %@.<br>Mensaje: %@ ", EmailEmail, MensajeEmail] isHTML:NO];
            [_email setToRecipients:Destinatarios];
            [self presentViewController:_email animated:YES completion:nil];
        }
        else
        {
            UIAlertController * aler = [Util AlertaSimple:@"Mensaje" MENSAJE:@"El dispositivo no puede enviar E-mail"];
            [self presentViewController:aler animated:YES completion:nil];
        }
    }
    else
    {
        UIAlertController * aler = [Util AlertaSimple:@"Mensaje" MENSAJE:@"Debe completar todos los campos"];
        [self presentViewController:aler animated:YES completion:nil];
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    NSString * Resultado;
    switch (result) {
        case MFMailComposeResultSent:
            Resultado = @"Se ha enviado el feedback correctamente. Lo tomaremos en cuenta";
            _txtEmail.text = @"";
            _txtAsunto.text = @"";
            _txtMensaje.text = @"";
            break;
        case MFMailComposeResultSaved:
            Resultado = @"E-mail guardado en borrador";
            break;
        case MFMailComposeResultCancelled:
            Resultado = @"Has cancelado el envio de este e-mail";
            break;
        case MFMailComposeResultFailed:
            Resultado = @"E-mail falló. Un error ha ocurrido intentanto componer este e-mail.";
            break;
        default:
            Resultado = @"Un error ha ocurrido cuando se intentó componer este e-mail.";
            break;
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", Resultado);
        UIAlertController * aler =[Util AlertaSimple:@"Mensaje" MENSAJE:Resultado];
        [self presentViewController:aler animated:YES completion:nil];
    }];
}


- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    
}

@end
