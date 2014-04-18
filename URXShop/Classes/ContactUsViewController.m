//
//  ContactUsViewController.m
//  URXShop
//
//  Created by ethan820 on 4/5/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController
@synthesize itemAboutUs = _itemAboutUs,itemButton=_itemButton;

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        // The className to query on
		self.className = @"contactus";
        
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
    // Do any additional setup after loading the view.
    PFQuery *query = [PFQuery queryWithClassName:@"contactus"];
    PFObject *product = query.getFirstObject;
    
    [self configureProduct:product];
    
    if ([MFMailComposeViewController canSendMail])
        self.itemButton.enabled = YES;
    
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

- (void)configureProduct:(PFObject *)product {
    
    self.itemAboutUs.text= product[@"description"];
    self.itemAboutUs.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemAboutUs.textColor = [UIColor colorWithRed:50.0f/255.0f green:50.0f/255.0f blue:50.0f/255.0f alpha:1.0f];
    self.itemAboutUs.backgroundColor = [UIColor clearColor];
    [self.itemAboutUs heightToFit];
    
    self.itemButton.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
    self.itemButton.x=self.itemAboutUs.centerX-self.itemButton.width/2;
    self.itemButton.y=self.itemAboutUs.y+self.itemAboutUs.height+20.0f;
    self.itemButton.layer.cornerRadius = 7;
}

@end
