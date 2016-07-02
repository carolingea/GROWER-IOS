//  VCfacebook.h
//  Crower
//  Created by Carolina Delgado on 29/06/16.

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface VCfacebook : UIViewController<FBSDKLoginButtonDelegate, FBSDKSharingDelegate, FBSDKLoginTooltipViewDelegate, FBSDKGraphRequestConnectionDelegate, FBSDKAppInviteDialogDelegate>


@property (weak, nonatomic) IBOutlet UIView *viewBotonFace;
@property (weak, nonatomic) IBOutlet UIButton *btnIngresarConFaceOutlet;
- (IBAction)btnIngresarConFace:(id)sender;
- (IBAction)btnIniciarCorreo:(id)sender;
- (IBAction)btnRegistrarse:(id)sender;

@end
