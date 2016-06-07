//
//  touchcheak.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 31/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//
#import "touchcheak.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "timeline.h"
#import "authentication.h"
@interface touchcheak ()<UIAlertViewDelegate>
@end
@implementation touchcheak

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    [dif removeObjectForKey:@"active"];
    dispatch_async(dispatch_get_main_queue(), ^{
        //update ui
    });
    
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // Authenticate User
        
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            context.localizedFallbackTitle = @"Passcode";
            [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                    localizedReason:@"Scan your fingerprint to unlock"
                              reply:^(BOOL success, NSError *error) {
dispatch_async(dispatch_get_main_queue(), ^{
                                      if (error) {
                                        
                                          NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
                                          [dif setBool:YES forKey:@"authpass"];
                                          
                                          authentication *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"authentication"];
                                          [self.navigationController pushViewController:rec animated:NO];
                                          return;
                                      }
                                      
                                      if (success)
                                      {
                                          NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
                                          BOOL ab=[dif valueForKey:@"bagbool1"];
                                          if ( ab != YES)
                                          {
                                              timeline *tim=[self.storyboard instantiateViewControllerWithIdentifier:@"timeline"];
                                              [self.navigationController pushViewController:tim animated:NO];
                                              [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
                                          }
                                          else
                                          {
                                              [dif removeObjectForKey:@"bagbool1"];
                                              [self dismissViewControllerAnimated:YES completion:nil];
                                          }
                                          
                                          
                                      } else {
                                          UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                          message:@"You are not the device owner."
                                                                                         delegate:self
                                                                                cancelButtonTitle:@"Ok"
                                                                                otherButtonTitles:nil];
                                          [alert show];
                                      }
                                  });
                              }];
        }    } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Your device cannot authenticate using TouchID."
                                                           delegate:self
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
            [alert show];
        }
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)viewWillAppear:(BOOL)animated
{
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    BOOL ab=[dif valueForKey:@"scan"];
    if ( ab != YES)
    {
        
        
    }
    else
    {
        [self viewDidLoad];
        [dif removeObjectForKey:@"scan"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex==0)
//    {
//        exit(0);
//    }
//}
@end
