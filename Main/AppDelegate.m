//
//  AppDelegate.m
//  ASIHttpRequest
//
//  Created by Apple on 26/10/12.
//  Copyright (c) 2012 Apple. All rights reserved.
//

#import "AppDelegate.h"
#import "TestFairy.h"
#import "ViewControllerLogin.h"

@implementation AppDelegate

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
  //  [TestFairy begin:@"037b2d753436a3995572df3dcbd4c9a7f5a3e9da"];
    
    [IQKeyBoardManager installKeyboardManager];
    
    
    
       
    
    
    //NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://54.187.180.226:8000/rest/numbers/register"]];
  
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    
    
    
    
    if (IS_IPHONE4) {
        
        NSLog(@"HERE");
        
        self.viewController = [[ViewControllerLogin alloc] initWithNibName:@"ViewControllerLogin" bundle:nil];
    }
    else
    {
        
       
         self.viewController = [[ViewControllerLogin alloc] initWithNibName:@"ViewControllerLogin" bundle:nil];
                
        
        
    }
    
    
    //self.viewController = [[ViewController alloc] initWithNibName:@"ViewController" bundle:nil];
    
    self.window.rootViewController = self.viewController;
    
    
    if (IS_OS_7_OR_LATER)
    {
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    }
    else
    {
        self.window.backgroundColor = [UIColor colorWithRed:79/255 green:199/255.0 blue:200/255.0 alpha:1];
        [UIApplication sharedApplication].statusBarHidden = YES;
    }
    
    
    
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,
//                                             (unsigned long)NULL), ^(void) {
//        
//        
//        
//        
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//        {
//            
//            
//            
//            
//            [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//            
//            
//            [[UIApplication sharedApplication] registerForRemoteNotifications];
//            
//            
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//            
//            
//        }
//        else
//        {
//            
//            //NSLog(@"Registering for push notifications...");
//            
//            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:
//             (UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert)];
//            
//            [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
//        }
//        
//        
//        
//    });

    
    
    
    [self.window makeKeyAndVisible];
    return YES;
}






- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
   // return [FBSession.activeSession handleOpenURL:url];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
