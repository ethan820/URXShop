//
//  headphoneViewController.h
//  URXShop
//
//  Created by ethan820 on 4/1/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface headphoneViewController : UIViewController

@property (nonatomic, strong) PFObject *item;

@property (nonatomic, strong) IBOutlet PFImageView *itemImage;
@property (nonatomic, strong) IBOutlet UILabel *itemName;
@property (nonatomic, strong) IBOutlet UILabel *itemPrice;
@property (nonatomic, strong) IBOutlet UILabel *itemWeight;
@property (nonatomic, strong) IBOutlet UILabel *itemHr;


- (void)configureProduct:(PFObject *)product;

@end
