
//
//  ContactUsViewController.h
//  URXShop
//
//  Created by ethan820 on 4/5/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//
#import <Parse/Parse.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "UILabel+heightToFit.h"

@interface ContactUsViewController : PFQueryTableViewController<MFMailComposeViewControllerDelegate>

//@property (nonatomic, strong) PFObject *item;
@property (strong, nonatomic) IBOutlet UILabel *itemAboutUs;
@property (strong, nonatomic) IBOutlet UIButton *itemButton;

- (IBAction)buttonPressed;

@end
