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
    NSDictionary * info;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Util = [[Utilerias alloc]init];
    Conex = [[Conexion alloc]init];
    
    info = [[NSBundle mainBundle]infoDictionary];
    
    _lblTituloCat.text = _Titulo;

    //--- Cargar Loading ---------
    [_loading startAnimating];
    
    //--- Cargar imagen ----------
    _imgHeader.image = [Util DescargarImagen: [NSString stringWithFormat:@"%@%@%@",info[@"URL"], info[@"URLcategorias"],_Imagen]];
    
    //---- Cargar Colección --------
    [Conex conectar:@"Contenidos.php" PARAMETROS:[NSString stringWithFormat:@"Id_categoria=%@", _ID] CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            Contenidos = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            ArrID = [Contenidos mutableArrayValueForKey:@"Id_contenido"];
            ArrTitulo = [Contenidos mutableArrayValueForKey:@"Titulo"];
            ArrImagenes = [Contenidos mutableArrayValueForKey:@"Imagen"];
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
    
    
    // IMAGEN REDONDEADA
    Celda.imgContenido.layer.cornerRadius = Celda.imgContenido.frame.size.width/2;
    Celda.imgContenido.layer.masksToBounds = YES;
    
    // CARGAR INFO IMAGEN
    Celda.imgContenido.image = [Util DescargarImagen:[NSString stringWithFormat:@"%@%@%@",info[@"URL"], info[@"URLcontenidosMini"], ArrImagenes[indexPath.row]]];
    [_loading stopAnimating];
    return Celda;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    vermeet = [self.storyboard instantiateViewControllerWithIdentifier:@"vermeet"];
    vermeet.ID = ArrID[indexPath.row];
    vermeet.Titulo = ArrTitulo[indexPath.row];
    vermeet.Imagen = ArrImagenes[indexPath.row];
    [self presentViewController:vermeet animated:YES completion:nil];
    */
    [self performSegueWithIdentifier:@"seq_contmeet" sender:indexPath];
    [_loading stopAnimating];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath * pos = (NSIndexPath *) sender;
    if ([[segue identifier] isEqualToString:@"seq_contmeet"]) {
        vermeet = [segue destinationViewController];
        vermeet.ID = ArrID[pos.row];
        vermeet.Titulo = ArrTitulo[pos.row];
        vermeet.Imagen = ArrImagenes[pos.row];
    }
}

@end
