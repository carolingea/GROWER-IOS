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
    NSString * RutaCategoria;

    NSDictionary * info;

- (void)viewDidLoad {
    [super viewDidLoad];
    conex = [[Conexion alloc]init];
    util = [[Utilerias alloc]init];
    
    //---- TRAER RUTAS DE LAS CARPETAS DEL info.plist
    
    info = [[NSBundle mainBundle]infoDictionary];
    
    
    
    //----------- COLECCION DE CATEGORIAS ------------------
    [_loading startAnimating];
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
    NSLog(@"%@",RutaCategoria);
    //---------Traer datos servicio Json ---http://45.56.120.97/php/io/utilerias.php?op=LISTAR_ARCHIVOS&carpeta=img/slider
    [conex conectar:@"utilerias.php" PARAMETROS:@"op=LISTAR_ARCHIVOS&carpeta=back/web/img/slider" CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
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
        
        NSString*URL = [NSString stringWithFormat:@"%@%@%@", info[@"URL"], info[@"URLslider"], [Imagenes objectAtIndex:i]];
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
    
    NSString * rutaimagen = [NSString stringWithFormat:@"%@%@%@", info[@"URL"], info[@"URLcategoriasMini"], ColImagenes[indexPath.row]];
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
       /*
        meetContenidos = [self.storyboard instantiateViewControllerWithIdentifier:@"meetcontenidos"];
        meetContenidos.Titulo = Coltextos[indexPath.row];
        meetContenidos.ID = ColID[indexPath.row];
        meetContenidos.Imagen = ColImagenes[indexPath.row];
        meetContenidos.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        [self presentViewController:meetContenidos animated:YES completion:^{
         
            [_loading stopAnimating];
        }];
        */
        [self performSegueWithIdentifier:@"seq_catmeet" sender:indexPath];
        [_loading stopAnimating];
    });
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"seq_catmeet"]) {
        NSIndexPath * pos = (NSIndexPath*)sender;
        VCmeetUpsContenidos * meetContenidos;
        meetContenidos = [segue destinationViewController];
        meetContenidos.Titulo = Coltextos[pos.row];
        meetContenidos.ID = ColID[pos.row];
        meetContenidos.Imagen = ColImagenes[pos.row];
        meetContenidos.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    /*
     vcVista2 * destino = [segue destinationViewController];
     
     if ([[segue identifier] isEqualToString:@"ir"]) {
     destino.Mensaje = @"Saludos terricolas";
     }*/
}





@end
