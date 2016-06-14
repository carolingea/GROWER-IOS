#import "VClogin.h"
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
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _txtUsuario.delegate = self;
    _txtPassword.delegate = self;
    Y = _viewLogin.frame.origin.y;
    conex = [[Conexion alloc]init];
    Util = [[Utilerias alloc]init];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];

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
    CGFloat nuevoY = _viewLogin.frame.origin.y - TecladoHeight;
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
    
    NSString * Parametros = [NSString stringWithFormat:@"op=verificar&usuario=%@&password=%@", _txtUsuario.text, _txtPassword.text];
    [conex conectar:@"Usuarios.php" PARAMETROS:Parametros CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{  // Cuando termine el callback haga lo del bloque
            NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            if (res.count > 0) {
                if ([[res valueForKey:@"Num"][0] intValue] > 0) {    // Si trae algo
                    VCslider * slider = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
                    [self presentViewController:slider animated:YES completion:nil];
                }
                else
                {
                    UIAlertController * Alerta = [Util AlertaSimple:@"Ingreso" MENSAJE:@"Usuario o contraseña errónea"];
                    [self presentViewController:Alerta animated:YES completion:nil];
                    
                    //[self AlertaSimple:@"Registro" MENSAJE:@"Usuario o contraseña errónea"];
                    
                }
            }
        });
        
    }];
    
}

- (IBAction)btnRecordar:(id)sender {
    
}

- (IBAction)btnRegistrar:(id)sender {
    NSString * Parametros = [NSString stringWithFormat:@"op=verificar&usuario=%@&password=%@", _txtUsuario.text, _txtPassword.text];
    NSDictionary * r = [conex conectar:@"Usuarios.php" PARAMETROS:Parametros];
    NSLog(@"%@",r);
}

/*
-(void)AlertaSimple: (NSString *)Titulo MENSAJE: (NSString*) Mensaje
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:Titulo message:Mensaje preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * aceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
    [alerta addAction:aceptar];
    [self presentViewController:alerta animated:YES completion:nil];
}
 */
@end
