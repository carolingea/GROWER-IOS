//  celdaBuscar.h
//  Crower
//  Created by Carolina Delgado on 13/07/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.


#import <UIKit/UIKit.h>

@interface celdaBuscar : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UIImageView *imgMini;
@property (nonatomic, strong) NSString * Id;
@end
