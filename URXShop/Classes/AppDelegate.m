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
    [Parse setApplicationId:@"9NSZcVNZ0uIxhcFW87RBCdRs4ttoioUW3KNy5IkB"clientKey:@"UppGoDOy7VM916lcRiyC1GUfol2vD3hb5tqyu0kp"];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    self.window.tintColor = [UIColor colorWithRed:140.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    
    /******************** Begin URX Turnpike Routing: ********************/
    
    // Hello word:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    // Product detail page
    [Turnpike mapRoute:@"product/:product_id" ToDestination:^(TPRouteRequest *request) {
        NSString *product_id = [request.routeParameters valueForKey:@"product_id"];
        if (product_id) {
            [tabBarController setSelectedIndex:0];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"com.urx.shop.productsViewController.urxLinkToProduct" object:nil userInfo:[NSDictionary dictionaryWithObject:product_id forKey:@"product_id"]];
        }
    }];
    
    // Catalog or Shopping cart tabs:
    [Turnpike mapRoute:@"tab/:tab_name" ToDestination:^(TPRouteRequest *request) {
        int tabIndexToSet = 0;
        if ([[request.routeParameters valueForKey:@"tab_name"] isEqualToString:@"catalog"]) {
            tabIndexToSet = 0;
        } else if ([[request.routeParameters valueForKey:@"tab_name"] isEqualToString:@"shopping_cart"]) {
            tabIndexToSet = 1;
        } else {
            // open some other tab, etc.
            tabIndexToSet = 0;
        }
        
        [tabBarController setSelectedIndex:tabIndexToSet];
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
