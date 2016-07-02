#import "Conexion.h"

@implementation Conexion
{
    //http://45.56.120.97/php/io/Usuarios.php?op=registrar&usuario=carolingea&password=asdf1234
    //http://45.56.120.97/php/io/Usuarios.php?op=verificar&usuario=carolingea&password=asdf1234
    
}

@synthesize MiUrlBase;
NSURL * URL;
NSMutableURLRequest * REQUEST;
NSURLSession * SESION;
NSURLSessionTask * TAREA;
NSString * URLbase;
NSDictionary * result;


+ (void)initialize
{
    if (self == [Conexion class]) {
        NSDictionary * info = [[NSBundle mainBundle]infoDictionary];
        //URLbase = @"http://45.56.120.97/php/io";
        URLbase = info[@"URL"];
        
    }
}

-(void)iniciar: (NSString*)Pagina PARAMETROS: (NSString*)ParamGet
{
    NSString * ruta = [NSString stringWithFormat:@"%@/%@?%@", URLbase, Pagina, ParamGet];
    ruta = [ruta stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; // Para los espacios
    //[urlText stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]
    URL = [NSURL URLWithString:ruta];
    REQUEST = [NSMutableURLRequest requestWithURL:URL];
    SESION = [NSURLSession sharedSession];
}

-(void)conectar: (NSString*)PAGINA PARAMETROS:(NSString*)PARAMS CALLBACK:(void(^)(NSData * data, NSURLResponse *  response, NSError * error)) CallBack
{
    [self iniciar:PAGINA PARAMETROS:PARAMS];
    TAREA = [SESION dataTaskWithRequest:REQUEST completionHandler:CallBack];
    [TAREA resume];
 
}


-(NSDictionary*)conectar: (NSString*)PAGINA PARAMETROS:(NSString*)PARAMS
{
    [self iniciar:PAGINA PARAMETROS:PARAMS];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    TAREA = [SESION dataTaskWithRequest:REQUEST completionHandler:^(NSData * data, NSURLResponse * response, NSError * error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            result = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
        });
        
    }];
    [TAREA resume];
    return result;
}



@end
