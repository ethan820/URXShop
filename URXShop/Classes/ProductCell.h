//
//  ProductCell.h
//  URXShop
//
//  Created by David Lee on 10/18/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductCell : PFTableViewCell

@property (nonatomic, strong) UILabel *orderButton;
@property (nonatomic, strong) UILabel *priceLabel;

- (void)configureProduct:(PFObject *)product;

@end
