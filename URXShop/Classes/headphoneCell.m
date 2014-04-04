//
//  headphoneCell.m
//  URXShop
//
//  Created by ethan820 on 3/30/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "headphoneCell.h"
#import "UILabel+heightToFit.h"

#define ROW_MARGIN 6.0f
#define ROW_HEIGHT 230.0f

@implementation headphoneCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.weightLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.weightLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
        self.weightLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        self.weightLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.weightLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.weightLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.weightLabel];
        
        self.hrLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        self.hrLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:20.0f];
        self.hrLabel.textColor = [UIColor colorWithRed:100.0f/255.0f green:100.0f/255.0f blue:100.0f/255.0f alpha:1.0f];
        self.hrLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
        self.hrLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
        self.hrLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.hrLabel];
        
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
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake(x + 2.0f, y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    y += self.textLabel.frame.size.height + 2.0f;
    y += 6.0f;
    
    [self.weightLabel sizeToFit];
    self.weightLabel.frame = CGRectMake(x, y, self.weightLabel.frame.size.width, self.weightLabel.frame.size.height);
    y += self.weightLabel.frame.size.height + 2.0f + 6.0f;
    
    [self.hrLabel sizeToFit];
    self.hrLabel.frame = CGRectMake(x, y, self.hrLabel.frame.size.width, self.hrLabel.frame.size.height);
    y += self.hrLabel.frame.size.height + 2.0f + 6.0f;
    
    //y = 155.0f;
    [self.priceLabel sizeToFit];
    //CGFloat priceX = self.frame.size.width - self.priceLabel.frame.size.width - ROW_MARGIN - 10.0f;
    self.priceLabel.frame = CGRectMake(x, y, self.priceLabel.frame.size.width, self.priceLabel.frame.size.height);
    
    
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
    
    self.weightLabel.text = [NSString stringWithFormat:@"%d克", [product[@"weight"] intValue]];
    self.hrLabel.text = [NSString stringWithFormat:@"%d小時", [product[@"hr"] intValue]];
    self.priceLabel.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    
    self.textLabel.text = product[@"name"];
    //ethan 自動換行,增加行距
    [self.textLabel setNumberOfLines:0];
    self.textLabel.lineBreakMode = UILineBreakModeWordWrap;
    CGSize size = CGSizeMake(165,5000);
    CGSize labelsize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    self.textLabel.frame = CGRectMake(20 , 7, labelsize.width, labelsize.height);
    [self.textLabel sizeToFit];
    //UILabel *a = [[UILabel alloc] init];
    [self.textLabel heightToFit];
    
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    
    
}

@end

