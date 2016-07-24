//  VCbuscar.h
//  Crower
//  Created by Carolina Delgado on 13/07/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.

#import <UIKit/UIKit.h>


@interface VCbuscar : UIViewController<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *barraBuscar;
@property (weak, nonatomic) IBOutlet UITableView *tabla;

@end
