//
//  MyManager.h
//  URXShop
//
//  Created by ethan820 on 4/28/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import <foundation/Foundation.h>

@interface MyManager : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end