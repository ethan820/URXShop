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
#import "GAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"9NSZcVNZ0uIxhcFW87RBCdRs4ttoioUW3KNy5IkB"clientKey:@"UppGoDOy7VM916lcRiyC1GUfol2vD3hb5tqyu0kp"];
    
    UITabBarController *tabBarController = (UITabBarController *)self.window.rootViewController;
    self.window.tintColor = [UIColor colorWithRed:150.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowColor = [UIColor whiteColor];
    //shadow.shadowOffset = CGSizeMake(0, 1);
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor whiteColor], NSForegroundColorAttributeName,
                                                           shadow, NSShadowAttributeName,
                                                           [UIFont fontWithName:@"HelveticaNeue-Bold" size:19.0], NSFontAttributeName, nil]];
    
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-44222176-3"];
    
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
    
        //rest of your code!!!!!!!
        NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    EDIT:
        if( [[NSUserDefaults standardUserDefaults] boolForKey:@"isExceptionOccured"])
        {
            //call sever code here
            [[NSUserDefaults standardUserDefaults] setBool:FALSE forKey:@"isExceptionOccured"];
        }
    
    
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

//rest of your code!!!!!!!!!!
void uncaughtExceptionHandler(NSException *exception)
{
    NSLog(@"Exception Got %@",[exception description]);
    //do what ever you what here
    //can save any `bool` so that as aaplication  run on immediate next launching of crash
    //could intimate any thing
EDIT:
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isExceptionOccured"];
    
}

@end
