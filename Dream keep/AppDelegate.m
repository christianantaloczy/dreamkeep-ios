//
//  AppDelegate.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <AudioToolbox/AudioServices.h>
#import "authentication.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "touchcheak.h"
#import "timeline.h"
#import "ViewController.h"
#import "authentication1.h"


@interface AppDelegate ()
{
    BOOL isFirstTimeOpen;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Override point for customization after application launch.
    [Fabric with:@[CrashlyticsKit]];
    //[[Crashlytics sharedInstance] setDebugMode:YES];
    
    [self CopyAndPaste];
    NSError *setAudioError;
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &setAudioError];
    
    if (setAudioError) { NSLog(@"error setting audio: %@", setAudioError); }
    
    UInt32 audioRouteOverride = kAudioSessionOverrideAudioRoute_Speaker;
    AudioSessionSetProperty (
                             kAudioSessionProperty_OverrideAudioRoute,
                             sizeof (audioRouteOverride),
                             &audioRouteOverride);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //update ui
    });
    
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, screenSize.height)];
    [self.window addSubview:view];
    
    
    
    
    //[self applicationWillEnterForeground:application];
    
    [NSThread sleepForTimeInterval:2.0];
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    BOOL ab=[dif valueForKey:@"abc"];
    if ( ab != YES)
    {
        ViewController *first=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ViewController"];
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:first];
        navController.navigationBarHidden=true;
        self.window.rootViewController=navController;
        isFirstTimeOpen=false;
        
    }
    else
    {
        timeline *first=[[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"timeline"];
        UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:first];
        navController.navigationBarHidden=true;
        self.window.rootViewController=navController;
        isFirstTimeOpen=true;
    }
    
    
    
    
        return YES;
}
-(void)CopyAndPaste
{
  NSArray *arrpath=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *str=[arrpath objectAtIndex:0];
    self.StrdbPAth=[str stringByAppendingPathComponent:@"dreamkeep.db"];
    NSLog(@"%@",self.StrdbPAth);
    if(![[NSFileManager defaultManager]fileExistsAtPath:self.StrdbPAth])
    {
        NSString *localdb=[[NSString alloc]initWithString:[[NSBundle mainBundle]pathForResource:@"dreamkeep" ofType:@"db"]];
        [[NSFileManager defaultManager]copyItemAtPath:localdb toPath:self.StrdbPAth error:nil];
    }
    
}
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    
   
    [self passwordcheakinbackground];
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    if(isFirstTimeOpen)
    {
        isFirstTimeOpen=false;
        [self passwordcheakinbackground];
        
    }
    
    
    
    
    
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark -passcode cheakmethod
-(void)passwordcheakinbackground
{
    NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
    
    
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    dispatch_async(dispatch_get_main_queue(), ^{
        //update ui
    });
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // Authenticate User
        
        //NSError *error = nil;
        //        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        
        BOOL ab=[dif valueForKey:@"switch"];
        if ( ab != YES)
        {
            NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
            
            if([pass valueForKey:@"pass"]==nil)
            {
                
                
            }
            else
            {
                [dif setBool:YES forKey:@"cross1"];
                UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                         bundle: nil];
                
                authentication1 *controller = (authentication1*)[mainStoryboard                                                       instantiateViewControllerWithIdentifier: @"authentication1"];
                
                _topViewController1 = [self topViewController];
                
                if (![_topViewController1 isKindOfClass:[authentication1 class]]) {
                    
                    
                    if ([_topViewController1 isKindOfClass:[UIViewController class]]) {
                        _topViewController1.view.hidden=true;
                    }
                    
                    
                    [_topViewController1 presentViewController:controller animated:false completion:nil];
                }
                
                
            }
        }
        else
        {
            [dif setBool:YES forKey:@"mangetouch"];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            
            authentication1 *controller = (authentication1*)[mainStoryboard                                                       instantiateViewControllerWithIdentifier: @"authentication1"];
            
            _topViewController1 = [self topViewController];
            if (![_topViewController1 isKindOfClass:[authentication1 class]]) {
                
                if ([_topViewController1 isKindOfClass:[UIViewController class]]) {
                    _topViewController1.view.hidden=true;
                }
                
                
                [_topViewController1 presentViewController:controller animated:false completion:nil];
            }
        }
        
        //        }
    }
    else
    {
        if([pass valueForKey:@"pass"]==nil)
        {
            
        }
        else
        {
            [dif setBool:YES forKey:@"cross1"];
            UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                                     bundle: nil];
            authentication1 *controller = (authentication1*)[mainStoryboard                                                       instantiateViewControllerWithIdentifier: @"authentication1"];
            
            _topViewController1 = [self topViewController];
            if (![_topViewController1 isKindOfClass:[authentication1 class]]) {
                
                
                if ([_topViewController1 isKindOfClass:[UIViewController class]]) {
                    _topViewController1.view.hidden=true;
                }
                
                
                
                [_topViewController1 presentViewController:controller animated:false completion:nil];
            }
        }
    }
    
    

}
@end
