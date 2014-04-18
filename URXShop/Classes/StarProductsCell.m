//
//  StarProductsCell.m
//  URXShop
//
//  Created by ethan820 on 4/9/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "StarProductsCell.h"
#import "UILabel+heightToFit.h"
#import "BrowserViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation StarProductsCell

#define ROW_MARGIN 6.0f
#define ROW_HEIGHT 230.0f

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
    self.backgroundView.frame = CGRectMake(x, y, self.frame.size.width - ROW_MARGIN, 167.0f);
    x += 10.0f;

    self.imageView.frame = CGRectMake(x, y + 1.0f, 110.0f, 150.0f);
    x += 110.0f + 5.0f;
    y += 0.0f;
    
    [self.textLabel sizeToFit];
    self.textLabel.frame = CGRectMake(x + 2.0f, y, self.textLabel.frame.size.width, self.textLabel.frame.size.height);
    y += self.textLabel.frame.size.height + 2.0f;
    y += 7.0f;
    
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
   /*
    self.imageView.file = (PFFile *)product[@"image"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView loadInBackground];*/

    //CLCloudinary *cloudinary = [[CLCloudinary alloc] initWithUrl: @"cloudinary://921249823461277:f7p0wRv6gjpnklPeYWD7xPzZQII@dqyggbxm0"];
    //NSString *url = [cloudinary url:@"sample.jpg"];
    
    //NSString *url=@"http://res.cloudinary.com/dqyggbxm0/image/upload/fit_110x150,w_110,h_150/sample.jpg";
    NSString *url=[self imageURLString:product];
    NSURL* nsURL = [NSURL URLWithString:url];
    [self.imageView setImageWithURL:nsURL placeholderImage:[UIImage imageNamed:@""]options:SDWebImageRefreshCached];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView loadInBackground];
    
    self.priceLabel.text = [NSString stringWithFormat:@"$%d", [product[@"price"] intValue]];
    
    [self longString:product];
    //ethan 自動換行,增加行距
    [self.textLabel setNumberOfLines:0];
    CGSize size = CGSizeMake(185,5000);
    CGSize labelsize = [self.textLabel.text sizeWithFont:self.textLabel.font constrainedToSize:size lineBreakMode:UILineBreakModeTailTruncation];
    self.textLabel.frame = CGRectMake(20 , 7, labelsize.width, labelsize.height);
    [self.textLabel sizeToFit];
    self.textLabel.lineBreakMode = UILineBreakModeTailTruncation;
    
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.textLabel.backgroundColor = [UIColor clearColor];
    [self.textLabel heightToFit];
    
}

-(NSString *) imageURLString:(PFObject *)product
{
    NSString *stringA = product[@"imageName"];
    NSString *stringB = @"http://res.cloudinary.com/dqyggbxm0/image/upload/w_110,h_150,c_fit,r_5/";
    NSString *stringC = @".jpg";
    
    NSString *stringAll = [NSString stringWithFormat:@"%@%@%@",stringB,stringA,stringC];
    
    return stringAll;
}

-(void) longString:(PFObject *)product
{
    NSString *stringA = product[@"name"];
    NSString *stringB = product[@"description"];
    
    NSString *stringAll = [NSString stringWithFormat:@"%@\n%@",stringA,stringB];
    //NSLog(@"%@",stringAll);
    self.textLabel.text=stringAll;
}


@end



