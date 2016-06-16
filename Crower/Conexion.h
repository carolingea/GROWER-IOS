

#import <Foundation/Foundation.h>

@interface Conexion : NSObject

@property (nonatomic, strong, readwrite) NSString * MiUrlBase;

-(NSDictionary*)conectar: (NSString*)PAGINA PARAMETROS:(NSString*)PARAMS;


-(void)conectar: (NSString*)PAGINA PARAMETROS:(NSString*)PARAMS CALLBACK:(void(^)(NSData * data, NSURLResponse * response, NSError * error)) CallBack;


@end
