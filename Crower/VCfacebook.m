//  VCfacebook.m
//  Crower
//  Copyright © 2016 Carolina Delgado. All rights reserved.

#import "VCfacebook.h"
#import "VClogin.h"
#import "VCslider.h"
#import "VCregistrar.h"
#import "Conexion.h"

@interface VCfacebook ()
@end

@implementation VCfacebook
{
    Conexion * conex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    conex = [[Conexion alloc]init];
    
    FBSDKLoginButton * boton = [[FBSDKLoginButton alloc]init];
    boton.delegate = self;
    [boton setReadPermissions:@[@"public_profile", @"email"]];
    
    boton.frame = _viewBotonFace.frame;
    [self.view addSubview:boton];
    [_viewBotonFace setHidden:YES];
    
    if([FBSDKAccessToken currentAccessToken]== nil)
    {
        NSLog(@"No conectado");
        [_btnIngresarConFaceOutlet setHidden:YES];
    }
    else
    {
        NSLog(@"Login in");
        [_btnIngresarConFaceOutlet setHidden:NO];
        
    }
}


-(BOOL)loginButtonWillLogin:(FBSDKLoginButton *)loginButton
{
    NSLog(@"SE LOGUA: %@", loginButton);
    [_btnIngresarConFaceOutlet setHidden:NO];
    return YES;
}

-(void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton
{
    NSLog(@"SALIO: %@", loginButton);
    [_btnIngresarConFaceOutlet setHidden:YES];
}

-(void)loginButton:(FBSDKLoginButton *)loginButton didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result error:(NSError *)error
{
    NSLog(@"%@",[NSString stringWithFormat:@"@%", result.isCancelled]);
    if (result.isCancelled) {
        NSLog(@"Cancelado");
        [_btnIngresarConFaceOutlet setHidden:YES];
    }
    else if (error)
    {
        NSLog(@"Pailas!");
        [_btnIngresarConFaceOutlet setHidden:YES];
    }
    else // Logueado todo bien!
    {
        [_btnIngresarConFaceOutlet setHidden:NO];
        /*
        VCslider * slider = [[VCslider alloc]init];
        slider = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
        [self presentViewController:slider animated:YES completion:nil];
         */
    }
    
}

- (IBAction)btnIngresarConFace:(id)sender {
    /*
    VCslider * slider = [[VCslider alloc]init];
    slider = [self.storyboard instantiateViewControllerWithIdentifier:@"slider"];
    [self presentViewController:slider animated:YES completion:nil];
     */
    [self registroFace];
}

- (IBAction)btnIniciarCorreo:(id)sender {
    VClogin * login = [[VClogin alloc]init];
    login = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
    [self showViewController:login sender:nil];
}

- (IBAction)btnRegistrarse:(id)sender {
    VCregistrar * registrar = [[VCregistrar alloc]init];
    registrar = [self.storyboard instantiateViewControllerWithIdentifier:@"registrarse"];
    [self showViewController:registrar sender:nil];
}

-(void)registroFace
{
    FBSDKGraphRequest * request = [[FBSDKGraphRequest alloc]initWithGraphPath:@"me" parameters:@{ @"fields": @"id, gender, first_name, last_name, picture, email, name"}];
    
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        
        NSString * nombre = [NSString stringWithFormat:@"%@ %@", [result valueForKey:@"first_name"], [result valueForKey:@"last_name"]];
        NSString * id_face = [result valueForKey:@"id"];
        NSString * email = [result valueForKey:@"email"];
        NSString * imagen = [[[result valueForKey:@"picture"] valueForKey:@"data"] valueForKey:@"url"];
        NSString * genero = [result valueForKey:@"gender"];
        NSString * parametros = [NSString stringWithFormat: @"op=registrarface&id_face=%@&email=%@&imagen=%@&nombre=%@&genero=%@", id_face, email, imagen, nombre, genero];
        [conex conectar:@"Usuarios.php" PARAMETROS:parametros CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary * respuesta = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                if (respuesta.count >0) {
                    NSLog(@"%@",respuesta);
                    // Guardar sesión
                    [[NSUserDefaults standardUserDefaults]setObject:[respuesta objectForKey:@"Id_usuario"] forKey:@"Id_usuario"];
                    
                }
                else{
                    NSLog(@"Pailas!");
                }

            });
            
        }];
        
        
    }];
}


@end
