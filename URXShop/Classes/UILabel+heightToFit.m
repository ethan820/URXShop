//
//  UILabel+heightToFit.m
//  shareShopping
//
//  Created by Mac on 14/1/16.
//  Copyright (c) 2014年 EZTABLE. All rights reserved.
//

#import "UILabel+heightToFit.h"


@implementation UILabel (heightToFit)

-(CGFloat)heightToFit{
    return [self heightToFitWithString:self.text];
}
-(CGFloat)heightToFitWithString:(NSString *)string
{
    if (string==nil) {
        return 0.0;
    }
    CGFloat height;
    
    NSMutableParagraphStyle *style  = [[NSMutableParagraphStyle alloc] init];
    style.lineHeightMultiple = 1.5;
    self.attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName:self.font}];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
        
        CGRect textRect = [string boundingRectWithSize:CGSizeMake(self.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSParagraphStyleAttributeName:style, NSFontAttributeName:self.font} context:nil];
        
        height = textRect.size.height;
    }else{
        CGFloat fontSize = self.font.pointSize;
        CGSize textSize = [string sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(self.width, 1000) lineBreakMode:NSLineBreakByWordWrapping];
//        NSInteger numberOfLines = textSize.height/fontSize;
        height = textSize.height*style.lineHeightMultiple;
    }
//    NSLog(@"text size %.0fX%.0f", self.width, height);

    self.height = height;
    return height;
}

@end
