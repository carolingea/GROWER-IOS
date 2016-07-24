//  VCbuscar.m
//  Crowet
//  Created by Carolina Delgado on 13/07/16.
//  Copyright © 2016 Carolina Delgado. All rights reserved.


#import "VCbuscar.h"
#import "celdaBuscar.h"
#import "Conexion.h"
#import "Utilerias.h"

@interface VCbuscar ()

@end

@implementation VCbuscar{
    NSArray * contenidos;
    NSArray * imagenes;
    NSArray * filtradoContenidos;
    NSArray * filtradoImagenes;
    Utilerias * util;
    Conexion * conex;
    NSDictionary * filtrado;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabla.delegate = self;
    _barraBuscar.delegate = self;
    
    contenidos = [NSArray arrayWithObjects:@"Alfa", @"Beta", @"Gamma",@"Theta",@"Omicrom",@"Pi",nil];
    imagenes = [NSArray arrayWithObjects:@"miniusuario.png", @"miniemail.png", @"miniemail.png",@"miniusuario.png",@"miniemail.png",@"miniusuario.png",nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tabla) {
        return contenidos.count;
    }
    else{
        [self Filtrar];
        return filtradoContenidos.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    celdaBuscar * celda = [[celdaBuscar alloc]init];
    celda = [tableView dequeueReusableCellWithIdentifier:@"celda" forIndexPath:indexPath];
    
    if (celda == nil) {
        //self.tableView.registerClass(MyCell.classForCoder(), forCellReuseIdentifier: kCellIdentifier)
        [tableView registerClass:[celdaBuscar class] forHeaderFooterViewReuseIdentifier:@"celda"];
    }
    else
    {
        //celda = [tableView dequeueReusableCellWithIdentifier:@"celda" forIndexPath:indexPath];
    }
    
    if (tableView == _tabla) {
        celda.lblTitulo.text = contenidos[indexPath.row];
        //celda.imgMini.image = [UIImage imageNamed:imagenes[indexPath.row]];
    }
    else
    {
        celda.lblTitulo.text = filtradoContenidos[indexPath.row];
        //celda.imgMini.image = [UIImage imageNamed:filtradoImagenes[indexPath.row]];
    }
    
    return celda;
}

-(void)Filtrar
{
    NSPredicate * Pred = [NSPredicate predicateWithFormat:@"SELF contains[search] %@", _barraBuscar.text];
    filtradoContenidos = [[contenidos filteredArrayUsingPredicate:Pred]mutableCopy];
    
    
}

@end
