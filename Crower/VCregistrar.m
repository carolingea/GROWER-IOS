#import "VCregistrar.h"
#import "Conexion.h"
#import "VCslider.h"
#import "Utilerias.h"

@interface VCregistrar ()

@end

@implementation VCregistrar{
    CGFloat POSINICIAL;
    CGFloat ALTO;
    Conexion * conex;
    Utilerias * Util;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    conex = [[Conexion alloc]init];
    Util = [[Utilerias alloc]init];
    POSINICIAL = _vistaRegistro.frame.origin.y;
    //ALTO = self.view.frame.size.height;
    ALTO = _vistaRegistro.frame.origin.y;
    _txtUsuario.delegate = self;
    _txtPassword.delegate = self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self DesplazarTeclado:POSINICIAL];
    [self.view endEditing:YES];
}

-(void)DesplazarTeclado:(CGFloat)ALTO_
{
    [UIView animateWithDuration:0.5 animations:^{
        _vistaRegistro.frame = CGRectMake(_vistaRegistro.frame.origin.x, ALTO_, _vistaRegistro.frame.size.width, _vistaRegistro.frame.size.height);
    }];
    
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self DesplazarTeclado:ALTO/2];
    return YES;
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    switch (textField.tag) {
        case 0:
            [self.view endEditing:YES];
            break;
    }
    return YES;
}

- (IBAction)btnRegistrarse:(id)sender {
    if (![_txtUsuario.text isEqualToString:@""] &&  ![_txtPassword.text isEqualToString:@""]) {
        
        NSString * Param = [NSString stringWithFormat:@"op=registrar&usuario=%@&password=%@", _txtUsuario.text, _txtPassword.text];
        [conex conectar:@"Usuarios.php" PARAMETROS:Param CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary * res = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSLog(@"%@", res);
                if (res.count > 0) {
                    int num = [[res valueForKey:@"Resp"][0]intValue];
                    if (num != 0) {
                        [[NSUserDefaults standardUserDefaults]setObject:[res valueForKey:@"Id_usuario"][0] forKey:@"Id_usuario"]; // Sesión
                        
                        UIAlertController * Alerta = [Util AlertaCallback:@"Registro" MENSAJE:@"Usuario creado correctamente" CALLBACK:^(UIAlertAction * _Nonnull action) {
                            
                            //VCslider * slider = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
                            //[self presentViewController:slider animated:YES completion:nil];
                            [self performSegueWithIdentifier:@"seg_slider" sender:self];
                            
                        }];
                        [self presentViewController:Alerta animated:YES completion:nil];
                        
                    }
                    else{
                        NSLog(@"Usuario ya existe");
                        UIAlertController * Alerta = [Util AlertaSimple:@"Registro" MENSAJE:@"El usuario ya existe. Por favor escriba otro"];
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

- (IBAction)btnMostrarClave:(id)sender {
    if ([_txtPassword isSecureTextEntry]) {
        _txtPassword.secureTextEntry = NO;
    }
    else
    {
        _txtPassword.secureTextEntry = YES;
    }
}
@end
