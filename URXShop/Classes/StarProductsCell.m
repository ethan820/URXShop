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
#define ROW_HEIGHT 220.0f

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
        
        NSLog(@"%@:priceLabelAdd",NSStringFromSelector(_cmd));
        self.priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
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
    //self.backgroundView.frame = CGRectMake(x, y, self.frame.size.width - ROW_MARGIN, 167.0f);
    
    x += 10.0f;
    self.imageView.frame = CGRectMake(x, y + 1.0f, 110.0f, 200.0f);
    
    x += self.imageView.size.width+4.0f;
    y -= 3.0f;
    //self.textLabel.frame = CGRectMake(x , y, self.textLabel.size.width, self.textLabel.size.height);
    self.textLabel.frame = CGRectMake(x , y, 185, 500);
    [self.textLabel heightToFit];
    
    y += self.textLabel.frame.size.height + 8.0f;
    self.priceLabel.frame = CGRectMake(x, y, 185, 20);
    [self.priceLabel sizeToFit];
    self.priceLabel.backgroundColor=[UIColor clearColor];
    
    
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

#pragma mark - UITableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
}


#pragma mark - Public
- (void)configureProduct:(PFObject *)product {
   /*self.imageView.file = (PFFile *)product[@"image"];
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
    self.imageView.backgroundColor =[UIColor clearColor];
    NSLog(@"image:%@",NSStringFromSelector(_cmd));
    
    self.priceLabel.text = [NSString stringWithFormat:@"$ %d", [product[@"price"] intValue]];
    self.priceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:21.0f];
    self.priceLabel.textColor = [UIColor colorWithRed:14.0f/255.0f green:190.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
    self.priceLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.priceLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.priceLabel.backgroundColor = [UIColor clearColor];
    
    [self longString:product];
    //ethan 自動換行,增加行距
    [self.textLabel setNumberOfLines:0];
    self.textLabel.lineBreakMode=UILineBreakModeCharacterWrap;
    self.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:19.0f];
    self.textLabel.textColor = [UIColor colorWithRed:82.0f/255.0f green:87.0f/255.0f blue:90.0f/255.0f alpha:1.0f];
    self.textLabel.shadowColor = [UIColor colorWithWhite:1.0f alpha:0.7f];
    self.textLabel.shadowOffset = CGSizeMake(0.0f, 0.5f);
    self.textLabel.backgroundColor = [UIColor clearColor];
    
    NSLog(@"textLabel:%@",NSStringFromSelector(_cmd));
    
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



