//
//  MyManager.m
//  URXShop
//
//  Created by ethan820 on 4/28/14.
//  Copyright (c) 2014 URX Inc. All rights reserved.
//

#import "MyManager.h"

static MyManager *sharedMyManager = nil;

@implementation MyManager

@synthesize someProperty;

#pragma mark Singleton Methods
+ (id)sharedManager {
    @synchronized(self) {
        if(sharedMyManager == nil)
            sharedMyManager = [[super allocWithZone:NULL] init];
    }
    return sharedMyManager;
}
+ (id)allocWithZone:(NSZone *)zone {
    return [[self sharedManager] retain];
}
- (id)copyWithZone:(NSZone *)zone {
    return self;
}
- (id)retain {
    return self;
}
- (unsigned)retainCount {
    return UINT_MAX; //denotes an object that cannot be released
}
- (oneway void)release {
    // never release
}
- (id)autorelease {
    return self;
}
- (id)init {
    if (self = [super init]) {
        someProperty = [[NSString alloc] initWithString:@"Default Property Value"];
    }
    return self;
}
- (void)dealloc {
    // Should never be called, but just here for clarity really.
    [someProperty release];
    [super dealloc];
}

@end