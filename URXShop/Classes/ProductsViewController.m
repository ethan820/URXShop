//
//  ProductsViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ProductsViewController.h"
#import "headphoneCell.h"
#import "portableChargerCell.h"

#define ROW_HEIGHT 230.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface ProductsViewController ()

@end

@implementation ProductsViewController

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
		self.objectsPerPage = 30;
        
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
            
            PFObject *product = self.objects[indexPath.row];
            [cell configureProduct:product];
            
            return cell;

}

    
#pragma mark - Table view data source
    
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
    {
        // Return the number of sections.
        return 1;
        //return [heroicaArray count];
    }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
        return [self.objects count];

}

//設定分類開頭標題
/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
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
}
*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ROW_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self selectProduct:[self.objects objectAtIndex:indexPath.row]];
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
    ProductViewController *productViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
    productViewController.item = product;
    [self.navigationController pushViewController:productViewController animated:YES];
}


@end
