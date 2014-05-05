//
//  ShoppingCartViewController.h
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "portableChargerViewController.h"

@interface ShoppingCartViewController : PFQueryTableViewController 

@property (nonatomic, strong) NSMutableDictionary *sections;
@property (nonatomic, strong) NSMutableDictionary *sectionToTypeMap;
@property (nonatomic, strong) NSMutableArray *starObjects;
//@property (nonatomic, strong) UIActivityIndicatorView *act;

@end
