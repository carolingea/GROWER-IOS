//  Utilerias.h
//  Crower
//  Created by Carolina Delgado on 7/06/16.



#import <UIKit/UIKit.h>

@interface Utilerias : UIViewController
@property (nonatomic, strong) NSString * UrlCat;

-(UIAlertController*)AlertaSimple: (NSString *)Titulo MENSAJE: (NSString*) Mensaje;

-(UIAlertController*)AlertaCallback: (NSString *)Titulo MENSAJE: (NSString*) Mensaje CALLBACK:(void(^)(UIAlertAction * _Nonnull action))Callback;

-(UIAlertController*)AlertaPreguntaCallback: (NSString *)Titulo MENSAJE: (NSString*) Mensaje CALLBACK:(void(^)(UIAlertAction *  action))Callback;

-(UIImage*)DescargarImagen:(NSString*) RUTA;

-(UIImage*)DescargarImagenNombre:(NSString*) NOMBRE;


@end


