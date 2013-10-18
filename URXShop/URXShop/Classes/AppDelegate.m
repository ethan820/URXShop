//
//  PFAppDelegate.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//

#import "AppDelegate.h"
#import <Turnpike/Turnpike.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSLog(@"infoDictionary: %@", infoDictionary);
    [Parse setApplicationId:@"zIFzjuA3H4AV9W6wUTUCL8wAmkdwknfqsYJ3i1DA"clientKey:@"uYF9AGQhMCbZfKJSYQUye4FQSqk7SLTE11ml540m"];
    
    // Turnpike:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"login" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello login!");
    }];
    
    [Turnpike mapRoute:@"product/:product_id" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello product_id!");
    }];
    
    [Turnpike mapRoute:@"shoppingCart" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello shoppingCart!");
    }];
    
    return YES;
}

// iOS >= 4.2
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [Turnpike resolveURL:url];
    return YES;
}

// iOS < 4.2
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    [Turnpike resolveURL:url];
    return YES;
}
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
                                                                                                                                                 
@end
