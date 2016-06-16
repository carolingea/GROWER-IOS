//  VCfeedbacks.h
//  Crower
//  Created by Carolina Delgado on 8/06/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface VCfeedbacks : UIViewController<MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
- (IBAction)btnCerrar:(id)sender;
- (IBAction)btnEnviar:(id)sender;
@property (nonatomic, strong) MFMailComposeViewController * email;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtAsunto;
@property (weak, nonatomic) IBOutlet UITextView *txtMensaje;


@end
