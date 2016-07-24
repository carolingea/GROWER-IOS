//  VCmisIdeas.m
//  Crower
//  Created by Carolina Delgado on 3/07/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.


#import "VCmisIdeas.h"
#import "celdaMisIdeas.h"
#import "Utilerias.h"
#import "Conexion.h"


@interface VCmisIdeas ()

@end

@implementation VCmisIdeas
{
    Conexion * conex;
    celdaMisIdeas * celda;
    Utilerias * util;
    NSMutableDictionary * ideas;
    NSString * Id_usuario;
    NSDictionary * info;
    NSArray * arrIdeas;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tablaIdeas.delegate = self;
    [_Loading startAnimating];
    celda = [[celdaMisIdeas alloc]init];
    util = [[Utilerias alloc]init];
    conex = [[Conexion alloc]init];
    info = [[NSBundle mainBundle]infoDictionary];

    Id_usuario = [[NSUserDefaults standardUserDefaults]valueForKey:@"Id_usuario"];
    NSString * parametros = [NSString stringWithFormat:@"op=veridea&Id_usuario=%@", Id_usuario];
    [conex conectar:@"VerIdeas.php" PARAMETROS:parametros CALLBACK:^(NSData *data, NSURLResponse *response, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            ideas = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            [_tablaIdeas reloadData];
            [_tablaIdeas reloadInputViews];
            [_Loading stopAnimating];
        });
        
    }];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ideas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    celda = [collectionView dequeueReusableCellWithReuseIdentifier:@"celdamisideas" forIndexPath:indexPath];
    NSString * URLidea = [NSString stringWithFormat:@"%@%@%@", [info valueForKey:@"URL"],[info valueForKey:@"URLidea"], [ideas valueForKey:@"Idea"][indexPath.row]];
    
    /************ GENERAR MINIATURA VIDEO ***************/
    NSURL * urlidea = [[NSURL alloc]initWithString:URLidea];
    AVURLAsset * Asset = [[AVURLAsset alloc]initWithURL:urlidea options:nil];
    AVAssetImageGenerator * generador = [[AVAssetImageGenerator alloc]initWithAsset:Asset];
    generador.appliesPreferredTrackTransform = YES;
    CMTime MiniTiempo = CMTimeMake(1, 60);
    generador.maximumSize = CGSizeMake(50,50);
    CGImageRef imgRef = [generador copyCGImageAtTime:MiniTiempo actualTime:nil error:nil];
    /***************************************************/
    
    celda.imgMini.image = [UIImage imageWithCGImage:imgRef];
    celda.NombreVideo = URLidea;
    
    return celda;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString * rutavideo = [NSString stringWithFormat:@"%@%@%@", [info valueForKey:@"URL"], [info valueForKey:@"URLidea"], [ideas valueForKey:@"Idea"][indexPath.row]];
    
    NSURL * URLVIDEO = [NSURL URLWithString:rutavideo];
    
    miplayer = [[AVPlayer alloc]initWithURL: URLVIDEO];
    vcplayer = [[AVPlayerViewController alloc]init];
    vcplayer.player = miplayer;
    [self presentViewController:vcplayer animated:YES completion:^{
        [miplayer play];
    }];
}




@end
