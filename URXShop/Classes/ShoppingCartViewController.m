//
//  ShoppingCartViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "headphoneCell.h"

#define ROW_HEIGHT 230.0f
#define SIZE_BUTTON_TAG_OFFSET 1000

@interface ShoppingCartViewController ()

@end

@implementation ShoppingCartViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // The className to query on
		self.className = @"headphones";
        
		// Whether the built-in pull-to-refresh is enabled
		self.pullToRefreshEnabled = YES;
        
		// Whether the built-in pagination is enabled
		self.paginationEnabled = YES;
        
		// The number of objects to show per page
		self.objectsPerPage = 10;
        
        // Set the tabBarItem icon:
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"推薦商品" image:[UIImage imageNamed:@"152-rolodex.png"] tag:1];
        
        self.tabBarItem = tabBarItem;
        
        
        }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.tableView registerClass:[headphoneCell class] forCellReuseIdentifier:@"ItemCell"];
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
    headphoneCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[headphoneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
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
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.objects count];
}

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
    NSIndexPath *path = [NSIndexPath indexPathForRow:product_id inSection:1];
    [self selectProduct:[self.objects objectAtIndex:path.row]];
}


#pragma mark - Load ProductViewController:
- (void)selectProduct:(PFObject *)product
{
    UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
    headphoneViewController *headphoneViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"headphoneViewController"];
    headphoneViewController.item = product;
    [self.navigationController pushViewController:headphoneViewController animated:YES];
}


@end
