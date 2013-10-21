//
//  ProductsViewController.h
//  URXShop
//
//  Created by David Lee on 10/17/13.
//  Copyright (c) 2013 URX Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductViewController.h"

@interface ProductsViewController : PFQueryTableViewController

-(void)presentProductViewController:(ProductViewController *)viewController withProduct:(PFObject *)product;

@end