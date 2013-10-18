//
//  PFAppDelegate.m
//  Stripe
//
//  Created by Andrew Wang on 2/25/13.
//

#import "AppDelegate.h"
#import <Turnpike/Turnpike.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [Parse setApplicationId:infoDictionary[@"PARSE_APPLICATION_ID"] clientKey:infoDictionary[@"PARSE_CLIENT_KEY"]];
    
    // Turnpike:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"login" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"product/:product_id" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"cart" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
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
