//
//  ProductViewController.h
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductViewController : UIViewController

@property (nonatomic, strong) PFObject *item;

@property (nonatomic, strong) IBOutlet PFImageView *itemImage;
@property (nonatomic, strong) IBOutlet UILabel *itemName;
@property (nonatomic, strong) IBOutlet UILabel *itemPrice;

- (void)configureProduct:(PFObject *)product;

@end
