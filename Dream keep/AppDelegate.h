//
//  AppDelegate.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (retain,nonatomic)NSString *StrdbPAth;
@property (nonatomic, strong) UINavigationController *navController;

@property (nonatomic, strong) UIViewController *topViewController1;
-(void)CopyAndPaste;


@end

