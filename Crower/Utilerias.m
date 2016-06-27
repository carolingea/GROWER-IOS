

#import "Utilerias.h"

@interface Utilerias ()

@end


@implementation Utilerias


- (void)viewDidLoad {
    [super viewDidLoad];
}


-(UIAlertController*)AlertaSimple: (NSString *)Titulo MENSAJE: (NSString*) Mensaje
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:Titulo message:Mensaje preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * aceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:nil];
    [alerta addAction:aceptar];
    return alerta;
}



-(UIAlertController*)AlertaCallback: (NSString *)Titulo MENSAJE: (NSString*) Mensaje CALLBACK:(void(^)(UIAlertAction * _Nonnull action))Callback
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:Titulo message:Mensaje preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * aceptar = [UIAlertAction actionWithTitle:@"Aceptar" style:UIAlertActionStyleCancel handler:Callback];
    [alerta addAction:aceptar];
    return alerta;
}

-(UIAlertController*)AlertaPreguntaCallback: (NSString *)Titulo MENSAJE: (NSString*) Mensaje CALLBACK:(void(^)(UIAlertAction *  action))Callback
{
    UIAlertController *alerta = [UIAlertController alertControllerWithTitle:Titulo message:Mensaje preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction * aceptar = [UIAlertAction actionWithTitle:@"Si" style:UIAlertActionStyleDefault handler:Callback];
    [alerta addAction:no];
    [alerta addAction:aceptar];
    return alerta;
}


-(UIImage*)DescargarImagen:(NSString*) RUTA
{
    NSURL * URL = [NSURL URLWithString:RUTA];
    NSData * DATO = [NSData dataWithContentsOfURL:URL];
    UIImage * IMA = [UIImage imageWithData:DATO];
    return IMA;
}

-(UIImage*)DescargarImagenNombre:(NSString*) NOMBRE
{
    NSString * RUTA = [NSString stringWithFormat:@"http://45.56.120.97/php/io/img/slider/%@", NOMBRE];
    NSURL * URL = [NSURL URLWithString:RUTA];
    NSData * DATO = [NSData dataWithContentsOfURL:URL];
    UIImage * IMA = [UIImage imageWithData:DATO];
    return IMA;
}

@end
