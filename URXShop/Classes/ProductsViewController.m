//
//  ProductsViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ProductsViewController.h"
#import "portableChargerCell.h"

#define ROW_HEIGHT 230.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface ProductsViewController ()

@property (nonatomic, retain) NSMutableDictionary *sections;
@property (nonatomic, retain) NSMutableDictionary *sectionToTypeMap;

@end

@implementation ProductsViewController
@synthesize item = _item,sections = _sections,sectionToTypeMap = _sectionToTypeMap;


- (PFQuery *)queryForTable {
    PFQuery *query = [PFQuery queryWithClassName:self.className];
    
    // If Pull To Refresh is enabled, query against the network by default.
    if (self.pullToRefreshEnabled) {
        query.cachePolicy = kPFCachePolicyNetworkOnly;
    }
    
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    // Order by sport type
    [query orderByAscending:@"type"];
    return query;
}

- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *type = [self typeForSection:indexPath.section];
    
    NSArray *rowIndecesInSection = [self.sections objectForKey:type];
    
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    PFObject *product = [self.objects objectAtIndex:[rowIndex intValue]];
    return product;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *type = [self typeForSection:section];
    return type;
}
 /*
//設定分類開頭標題
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    switch (section) {
        case 0:
            return @"耳機";
            break;
            
        case 1:
            return @"行動電源";
            break;
            
        case 2:
            return @"行動喇叭";
            break;
            
        default:
            return @"";
            break;
    }
}*/


#pragma mark - ()
- (NSString *)typeForSection:(NSInteger)section {
    return [self.sectionToTypeMap objectForKey:[NSNumber numberWithInt:section]];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
       
        // The className to query on
        self.className = @"AllProducts";
        
		// Whether the built-in pull-to-refresh is enabled
		self.pullToRefreshEnabled = YES;
        
		// Whether the built-in pagination is enabled
		self.paginationEnabled = YES;
        
		// The number of objects to show per page
		self.objectsPerPage = 100;
        self.sections = [NSMutableDictionary dictionary];
        self.sectionToTypeMap = [NSMutableDictionary dictionary];
        
        // Set the tabBarItem icon:
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"所有商品" image:[UIImage imageNamed:@"44-shoebox.png"] tag:0];
        self.tabBarItem = tabBarItem;
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //[self.tableView registerClass:[headphoneCell class] forCellReuseIdentifier:@"ItemCell"];
    [self.tableView registerClass:[portableChargerCell class] forCellReuseIdentifier:@"ItemCell"];
    
    // Add observer for NSNotification:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectProductWithNotification:) name:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil];
}

- (void)viewDidUnload
{
    // Remove NSNotification:
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PFQueryTableViewController datasource methods

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    [self.sections removeAllObjects];
    [self.sectionToTypeMap removeAllObjects];
    
    NSInteger section = 0;
    NSInteger rowIndex = 0;
    for (PFObject *object in self.objects) {
        NSString *type = [object objectForKey:@"type"];
        NSMutableArray *objectsInSection = [self.sections objectForKey:type];
        
        if (!objectsInSection) {
            objectsInSection = [NSMutableArray array];
            
            // this is  the first time we see this sportType - increment the section index
            [self.sectionToTypeMap setObject:type forKey:[NSNumber numberWithInt:section++]];

            NSString *str1=@"objectsInSection空，sectionToTypeMap";
            NSString *str2=@"加入第";
            NSString *str3=@"section";
            NSString *str = [NSString stringWithFormat:@"%@%@%i%@",str1,str2,section,str3];
            NSLog(@"%@",str);
        }
        [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
        [self.sections setObject:objectsInSection forKey:type];
        NSLog(@"Sections加物件");
    }
}


- (void)objectsWillLoad {
    [super objectsWillLoad];
    // This method is called before a PFQuery is fired to get more objects
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"ItemCell";
    
            portableChargerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (!cell) {
                cell = [[portableChargerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
    
        NSString *type = [object objectForKey:@"type"];
        NSMutableArray *objectsInSection = [self.sections objectForKey:type];
        NSLog(@"objectsInSection.count：%d",objectsInSection.count);
        PFObject *product1= [self objectAtIndexPath:indexPath];
        //PFObject *product = self.objects[indexPath.row];
        [cell configureProduct:product1];
        NSLog(@"CelForRow:%@",indexPath);
    
    return cell;
}


#pragma mark - UITableViewDataSource
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    int i=self.sections.allKeys.count;
    NSLog(@"numberOfSection:%d", i);
    return self.sections.allKeys.count;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *type = [self typeForSection:section];
    NSArray *rowIndecesInSection = [self.sections objectForKey:type];
    NSLog(@"NumberOfRowInSection%drow",rowIndecesInSection.count);
    return rowIndecesInSection.count;
    
}

/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int i=0,CountOne=0,CountTwo=0,CountThree=0 ;
    int type=0;
    if (i<=self.objects.count-1)
    {
        static NSString *CellIdentifier = @"ItemCell";
        portableChargerCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:i];
        
        if (!cell) {
            cell = [[portableChargerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        PFObject *product = self.objects[indexPath.row];
        
        PFObject *product =self.objects[i];
        type=[product[@"type"] intValue];
        if(type==1)
        {
            CountOne+= 1;
        }
        else if(type==2)
        {
            CountTwo+= 1;
        }
        else if(type==3)
        {
            CountThree+= 1;
        }
        else{}
        
        i++;
    }
 
    if(section==0)
    {
        return CountOne;
    }
    else if(section==1)
    {
        return CountTwo;
    }
    else if(section==2)
    {
        return CountThree;
    }
    // Return the number of rows in the section.
        return [self.objects count];
}*/


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"HFR%fheight",ROW_HEIGHT);
    return ROW_HEIGHT;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    PFObject *selectedObject = [self objectAtIndexPath:indexPath];
    [self selectProduct:[self.objects objectAtIndex:indexPath.row]];
    //[self selectProduct:[self.objects objectAtIndex:indexPath.row]];
}

#pragma mark - NSNotification handler
- (void)selectProductWithNotification:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSInteger product_id = [[dict objectForKey:@"product_id"] intValue];
    NSIndexPath *path = [NSIndexPath indexPathForRow:product_id inSection:0];
    [self selectProduct:[self.objects objectAtIndex:path.row]];
}


#pragma mark - Load ProductViewController:
- (void)selectProduct:(PFObject *)product
{
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    portableChargerViewController *portableChargerViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"portableChargerViewController"];
    portableChargerViewController.item = product;
    [self.navigationController pushViewController:portableChargerViewController animated:YES];
}
    
@end
    
