

#import "Prueba.h"

@interface Prueba ()

@end

@implementation Prueba{
    __block PHObjectPlaceholder *placeholder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    Piker = [[UIImagePickerController alloc]init];
    Piker.delegate = self;
}


- (IBAction)btnPrueba1:(id)sender {
    Piker.mediaTypes = [[NSArray alloc]initWithObjects:@"public.movie",@"public.image", nil];
    Piker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    [self presentViewController:Piker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
     NSURL * ReferenciaURL = [info objectForKey:UIImagePickerControllerReferenceURL];
     PHFetchResult *result = [PHAsset fetchAssetsWithALAssetURLs:@[ReferenciaURL] options:nil];
     PHAsset * Asset = result.firstObject;
     PHImageManager *manager = [PHImageManager defaultManager];
    
     [manager requestAVAssetForVideo:Asset options:nil resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable infoasset) {
         NSLog(@"%@", ((AVURLAsset*)asset).URL);
     }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
