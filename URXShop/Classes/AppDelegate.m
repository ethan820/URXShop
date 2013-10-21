//
//  PFAppDelegate.m
//  URXShop
//
//  Created by David Lee on 10/17/13.
//

#import "AppDelegate.h"
#import <Turnpike/Turnpike.h>
#import "ProductsViewController.h"
#import "ProductViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"YourParseApplicationID"clientKey:@"YourParseClientAPIKey"];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    
    
    // Turnpike Routing:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"login" ToDestination:^(TPRouteRequest *request) {
        [tabBarController setSelectedIndex:0];
    }];
    
    [Turnpike mapRoute:@"product/:product_id" ToDestination:^(TPRouteRequest *request) {
        NSString *product_id = [request.routeParameters valueForKey:@"product_id"];
        if (product_id) {
            [tabBarController setSelectedIndex:0];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil userInfo:[NSDictionary dictionaryWithObject:product_id forKey:@"product_id"]];
        }
    }];
    
    [Turnpike mapRoute:@"shopping_cart" ToDestination:^(TPRouteRequest *request) {
        [tabBarController setSelectedIndex:1];
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
