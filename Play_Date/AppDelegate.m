//
//  AppDelegate.m
//  Play_Date
//
//  Created by Spiel's Macmini on 12/28/16.
//  Copyright © 2016 Spiel's Macmini. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Bolts/Bolts.h>
#import "Reachability.h"
#import "MainMenuNavigationController.h"
#import "MainProfilenavigationController.h"
#import <AirshipKit/AirshipKit.h>
#import "PushHandler.h"
#import "Flurry.h"
@interface AppDelegate ()
{
    
    NSUserDefaults * defauls;
   

}
@property(nonatomic, strong) PushHandler *pushHandler;
//@property(nonatomic,weak,nullable) id<UARegistrationDelegate> registrationDelegate; //mohit
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"])
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else
    {
        
    }
    
    if ([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"])
    {
        [[NSUserDefaults standardUserDefaults] setInteger:([[NSUserDefaults standardUserDefaults] integerForKey:@"AppLaunchCount"] + 1) forKey:@"AppLaunchCount"];
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"AppLaunchCount"];
    }
    
    
    
    
//    [Flurry setDebugLogEnabled:YES];
//    [Flurry startSession:@""];
    
    NSString * appVersionString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
    
    NSLog(@"ver123 = %@%@",appVersionString,appBuildString);
    
    NSString *verBuild = [NSString stringWithFormat:@"%@.%@",appVersionString,appBuildString];
    
    FlurrySessionBuilder *builder = [[[[[ FlurrySessionBuilder new] withLogLevel:FlurryLogLevelAll]withCrashReporting:YES]withSessionContinueSeconds:10]withAppVersion:verBuild];
    
    [Flurry startSession:@"55BWQ689QBY338PSHW7B" withSessionBuilder:builder];
    
    
    
    [UAirship push].notificationOptions = (UANotificationOptionAlert |
                                           UANotificationOptionBadge |
                                           UANotificationOptionSound);
    
//    [UAirship takeOff];
//    
//   
//    
//    [UAirship push].userPushNotificationsEnabled=YES;
    
 //  [UAirship push].registrationDelegate = self;
    
//    NSString *channelID = [UAirship push].channelID;
//    NSLog(@"channel id = %@",channelID);
//    
//     [[UAirship push] resetBadge];
//    
    
    self.pushHandler = [[PushHandler alloc] init];
    
    [UAirship push].pushNotificationDelegate = self.pushHandler;
    
  

/*    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(refreshMessageCenterBadge)
                                                 name:UAInboxMessageListUpdatedNotification object:nil];
  */
    
  //  [defauls setObject:[UAirship push].channelID forKey:@"ChannelId"];
  //  [defauls synchronize];
    
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
//        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//        [message show];
//
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"No Internet" message:@"Please make sure you have internet connectivity in order to access Play:Date." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction *action)
                                   {
                                       exit(0);
                                   }];
        
        [alertController addAction:actionOk];
        
        UIWindow *alertWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        alertWindow.rootViewController = [[UIViewController alloc] init];
        alertWindow.windowLevel = UIWindowLevelAlert + 1;
        [alertWindow makeKeyAndVisible];
        [alertWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        
        
        
        
        
    }
    else
    {
        defauls=[[NSUserDefaults alloc]init];
        
        [defauls setObject:@"no" forKey:@"notification"];
        [defauls synchronize];
        
        [[FBSDKApplicationDelegate sharedInstance] application:application
                                 didFinishLaunchingWithOptions:launchOptions];
        if ([[defauls valueForKey:@"Loginplay"] isEqualToString:@"yes"])
        {
            [defauls setObject:@"no" forKey:@"letsChat"];
            [defauls synchronize];
            MainProfilenavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainProfilenavigationController"];
            
            self.window.rootViewController=loginController;
        }
        else
        {
            
            
            MainMenuNavigationController *loginController=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"MainMenuNavigationController"];

       
             self.window.rootViewController=loginController;
        }
       
    }
    
    
   [UAirship takeOff];
    
    
    
    [UAirship push].userPushNotificationsEnabled=YES;
    
    
 //     [UAirship push].registrationDelegate = self;
    
    NSString *channelID = [UAirship push].deviceToken;
    NSLog(@"channel id = %@",channelID);
    
    [[UAirship push] resetBadge];


    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
//      [self refreshMessageCenterBadge];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [[UAirship push] resetBadge];
    
      [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        exit(0);
//    }
//}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(nonnull NSDictionary *)userInfo
{
    UIApplicationState state=[application applicationState];
    if(state==UIApplicationStateActive)
    {
         NSLog(@"Active puss Yesss");
    }
    else
    {
        NSLog(@"Active puss not");
    }
}
/*- (void)refreshMessageCenterBadge {
    
//    tabb *messageCenterTab = [[[(UITabBarController *)self.window.rootViewController tabBar] items] objectAtIndex:2];
    
//    if ([UAirship inbox].messageList.unreadCount > 0) {
//        [messageCenterTab setBadgeValue:[NSString stringWithFormat:@"%ld", (long)[UAirship inbox].messageList.unreadCount]];
//    } else {
//        [messageCenterTab setBadgeValue:nil];
//    }
    NSLog(@"Active puss not%@",[NSString stringWithFormat:@"%ld",[UAirship inbox].messageList.unreadCount]);
}
- (void)registrationSucceededForChannelID:(NSString *)channelID deviceToken:(nonnull NSString *)deviceToken {
    
    NSLog(@"CHANNELLLLLLLL IDDD= %@",channelID);
    
      [defauls setObject:channelID forKey:@"ChannelId"];
      [defauls synchronize];

    NSLog(@"CHANNELLLLLLLL IDDD11111= %@",[defauls valueForKey:@"ChannelId"]);
    
   
}*/
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    
    [[UAirship push] resetBadge];
 
}
@end
