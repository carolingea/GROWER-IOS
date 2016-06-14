//  CVmeetUpsContenidos.m
//  Crower
//  Created by Carolina Delgado on 13/06/16.


#import "VCmeetUpsContenidos.h"
#import "Utilerias.h"
#import "Conexion.h"
#import "celdaMeetContenidos.h"
#import "VCvermeet.h"

@interface VCmeetUpsContenidos ()

@end

Utilerias * Util;
Conexion * Conex;


@implementation VCmeetUpsContenidos{
    celdaMeetContenidos * Celda;
    VCvermeet * vermeet;
    NSMutableArray * ArrImagenes;
    NSMutableArray * ArrTitulo;
    NSMutableArray * ArrID;
    NSMutableArray * ArrDescripcion;
    NSDictionary * Contenidos;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Util = [[Utilerias alloc]init];
    Conex = [[Conexion alloc]init];
    
    _lblTituloCat.text = _Titulo;

    //--- Cargar Loading ---------
    [_loading startAnimating];
    
    //--- Cargar imagen ----------
    _imgHeader.image = [Util DescargarImagen: [NSString stringWithFormat:@"http://45.56.120.97/php/io/img/categorias/%@", _Imagen]];
    
    //---- Cargar Colección --------
    [Conex conectar:@"Contenidos.php" PARAMETROS:[NSString stringWithFormat:@"Id_categoria=%@", _ID] CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            Contenidos = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            ArrID = [Contenidos mutableArrayValueForKey:@"Id_contenido"];
            ArrTitulo = [Contenidos mutableArrayValueForKey:@"Titulo"];
            ArrImagenes = [Contenidos mutableArrayValueForKey:@"Imagen"];
            //ArrDescripcion = [Contenidos mutableArrayValueForKey:@"Descripcion"];
            [_ColContenidos reloadData];
            [_ColContenidos reloadInputViews];
        });
        
    }];
    
}



- (IBAction)btnCerrar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ArrTitulo.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Celda = [collectionView dequeueReusableCellWithReuseIdentifier:@"celda" forIndexPath:indexPath];
    Celda.lblTituloContenido.text = ArrTitulo[indexPath.row];
    Celda.imgContenido.image = [Util DescargarImagen:[NSString stringWithFormat:@"http://45.56.120.97/php/io/img/contenidos/mini/%@", ArrImagenes[indexPath.row]]];
    [_loading stopAnimating];
    return Celda;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    vermeet = [self.storyboard instantiateViewControllerWithIdentifier:@"vermeet"];
    vermeet.ID = ArrID[indexPath.row];
    vermeet.Titulo = ArrTitulo[indexPath.row];
    vermeet.Imagen = ArrImagenes[indexPath.row];
    [self presentViewController:vermeet animated:YES completion:^{
        
    }];
    //NSLog(@"%ld", (long)indexPath.row);
    
}

@end
