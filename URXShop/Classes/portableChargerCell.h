//
//  portableChargerCell.h
//  URXShop
//
//  Created by ethan820 on 3/30/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <Parse/Parse.h>

@interface portableChargerCell : PFTableViewCell

@property (nonatomic, strong) UILabel *priceLabel;
//@property (nonatomic, strong) UILabel *weightLabel;
//@property (nonatomic, strong) UILabel *capacityLabel;
//@property (nonatomic, strong) UILabel *ampereLabel;

- (void)configureProduct:(PFObject *)product;

@end
