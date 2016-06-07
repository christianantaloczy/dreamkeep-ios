//
//  ViewController.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "ViewController.h"
#import "permisson mic.h"
#import "record sound.h"
#import "timeline.h"
#import "touchcheak.h"
#import "authentication.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view, typically from a nib.
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
  [dif removeObjectForKey:@"active"];
    TimeOfActiveUser = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(actionTimer) userInfo:nil repeats:NO];
    //NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
    }

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}




-(void)actionTimer
{

        permisson_mic *per=[self.storyboard instantiateViewControllerWithIdentifier:@"permisson_mic"];
        [self.navigationController pushViewController:per animated:YES];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

