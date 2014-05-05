//
//  ShoppingCartViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//
#import "ShoppingCartViewController.h"
#import "StarProductsCell.h"
#import "GAI.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

#define ROW_HEIGHT 220.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface ShoppingCartViewController ()


@end

@implementation ShoppingCartViewController
@synthesize sections = _sections, sectionToTypeMap = _sectionToTypeMap;

- (void) dealloc
{
    [super dealloc];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

//after view
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"s-viewDidAppear");
 
    // returns the same tracker you created in your app delegate
    // defaultTracker originally declared in AppDelegate.m
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName
           value:@"allproductsScreen"];
    
    // manual screen tracking
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        // The className to query on
        self.parseClassName = @"AllProducts";
        
		// Whether the built-in pull-to-refresh is enabled
		self.pullToRefreshEnabled = YES;
        
		// Whether the built-in pagination is enabled
		self.paginationEnabled = YES;
        
		// The number of objects to show per page
		self.objectsPerPage = 30;
        self.sections = [NSMutableDictionary dictionary];
        self.sectionToTypeMap = [NSMutableDictionary dictionary];
        
        // Set the tabBarItem icon:
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推薦商品" image:[UIImage imageNamed:@"152-rolodex.png"] tag:1];
        self.tabBarItem = tabBarItem;
        
        self.starObjects = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[StarProductsCell class] forCellReuseIdentifier:@"ItemCell"];
    
    // Add observer for NSNotification:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectProductWithNotification:) name:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil];
     NSLog(@"s-viewDidLoad");
    
    //loading時，白背景顏色
    self.tableView.backgroundColor = [UIColor whiteColor];
  /*
    //loading
    self.act = [[UIActivityIndicatorView alloc]
                initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.act.center = CGPointMake(160, 240);
    self.act.hidesWhenStopped = YES;
    [self.tableView addSubview:self.act];
    [self.act startAnimating];
    [self.act release];
 */
 
}

- (void)viewDidUnload
{
    // Remove NSNotification:
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil];
    NSLog(@"s-viewDidUnload");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
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
}*/

#pragma mark - PFQueryTableViewController datasource methods
- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    // This method is called every time objects are loaded from Parse via the PFQuery
    
    [self.sections removeAllObjects];
    [self.sectionToTypeMap removeAllObjects];
    
        NSInteger section = 0;
        NSInteger rowIndex = 0;
        for (PFObject *object in self.objects)
        {
            NSString *type = [object objectForKey:@"type"];
            int star=[object[@"star"] intValue];
            //NSLog(@"star:%d",star);
            if (star==1)
            {
            NSMutableArray *objectsInSection = [self.sections objectForKey:type];
            
            if (!objectsInSection) {
                objectsInSection = [NSMutableArray array];
                // this is  the first time we see this sportType - increment the section index
                [self.sectionToTypeMap setObject:type forKey:[NSNumber numberWithInt:section++]];
            
                NSString *str1=@"s-sectionToTypeMap新增";
                NSString *str2=@"為第";
                NSString *str3=@"section";
                NSString *str = [NSString stringWithFormat:@"%@%@%@%i%@",str1,type,str2,section,str3];
                NSLog(@"%@",str);
                }
                
                [objectsInSection addObject:[NSNumber numberWithInt:rowIndex++]];
                [self.sections setObject:objectsInSection forKey:type];
                NSLog(@"%@",[NSString stringWithFormat:@"%@%@",type,@"加一物件"]);
                [self.starObjects addObject:object];
                NSLog(@"starObjectsArray加%i物件",rowIndex);

            }
        }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
    NSLog(@"s-objectsDidLoad:DONE");
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    static NSString *CellIdentifier = @"ItemCell";
    
    StarProductsCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[StarProductsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *type = [object objectForKey:@"type"];
    NSMutableArray *objectsInSection = [self.sections objectForKey:type];

    //NSLog(@"CelForRow:共有%dROW",objectsInSection.count);
    PFObject *product1= [self objectAtIndexPath:indexPath];
    //PFObject *product = self.objects[indexPath.row];
    NSLog(@"s-CelForRow:%@",indexPath);
    [cell configureProduct:product1];

    
    return cell;
}


#pragma mark - ()
- (NSString *)typeForSection:(NSInteger)section {
    return [self.sectionToTypeMap objectForKey:[NSNumber numberWithInt:section]];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *type = [self typeForSection:section];
    return type;
}
#pragma mark - (改成只去抓starObjectsArray)
- (PFObject *)objectAtIndexPath:(NSIndexPath *)indexPath {
    NSString *type = [self typeForSection:indexPath.section];
    
    NSArray *rowIndecesInSection = [self.sections objectForKey:type];
    
    NSNumber *rowIndex = [rowIndecesInSection objectAtIndex:indexPath.row];
    //NSLog(@"s-rowIndex:%d",[rowIndex integerValue]);
    PFObject *product = [self.starObjects objectAtIndex:[rowIndex intValue]];
    return product;
}


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
    NSLog(@"NumberOfRow%d",rowIndecesInSection.count);
    return rowIndecesInSection.count;
    
    // Return the number of rows in the section.
    //return [self.objects count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%fheight",ROW_HEIGHT);
    return ROW_HEIGHT;
}


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    PFObject *selectedObject = [self objectAtIndexPath:indexPath];
    [self selectProduct:selectedObject];
    //[self selectProduct:[self.objects objectAtIndex:indexPath.row]];
}

#pragma mark - NSNotification handler
- (void)selectProductWithNotification:(NSNotification *)notification
{
    NSDictionary *dict = [notification userInfo];
    NSInteger product_id = [[dict objectForKey:@"product_id"] intValue];
    NSIndexPath *path = [NSIndexPath indexPathForRow:product_id inSection:1];//不確定這數字作用
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
