//
//  Utilerias.h
//  Crower
//
//  Created by Carolina Delgado on 7/06/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Utilerias : UIViewController
-(UIAlertController*)AlertaSimple: (NSString *)Titulo MENSAJE: (NSString*) Mensaje;

-(UIAlertController*)AlertaCallback: (NSString *)Titulo MENSAJE: (NSString*) Mensaje CALLBACK:(void(^)(UIAlertAction * _Nonnull action))Callback;

-(UIImage*)DescargarImagen:(NSString*) RUTA;

-(UIImage*)DescargarImagenNombre:(NSString*) NOMBRE;


@end


