//  Created by Carolina Delgado on 12/06/16.

#import "VCvermeet.h"
#import "Conexion.h"
#import "Utilerias.h"

@interface VCvermeet ()

@end

@implementation VCvermeet
{
    Conexion * Conex;
    Utilerias * Util;
    NSDictionary * info;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    Conex = [[Conexion alloc]init];
    Util = [[Utilerias alloc]init];
    
    info = [[NSBundle mainBundle]infoDictionary];
    
    _lblTitulo.text = _Titulo;
    
    
    //----- Cargar imagen header ------
    dispatch_async(dispatch_get_main_queue(), ^{
    //_imgHeader.image = [Util DescargarImagen: [NSString stringWithFormat: @"http://45.56.120.97/php/io/img/contenidos/%@", _Imagen]];
    _imgHeader.image = [Util DescargarImagen: [NSString stringWithFormat:@"%@%@%@",info[@"URL"], info[@"URLcontenidos"], _Imagen]];
    });
    
    //---- Cargar contenido -----------
    [_loading startAnimating];
    [Conex conectar:@"VerContenido.php" PARAMETROS:[NSString stringWithFormat:@"Id_contenido=%@", _ID] CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary * Contenido = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSMutableArray * Conten = [Contenido mutableArrayValueForKey:@"Contenido"];
            if (Conten.count > 0) {
                
                NSAttributedString * ContHTML = [[NSAttributedString alloc]initWithData:[Conten[0] dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
                
                _tvContenido.attributedText = ContHTML;
            }
            [_loading stopAnimating];
        });
        
    }];
    
}


- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
