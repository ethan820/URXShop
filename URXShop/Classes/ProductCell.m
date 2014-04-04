//
//  ProductCell.m
//  URXShop
//
//  Created by David Lee on 10/18/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import "ProductCell.h"

#define ROW_MARGIN 6.0f
#define ROW_HEIGHT 230.0f

@implementation ProductCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
        self.priceLabel.textColor = [UIColor colorWithRed:14.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        self.priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.priceLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.priceLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.priceLabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)layoutSubviews {
    CGFloat x = ROW_MARGIN;
    CGFloat y = ROW_MARGIN;
    self.backgroundView.frame = CGRectMake(x, y, self.frame.size.width - ROW_MARGIN*2.0f, 167.0f);
    x += 10.0f;
    
    self.imageView.frame = CGRectMake(x, y + 1.0f, 120.0f, 165.0f);
    x += 120.0f + 5.0f;
    y += 10.0f;
    
    [self.priceLabel sizeToFit];
    CGFloat priceX = self.frame.size.width - self.priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
    self.priceLabel.frame = CGRectMake(priceX, ROW_MARGIN + 10.0f, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);
    
    y = 55.0f;
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake(x + 2.0f, y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    y += self.textLabel.frame.size.height + 2.0f;
    y += 6.0f;
}

#pragma mark - UITableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
}


#pragma mark - Public

- (void)configureProduct:(PFObject *)product {
    self.imageView.file = (PFFile *)product[@"image"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView loadInBackground];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    
    self.textLabel.text = product[@"name"];
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.textLabel.backgroundColor = [UIColor clearColor];
}

@end
