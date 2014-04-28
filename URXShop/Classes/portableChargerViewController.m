//
//  portableChargerViewController.m
//  URXShop
//
//  Created by ethan820 on 4/1/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "portableChargerViewController.h"
#import "UILabel+heightToFit.h"
#import "BrowserViewController.h"
#import "TSMiniWebBrowser.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface portableChargerViewController ()

@end

@implementation portableChargerViewController
@synthesize item = _item, itemImage = _itemImage, itemName = _itemName, itemData = _itemData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.screenName = @"allprductsScreen";
	// Do any additional setup after loading the view.
    
    [self configureProduct:self.item];
    [self tapButton];
    //[self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tapButton
{
    [self.itemButton addTarget:self action:@selector(openBrowser:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) openBrowser:(id)sender {
    
    PFObject *product = self.item;
    NSString *urlString = product[@"link"];
    
    NSURL *url = [NSURL URLWithString:urlString];
    //[[UIApplication sharedApplication] openURL:url];
    
    TSMiniWebBrowser *webBrowser = [[TSMiniWebBrowser alloc] initWithUrl:url];
    [self.navigationController pushViewController:webBrowser animated:YES];
    [webBrowser release];
    
    /*BrowserViewController *bvc = [[BrowserViewController alloc] initWithUrls:url];
    [self.navigationController pushViewController:bvc animated:YES];
    [bvc release];*/
}


#pragma mark - Public
- (void)configureProduct:(PFObject *)product {
    
    //self.itemImage.file = (PFFile *)product[@"image"];
    //self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
    //[self.itemImage loadInBackground];
    //self.itemImage.backgroundColor = [UIColor whiteColor];
    //self.itemImage.frame = CGRectMake(self.itemImage.x, self.itemImage.y, self.itemImage.width, self.itemImage.height);
    //self.itemPrice.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    
    NSString *url=[self imageURLString:product];
    NSURL* nsURL = [NSURL URLWithString:url];
    NSLog(@"%@",url);
    [self.itemImage setImageWithURL:nsURL placeholderImage:[UIImage imageNamed:@""]options:SDWebImageRefreshCached];
    self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.itemImage loadInBackground];
    self.itemImage.backgroundColor = [UIColor whiteColor];
    
    self.itemName.text= product[@"longname"];
    self.itemName.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:19.0f];
    self.itemName.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemName.backgroundColor = [UIColor clearColor];
    [self.itemName heightToFit];
    
    int x=self.itemName.x;
    int y=self.itemName.y + self.itemName.height+3.0f;
    [self longString:product];
    self.itemData.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemData.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemData.backgroundColor = [UIColor clearColor];
    [self.itemData heightToFit];
    self.itemData.x=x;
    self.itemData.y=y;
    
    self.itemButton.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:18.0f];
    self.itemButton.x=self.itemImage.x+self.itemImage.width-self.itemButton.width-18.0f;
    self.itemButton.y=480-84;
    self.itemButton.layer.cornerRadius = 4;
}

-(NSString *) imageURLString:(PFObject *)product
{
    NSString *stringA = product[@"imageName"];
    NSString *stringB = @"http://res.cloudinary.com/dqyggbxm0/image/upload/w_320,h_200,c_fit,r_5/";
    NSString *stringC = @".jpg";
    
    NSString *stringAll = [NSString stringWithFormat:@"%@%@%@",stringB,stringA,stringC];
    
    return stringAll;
}

-(void) longString:(PFObject *)product
{
    //NSString *stringA = [NSString stringWithFormat:@"%@",product[@"longname"] ];
    
    int a = [product[@"price"]intValue];
    NSString *stringG;
    if (a==0)
    { stringG =@"";
    }
    else
    {
        stringG = [NSString stringWithFormat:@"價格：$%d",[product[@"price"] intValue]];
    }
    
    a = [product[@"weight"]intValue];
    NSString *stringD;
    if (a==0)
    { stringD =@"";
    }
    else
    {
        stringD = [NSString stringWithFormat:@"\n重量：%d克",[product[@"weight"] intValue]];
    }
    
    a = [product[@"hr"]intValue];
    NSString *stringC;
    if (a==0)
    { stringC =@"";
    }
    else
    {
      stringC = [NSString stringWithFormat:@"\n可用時間：%d小時",[product[@"hr"] intValue]];
    }
    
    a = [product[@"capacity"]intValue];
    NSString *stringB;
    if (a==0)
    { stringB =@"";
    }
    else
    {
        stringB = [NSString stringWithFormat:@"\n電池容量：%dmAh",[product[@"capacity"] intValue]];
    }
    
    a = [product[@"ampere"]intValue];
    NSString *stringE;
    if (a==0)
    { stringE =@"";
    }
    else
    {
        stringE = [NSString stringWithFormat:@"\n輸出電流：%d安培(A)",[product[@"ampere"] intValue]];
    }
    
    a = [product[@"power"]intValue];
    NSString *stringF;
    if (a==0)
    { stringF =@"";
    }
    else
    {
        stringF = [NSString stringWithFormat:@"\n輸出功率：%d瓦(W)",[product[@"power"] intValue]];
    }
    
    NSString *stringAll = [NSString stringWithFormat:@"%@%@%@%@%@%@",stringG,stringD,stringC,stringB,stringE,stringF];
    NSLog(@"%@",stringAll);
    
    self.itemData.text=stringAll;
}


/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"buy"])
	{
		UINavigationController *navigationController =
        segue.destinationViewController;
        
        PFObject *product = self.item;
        NSString *urlString = product[@"link"];
        
		NSURL *url = [NSURL URLWithString:urlString];
        [[UIApplication sharedApplication] openURL:url];
	}
}*/


@end

