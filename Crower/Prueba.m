

#import "Prueba.h"

@interface Prueba ()

@end

@implementation Prueba{
    NSArray * valores;
    NSArray * filtrado;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabla.delegate = self;
    _BarraBuscar.delegate = self;
    valores = [NSArray arrayWithObjects:@"Uno", @"Dos", @"Tres", @"Cuatro", @"Cinco", nil];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.tabla) {
        return valores.count;
    }
    else
    {
        [self Filtrar:_BarraBuscar.text];
        return filtrado.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * celda = [[UITableViewCell alloc]init];
    celda = [tableView dequeueReusableCellWithIdentifier:@"celda"];
    
    if (celda ==nil) {
        celda = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celda"];
    }
    
    if (tableView == self.tabla) {
        
        celda.textLabel.text = valores[indexPath.row];
    }
    else
    {
        celda.textLabel.text = filtrado[indexPath.row];
    }
    return celda;
}

-(void)Filtrar: (NSString*) Buscar
{
    NSPredicate * Predicado = [NSPredicate predicateWithFormat:@"SELF contains [search] %@", Buscar];
    filtrado = [[valores filteredArrayUsingPredicate:Predicado]mutableCopy];
}

@end
