//
//  headphoneCell.h
//  URXShop
//
//  Created by ethan820 on 3/30/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface headphoneCell : PFTableViewCell

@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *weightLabel;
@property (nonatomic, strong) UILabel *hrLabel;

- (void)configureProduct:(PFObject *)product;

@end
