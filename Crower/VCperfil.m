//  VCperfil.m
//  Created by Carolina Delgado on 14/06/16.


#import "VCperfil.h"
#import "Conexion.h"
#import "Utilerias.h"

@interface VCperfil ()

@end

@implementation VCperfil

- (void)viewDidLoad {
    [super viewDidLoad];
    Conexion * Conex = [[Conexion alloc]init];
    Utilerias * Util = [[Utilerias alloc]init];
    
    NSDictionary * info = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"%@", [Util UrlCat]);
    
}

- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
