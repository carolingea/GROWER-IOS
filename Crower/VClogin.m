#import "VClogin.h"
#import "VCrecordar.h"
#import "VCregistrar.h"
#import "Conexion.h"
#import "VCslider.h"
#import "Utilerias.h"


@interface VClogin ()
@end

@implementation VClogin
{
    CGFloat Y;
    CGFloat TecladoHeight;
    Conexion * conex;
    Utilerias * Util;
    VCrecordar * recordar;
    VCregistrar * registrar;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _txtUsuario.delegate = self;
    _txtPassword.delegate = self;
    Y = _viewLogin.frame.origin.y;
    conex = [[Conexion alloc]init];
    Util = [[Utilerias alloc]init];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self DesplazarTeclado:Y];
    [self.view endEditing:YES];
}


-(void)DesplazarTeclado:(CGFloat)ALTO
{
    [UIView animateWithDuration:0.5 animations:^{
        _viewLogin.frame = CGRectMake(_viewLogin.frame.origin.x, ALTO, _viewLogin.frame.size.width, _viewLogin.frame.size.height);
    }];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
        switch (textField.tag) {
            case 0:
                [_txtPassword becomeFirstResponder];
                break;
        }
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self DesplazarTeclado:Y/2];
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 1:
            [self.view endEditing:YES];
            break;
    }
    return YES;
}


- (IBAction)btnIngresar:(id)sender {
    
    if (![_txtUsuario.text isEqualToString:@""] &&  ![_txtPassword.text isEqualToString:@""]) {
        NSString * Parametros = [NSString stringWithFormat:@"op=verificar&usuario=%@&password=%@", _txtUsuario.text, _txtPassword.text];
        [conex conectar:@"Usuarios.php" PARAMETROS:Parametros CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@",res);
                if (res.count > 0) {
                    if ([[res valueForKey:@"Num"][0] intValue] > 0) {
                        // Si trae algo
                        //VCslider * slider = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
                        //[self presentViewController:slider animated:YES completion:^{
                        [[NSUserDefaults standardUserDefaults]setObject:[res valueForKey:@"Num"][0] forKey:@"Id_usuario"];
                        
                        [self performSegueWithIdentifier:@"seg_slider" sender:self];
                            
                        //}];
                    }
                    else
                    {
                        UIAlertController * Alerta = [Util AlertaSimple:@"Ingreso" MENSAJE:@"Usuario o contraseña errónea"];
                        [self presentViewController:Alerta animated:YES completion:nil];
                    }
                }
            });
            
        }];
    }
    else
    {
        UIAlertController * Alerta = [Util AlertaSimple:@"Ingreso" MENSAJE:@"Escriba usuario y contraseña"];
        [self presentViewController:Alerta animated:YES completion:nil];
    }
}

- (IBAction)btnRecordar:(id)sender {
    /*recordar = [self.storyboard instantiateViewControllerWithIdentifier:@"recordar"];
    [self showViewController:recordar sender:nil];
     */
    [self performSegueWithIdentifier:@"seg_recordar" sender:self];
}

- (IBAction)btnRegistrar:(id)sender {
    /*registrar = [self.storyboard instantiateViewControllerWithIdentifier:@"registrarse"];
    [self showViewController:registrar sender:nil];*/
    [self performSegueWithIdentifier:@"seg_registrar2" sender:self];
    
}

- (IBAction)btnMostrarPassword:(id)sender {
    if ([_txtPassword isSecureTextEntry])
        _txtPassword.secureTextEntry = NO;
    else
        _txtPassword.secureTextEntry = YES;
    
}


@end
