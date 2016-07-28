
#import "VCidea.h"
#import "Utilerias.h"
#import "VCmisIdeas.h"
#import "Conexion.h"

@interface VCidea ()

@end

@implementation VCidea
{
    Utilerias * Util;
    Conexion * conex;
    UIImagePickerController * PICKER;
    NSDictionary * informacion;
    NSString * Id_usuario;
    float total;
    CGImageRef mini;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ProgresoSubida.hidden = YES;
    PICKER = [[UIImagePickerController alloc]init];
    PICKER.delegate = self;
    informacion = [[NSBundle mainBundle]infoDictionary];
    Util = [[Utilerias alloc]init];
    conex = [[Conexion alloc]init];
    self.navigationController.navigationBar.hidden = NO;
    
    // DATOS DE USUARIO
    Id_usuario = [[NSUserDefaults standardUserDefaults]valueForKey:@"Id_usuario"];
    //Id_usuario =@"1";
}

-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didSendBodyData:(int64_t)bytesSent totalBytesSent:(int64_t)totalBytesSent totalBytesExpectedToSend:(int64_t)totalBytesExpectedToSend
{
    NSLog(@"%lld",totalBytesSent);
    _ProgresoSubida.progress = totalBytesSent/total;
}


- (IBAction)btnGrabarIdea:(id)sender {
    PICKER.sourceType = UIImagePickerControllerSourceTypeCamera;
    PICKER.mediaTypes = [[NSArray alloc]initWithObjects:@"public.movie", nil];
    PICKER.editing = NO;
    [PICKER setModalPresentationStyle:UIModalPresentationPageSheet];
    [self presentViewController:PICKER animated:YES completion:nil];
    
}

- (IBAction)btnVerMisIdeas:(id)sender {
    //VCmisIdeas * misideas = [[VCmisIdeas alloc]init];
    //misideas = [self.storyboard instantiateViewControllerWithIdentifier:@"misIdeas"];
    //[self presentViewController:misideas animated:YES completion:nil];
    [self performSegueWithIdentifier:@"seg_misideas" sender:self];
    
}

- (IBAction)btnObtenerGaleria:(id)sender {
    PICKER.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    PICKER.mediaTypes = [[NSArray alloc]initWithObjects:@"public.movie", nil];
    PICKER.editing = NO;
    [PICKER setModalPresentationStyle:UIModalPresentationPageSheet];
    [self presentViewController:PICKER animated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSString * Ruta = info[@"UIImagePickerControllerMediaURL"];
    if (Ruta != NULL) {
        // Generar Miniatura
        
        AVURLAsset * Asset = [[AVURLAsset alloc]initWithURL:(NSURL*)Ruta options:nil];
        AVAssetImageGenerator * generador = [[AVAssetImageGenerator alloc]initWithAsset:Asset];
        generador.appliesPreferredTrackTransform = YES;
        CMTime miniTime = CMTimeMake(1, 60);
        generador.maximumSize = CGSizeMake(50, 50);
        mini = [generador copyCGImageAtTime:miniTime actualTime:nil error:nil];
        _imgminiatura.image =[UIImage imageWithCGImage:mini];
        
        _ProgresoSubida.hidden = NO;
        
        
        /*********** GENERAR NOMBRE ARCHIVO *************/
        NSString * Nombre =[Util generarNombre:@""];
        NSString * VideoNombre = [NSString stringWithFormat:@"%@.%@", Nombre, [Ruta pathExtension]];
        NSString * MiniaturaNombre = [NSString stringWithFormat:@"%@.%@", Nombre, @"jpg"];
        
        
        
        
        /*************** MINIATURA ***************/
        NSData * imaData = UIImageJPEGRepresentation([UIImage imageWithCGImage:mini], 0.8);
        [self guardarArchivo: MiniaturaNombre Datos:imaData CALLBACK:^{
            NSLog(@"Terminado de subir MINIATURA");
            
            /************ ARCHIVO ********************/
            //NSURL * UrlArchivo = (NSURL*)Ruta;
            //NSString * archivo = [UrlArchivo lastPathComponent];
            NSLog(@"%@",[Ruta pathExtension] );
            
            NSData * datos = [NSData dataWithContentsOfFile:Ruta];
            [self guardarArchivo:VideoNombre Datos:datos CALLBACK:^{
                NSLog(@"%@",@"Terminada de subir VIDEO");
                /*********** GUARDAR EN LA BASE DE DATOS *************/
                NSString * PARAMS = [NSString stringWithFormat:@"op=guardaridea&Id_usuario=%@&Mini=%@&Idea=%@", Id_usuario, MiniaturaNombre, VideoNombre];
                
                [conex conectar:@"VerIdeas.php" PARAMETROS:PARAMS CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSLog(@"%@",@"GUARDADO EN LA BD");
                    });
                }];
                
            }];
        }];
        
        
        /********************************/
        
        
        //[self AlertarGuardar:Ruta];
        
        //[self subirImagen:[UIImage imageWithCGImage:mini]];
        
        //[self guardar:Ruta];  // Miniatura
        
        //[self AlertaYguardar:Ruta];
        
    }
    else
    {
        NSLog(@"Pailas!");
    }
}


-(void)AlertarGuardar: (NSString*) Ruta
{
    UIAlertController * Alerta = [Util AlertaPreguntaCallback:@"Enviar idea" MENSAJE:@"¿Deseas enviar tu idea?" CALLBACK:^(UIAlertAction *action){
        [self subirImagen:[UIImage imageWithCGImage:mini]];
        [self guardar:Ruta];
        
    }];
    [self presentViewController:Alerta animated:YES completion:nil];
}

/*
 -(void)conectar: (NSString*)PAGINA PARAMETROS:(NSString*)PARAMS CALLBACK:(void(^)(NSData * data, NSURLResponse *  response, NSError * error)) CallBack
 
 void (^bloque)(void) = ^(void) {
 */




-(void)guardarArchivo: (NSString*) archivo Datos:(NSData*) datos CALLBACK:(void(^)(void))Callback
{
    //NSURL * UrlArchivo = Ruta;
    //NSString * archivo = [UrlArchivo lastPathComponent];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/ideas.php?Id_usuario=%@",informacion[@"URL"], Id_usuario]]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"archivo\"; filename=\"%@\"\r\n", archivo] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    //NSData * datos = [NSData dataWithContentsOfFile:Ruta];
    [body appendData:datos];
    total = datos.length; // Total bytes de la petición
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * SESION = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * TAREA = [SESION uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finish!");
        dispatch_async(dispatch_get_main_queue(), ^{
            Callback();
        });
    }];
    
    [TAREA resume];
}




-(void) subirImagen: (UIImage*)Imagen
{
    NSData * imagendata = [[NSData alloc]init];
    imagendata = UIImageJPEGRepresentation(Imagen, 0.8);
    
    //NSURL * UrlArchivo = Ruta;
    NSString * archivo = @"imagen.jpg";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/ideas.php?Id_usuario=%@",informacion[@"URL"], Id_usuario]]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"archivo\"; filename=\"%@\"\r\n", archivo] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSData * datos = imagendata;
    [body appendData:datos];
    total = datos.length; // Total bytes de la petición
    
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession * SESION = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask * TAREA = [SESION uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"Finish!");
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _ProgresoSubida.hidden = YES;
            
        });
    }];
    
    [TAREA resume];
    
}

-(void)guardar: (NSString*) Ruta
{
        NSURL * UrlArchivo = Ruta;
        NSString * archivo = [UrlArchivo lastPathComponent];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/ideas.php?Id_usuario=%@",informacion[@"URL"], Id_usuario]]];
        [request setHTTPMethod:@"POST"];
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        NSMutableData *body = [NSMutableData data];
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"archivo\"; filename=\"%@\"\r\n", archivo] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        NSData * datos = [NSData dataWithContentsOfFile:Ruta];
        [body appendData:datos];
        total = datos.length; // Total bytes de la petición
        
        [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setHTTPBody:body];
        
        NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        NSURLSession * SESION = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
        
        NSURLSessionDataTask * TAREA = [SESION uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            NSLog(@"Finish!");
            dispatch_async(dispatch_get_main_queue(), ^{
                UIAlertController * mensaje = [Util AlertaSimple:@"Wiii!" MENSAJE:@"Su idea ha sido enviada correctamente!"];
                [self presentViewController:mensaje animated:YES completion:nil];
                _ProgresoSubida.hidden = YES;
                _ProgresoSubida.progress = 0;
            });
        }];
        
        [TAREA resume];
}


-(void)AlertaYguardar: (NSString*) Ruta
{
        UIAlertController * Alerta = [Util AlertaPreguntaCallback:@"Enviar idea" MENSAJE:@"¿Deseas enviar tu idea?" CALLBACK:^(UIAlertAction *action){
            _ProgresoSubida.hidden = NO;
        
            NSURL * UrlArchivo = Ruta;
            NSString * archivo = [UrlArchivo lastPathComponent];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/ideas.php?Id_usuario=%@",informacion[@"URL"], Id_usuario]]];
            [request setHTTPMethod:@"POST"];
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
            [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"archivo\"; filename=\"%@\"\r\n", archivo] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSData * datos = [NSData dataWithContentsOfFile:Ruta];
            [body appendData:datos];
            total = datos.length; // Total bytes de la petición
            
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
             
            NSURLSession * SESION = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
            
            NSURLSessionDataTask * TAREA = [SESION uploadTaskWithRequest:request fromData:body completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                NSLog(@"Finish!");
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIAlertController * mensaje = [Util AlertaSimple:@"Wiii!" MENSAJE:@"Su idea ha sido enviada correctamente!"];
                    [self presentViewController:mensaje animated:YES completion:nil];
                    _ProgresoSubida.hidden = YES;
                    _ProgresoSubida.progress = 0;
                });
            }];
            
            [TAREA resume];
        
        }];
        [self presentViewController:Alerta animated:YES completion:nil];
}

@end
