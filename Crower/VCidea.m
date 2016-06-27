
#import "VCidea.h"
#import "Utilerias.h"

@interface VCidea ()

@end

@implementation VCidea
{
    Utilerias * Util;
    UIImagePickerController * PICKER;
    NSDictionary * informacion;
    float total;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _ProgresoSubida.hidden = YES;
    PICKER = [[UIImagePickerController alloc]init];
    PICKER.delegate = self;
    informacion = [[NSBundle mainBundle]infoDictionary];
    Util = [[Utilerias alloc]init];
    
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
        [self AlertaYguardar:Ruta];
    }
    else
    {
        
        
    }
    
}



-(void)AlertaYguardar: (NSString*) Ruta
{
    
    //dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController * Alerta = [Util AlertaPreguntaCallback:@"Enviar idea" MENSAJE:@"¿Deseas enviar tu idea?" CALLBACK:^(UIAlertAction *action){
            _ProgresoSubida.hidden = NO;
        
            NSURL * UrlArchivo = Ruta;
            NSString * archivo = [UrlArchivo lastPathComponent];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:[NSURL URLWithString: [NSString stringWithFormat: @"%@/ideas.php",informacion[@"URL"]]]];
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
    //});
}



@end
