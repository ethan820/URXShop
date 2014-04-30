//
//  ContactUsViewController.m
//  URXShop
//
//  Created by ethan820 on 4/5/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#define ROW_HEIGHT 455.0f

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController
@synthesize itemAboutUs = _itemAboutUs,itemButton=_itemButton;

- (void) dealloc
{
    [super dealloc];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // The className to query on
		self.parseClassName = @"contactus";
        
		// Whether the built-in pull-to-refresh is enabled
		self.pullToRefreshEnabled = YES;
        
		// Whether the built-in pagination is enabled
		self.paginationEnabled = YES;
        
		// The number of objects to show per page
		self.objectsPerPage = 1;
        
        // Set the tabBarItem icon:
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"關於我們" image:[UIImage imageNamed:@"123-id-card.png"] tag:2];
        
        self.tabBarItem = tabBarItem;
    }
    return self;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.tableView registerClass:[PFTableViewCell class] forCellReuseIdentifier:@"Cell"];
 
    // Add observer for NSNotification:
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectProductWithNotification:) name:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil];
    NSLog(@"c-viewDidLoad");

    if ([MFMailComposeViewController canSendMail])
        self.itemButton.enabled = YES;
    
    PFQuery *query = [PFQuery queryWithClassName:@"contactus"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded. The first 100 objects are available in objects
            PFObject *product = query.getFirstObject;
            [self configureProduct:product];
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
    
}

- (void)configureProduct:(PFObject *)product {
    
    self.itemAboutUs.text= product[@"description"];
    self.itemAboutUs.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemAboutUs.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    self.itemAboutUs.backgroundColor = [UIColor clearColor];
    [self.itemAboutUs heightToFit];
    
    self.itemButton.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
    self.itemButton.x=self.itemAboutUs.centerX-self.itemButton.width/2;
    self.itemButton.y=self.itemAboutUs.y+self.itemAboutUs.height+23.0f;
    self.itemButton.layer.cornerRadius = 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
                        object:(PFObject *)object
{
    static NSString *cellIdentifier = @"Cell";
    
    PFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[PFTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:cellIdentifier];
    }
    NSLog(@"c-CelForRow:%@",indexPath);
    // Do any additional setup after loading the view.
    
    
    return cell;
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
    [query orderByAscending:@"createdAt"];
    return query;
}*/

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    int i=[self.objects count];
    NSLog(@"c-numberOfRow:%d", i);
    return [self.objects count];
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%fheight",ROW_HEIGHT);
    return ROW_HEIGHT;
}

- (IBAction)buttonPressed {
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailController= [[MFMailComposeViewController alloc] init];
        mailController.mailComposeDelegate = self;
        
        NSMutableArray *myArray = [[NSMutableArray alloc] init];
        [myArray addObject:[NSString stringWithFormat:@"%@", @"ethan820@gmail.com"]];
        [myArray addObject:[NSString stringWithFormat:@"%@", @"atwood.liu@gmail.com"]];
        [mailController setToRecipients:myArray];
        
        [mailController setSubject:@"意見反應"];
        NSString *stringA = @"姓名：\n聯絡電話：\n問題描述：\n\n您想購買的好商品推薦\n(1)商品名稱：\n(2)參考連結：\n(3)照片：\n";
        [mailController setMessageBody:stringA isHTML:NO];
        [self presentModalViewController:mailController animated:YES];
        [mailController release];
    }
    
    else
    {
        NSLog(@"Device is unable to send email in its current state.");
    }
}

-   (void)mailComposeController:(MFMailComposeViewController*)mailController didFinishWithResult:(MFMailComposeResult)result  error:(NSError*)error {
    [self becomeFirstResponder];
    [self dismissModalViewControllerAnimated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"mailtous"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
        
        [self buttonPressed];
	}
}

@end

