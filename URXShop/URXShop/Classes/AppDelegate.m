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
    //NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [Parse setApplicationId:@"zIFzjuA3H4AV9W6wUTUCL8wAmkdwknfqsYJ3i1DA"clientKey:@"uYF9AGQhMCbZfKJSYQUye4FQSqk7SLTE11ml540m"];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    
    // Turnpike:
    [Turnpike mapRoute:@"hello" ToDestination:^(TPRouteRequest *request) {
        NSLog(@"Hello World!");
    }];
    
    [Turnpike mapRoute:@"login" ToDestination:^(TPRouteRequest *request) {
        [tabBarController setSelectedIndex:0];
    }];
    
    [Turnpike mapRoute:@"product/:product_id" ToDestination:^(TPRouteRequest *request) {
        NSInteger product_id = [[request.routeParameters valueForKey:@"product_id"] intValue];

        if (product_id) {
            [tabBarController setSelectedIndex:0];
            
            // Retrieve the ProductsViewController:
            UINavigationController *navigationController = [[tabBarController viewControllers] objectAtIndex:0];
            ProductsViewController *productsViewController = [[navigationController viewControllers] objectAtIndex:0];
            
            // Push the ProductViewController:
            UIStoryboard *mystoryboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:nil];
            ProductViewController *productViewController = [mystoryboard instantiateViewControllerWithIdentifier:@"ProductViewController"];
            
            productViewController.item = [productsViewController.objects objectAtIndex:product_id];
            [navigationController pushViewController:productViewController animated:NO];
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
