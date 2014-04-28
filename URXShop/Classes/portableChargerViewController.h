//
//  portableChargerViewController.h
//  URXShop
//
//  Created by ethan820 on 4/1/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"


@interface portableChargerViewController : GAITrackedViewController

@property (nonatomic, strong) PFObject *item;
@property (nonatomic, strong) IBOutlet PFImageView *itemImage;
@property (nonatomic, strong) IBOutlet UILabel *itemName;
@property (nonatomic, strong) IBOutlet UILabel *itemData;
@property (strong, nonatomic) IBOutlet UIButton *itemButton;



- (void)configureProduct:(PFObject *)product;

@end

