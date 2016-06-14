// Carolina Delgado Villalobos, junio 2016

#import "VCmeetUps.h"
#import "Conexion.h"
#import "Utilerias.h"
#import "celdaMeetups.h"
#import "VCmeetUpsContenidos.h"

Conexion * conex;
Utilerias * util;
celdaMeetups * Cel;
VCmeetUpsContenidos * meetContenidos;

@interface VCmeetUps ()
@end


@implementation VCmeetUps
NSArray * Imagenes;
NSMutableArray * Coltextos;
NSMutableArray * ColImagenes;
NSMutableArray * ColID;

NSDictionary * categorias;

- (void)viewDidLoad {
    [super viewDidLoad];
    conex = [[Conexion alloc]init];
    util = [[Utilerias alloc]init];
    
    
    //----------- COLECCION DE CATEGORIAS ------------------
    [_loading startAnimating];
    //http://45.56.120.97/php/io/Categorias.php
    [conex conectar:@"Categorias.php" PARAMETROS:@"" CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            categorias = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            Coltextos = [categorias mutableArrayValueForKeyPath:@"Categoria"];
            ColID = [categorias mutableArrayValueForKeyPath:@"Id_categoria"];
            ColImagenes = [categorias mutableArrayValueForKeyPath:@"Imagen"];
            [_ColeccionMeets reloadData];
            [_ColeccionMeets reloadInputViews];
            
        });
        
        
    }];
    
    
    //-------------- SLIDER-------------------
    _ScrollSlider.delegate = self;
    
    //---------Traer datos servicio Json ---http://45.56.120.97/php/io/utilerias.php?op=LISTAR_ARCHIVOS&carpeta=img/slider
    [conex conectar:@"utilerias.php" PARAMETROS:@"op=LISTAR_ARCHIVOS&carpeta=img/slider" CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            __block NSDictionary * d = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray * a = (NSArray*)d;
            [self cargarSlider:a];
            
        });
    }];
    
}

-(void)cargarSlider:(NSArray*)Imagenes
{
    _ScrollSlider.pagingEnabled = YES;
    _PaginasSlider.numberOfPages = [Imagenes count];
    
    for (int i=0; i< [Imagenes count]; i++) {
        CGFloat DX = _ScrollSlider.frame.size.width * i;
        CGFloat Y = 0;
        CGFloat Ancho = _ScrollSlider.frame.size.width;
        CGFloat Alto = _ScrollSlider.frame.size.height;
        
        UIImageView * IMAVIEW = [[UIImageView alloc]initWithFrame:CGRectMake(DX, Y, Ancho, Alto)];
        NSString*URL = [NSString stringWithFormat:@"http://45.56.120.97/php/io/img/slider/%@", [Imagenes objectAtIndex:i]];
        IMAVIEW.image = [util DescargarImagen:URL];
        [_ScrollSlider addSubview:IMAVIEW];
        _ScrollSlider.contentSize = CGSizeMake(Ancho * [Imagenes count], Alto);
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    _PaginasSlider.currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return Coltextos.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Cel  = [collectionView dequeueReusableCellWithReuseIdentifier:@"micelda" forIndexPath:indexPath];
    Cel.lblTitulo.text = Coltextos[indexPath.row];
    NSString * rutaimagen =[NSString stringWithFormat:@"http://45.56.120.97/php/io/img/categorias/mini/%@", ColImagenes[indexPath.row]];
    Cel.imgMiniatura.image = [util DescargarImagen:rutaimagen];
    [_loading stopAnimating];
    return Cel;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [_loading startAnimating];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSLog(@"Global");
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        meetContenidos = [self.storyboard instantiateViewControllerWithIdentifier:@"meetcontenidos"];
        meetContenidos.Titulo = Coltextos[indexPath.row];
        meetContenidos.ID = ColID[indexPath.row];
        meetContenidos.Imagen = ColImagenes[indexPath.row];
        meetContenidos.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:meetContenidos animated:YES completion:^{
            [_loading stopAnimating];
        }];
    
        
    });
    
    
    
}





@end
