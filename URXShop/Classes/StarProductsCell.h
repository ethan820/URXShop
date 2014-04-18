//
//  StarProductsCell.h
//  URXShop
//
//  Created by ethan820 on 4/9/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface StarProductsCell : PFTableViewCell

@property (nonatomic, strong) UILabel *priceLabel;

- (void)configureProduct:(PFObject *)product;

@end