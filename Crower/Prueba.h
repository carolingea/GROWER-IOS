//  Prueba.h
//  Crower
//  Created by Carolina Delgado on 21/06/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.

#import <UIKit/UIKit.h>
#import <Photos/PHPhotoLibrary.h>
#import <Photos/PHAsset.h>
#import <Photos/PHImageManager.h>

@interface Prueba : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController * Piker;
}

- (IBAction)btnPrueba1:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgPrueba;

@end
