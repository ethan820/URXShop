//
//  headphoneViewController.m
//  URXShop
//
//  Created by ethan820 on 4/1/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "headphoneViewController.h"
#import "UILabel+heightToFit.h"

@interface headphoneViewController ()

@end

@implementation headphoneViewController

@synthesize item = _item, itemImage = _itemImage, itemName = _itemName, itemPrice = _itemPrice;

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configureProduct:self.item];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Public
- (void)configureProduct:(PFObject *)product {
    
    
    self.itemImage.file = (PFFile *)product[@"image"];
    self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.itemImage loadInBackground];
    self.itemImage.x=10;
    self.itemImage.y=10;
    
    CGFloat x=10+self.itemImage.width-20;
    CGFloat y=10+self.itemImage.height+15;
    
    self.itemPrice.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    self.itemPrice.x = x;
    self.itemPrice.y = y;
    
    self.itemName.text = product[@"name2"];
    [self.itemName setNumberOfLines:0];
    self.itemName.lineBreakMode = UILineBreakModeWordWrap;
    [self.itemName heightToFit];
    self.itemName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemName.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemName.backgroundColor = [UIColor clearColor];

    self.itemWeight.text = [NSString stringWithFormat:@"重量：%d克", [product[@"weight"] intValue]];
    self.itemWeight.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemWeight.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemWeight.backgroundColor = [UIColor clearColor];
    
    self.itemHr.text = [NSString stringWithFormat:@"可用時間：%d小時", [product[@"hr"] intValue]];
    self.itemHr.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemHr.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemHr.backgroundColor = [UIColor clearColor];
}

@end
