//
//  ProductViewController.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ProductViewController.h"

@interface ProductViewController ()

@end

@implementation ProductViewController

@synthesize item = _item, itemImage = _itemImage, itemName = _itemName, itemPrice = _itemPrice;

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

    NSString *stringC = [NSString stringWithFormat:@"\n%@\n%@\n%@",@"headphone",@"portableCharger",@"inProductViewController"];
    NSLog(@"%@",stringC);
    
    self.itemImage.file = (PFFile *)product[@"image"];
    self.itemImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.itemImage loadInBackground];
    
    self.itemPrice.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    
    self.itemName.text = product[@"name"];
    self.itemName.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.itemName.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.itemName.backgroundColor = [UIColor clearColor];
}

@end
