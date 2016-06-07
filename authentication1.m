//
//  authentication1.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 06/06/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "authentication1.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "AppDelegate.h"

@interface authentication1 ()

@end

@implementation authentication1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    _img1.hidden=YES;
    _img2.hidden=YES;
    _img3.hidden=YES;
    _img4.hidden=YES;
    _textfield.hidden=YES;
    
    BOOL ab=[dif valueForKey:@"cross1"];
    if(ab != YES)
    {
        
    }
    else
    {
        [dif removeObjectForKey:@"cross1"];
        [_cross setHidden:YES];
    }
    BOOL xyz=[dif valueForKey:@"mangetouch"];
    if(xyz != YES)
    {
      [_textfield becomeFirstResponder];
        
    }
    else
    {
        [dif removeObjectForKey:@"mangetouch"];
        _viewauthentication.hidden=YES;
        [self figerprinttest];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [_textfield addTarget:self
                   action:@selector(textFieldDidChange)
         forControlEvents:UIControlEventEditingChanged];
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 4);
    
}
- (IBAction)back:(id)sender {
    [_textfield resignFirstResponder];
    _viewauthentication.hidden=YES;
    [self figerprinttest];
   
}
-(void)textFieldDidChange
{
    if(_textfield.text.length ==0)
    {
        _img1.hidden=YES;
        _img2.hidden=YES;
        _img3.hidden=YES;
        _img4.hidden=YES;
        _lb1.hidden=NO;
        _lb2.hidden=NO;
        _lb3.hidden=NO;
        _lb4.hidden=NO;
    }
    else if(_textfield.text.length ==1)
    {
        _img1.hidden=NO;
        _img2.hidden=YES;
        _img3.hidden=YES;
        _img4.hidden=YES;
        _lb1.hidden=YES;
        _lb2.hidden=NO;
        _lb3.hidden=NO;
        _lb4.hidden=NO;
    }
    else if(_textfield.text.length == 2)
    {
        _img1.hidden=NO;
        _img2.hidden=YES;
        _img3.hidden=NO;
        _img4.hidden=YES;
        _lb1.hidden=YES;
        _lb2.hidden=NO;
        _lb3.hidden=YES;
        _lb4.hidden=NO;
    }
    else if(_textfield.text.length == 3)
    {
        _img1.hidden=NO;
        _img2.hidden=NO;
        _img3.hidden=NO;
        _img4.hidden=YES;
        _lb1.hidden=YES;
        _lb2.hidden=YES;
        _lb3.hidden=YES;
        _lb4.hidden=NO;
    }
    else if(_textfield.text.length == 4)
    {
        _img1.hidden=NO;
        _img2.hidden=NO;
        _img3.hidden=NO;
        _img4.hidden=NO;
        _lb1.hidden=YES;
        _lb2.hidden=YES;
        _lb3.hidden=YES;
        _lb4.hidden=YES;
        NSString *str=_textfield.text;
        NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
        NSString *str1=[pass valueForKey:@"pass"];
        if([str isEqualToString:str1])
        {
        
           [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:nil];
            
            
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            
            
            UIViewController *topViewController = appDelegate.topViewController1;
            if (![topViewController isKindOfClass:[authentication1 class]]) {
                if ([topViewController isKindOfClass:[UIViewController class]]) {
                    topViewController.view.hidden=false;
                }
                
            }
        }
        else
        {
            
            _img1.hidden=YES;
            _img2.hidden=YES;
            _img3.hidden=YES;
            _img4.hidden=YES;
            _lb1.hidden=NO;
            _lb2.hidden=NO;
            _lb3.hidden=NO;
            _lb4.hidden=NO;
            _textfield.text=@"";
            [_textfield becomeFirstResponder];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Alert"
                                                            message: @"Passcode incorrect"
                                                           delegate: nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            
        }
        
        
    }
}
-(void)figerprinttest

{
    //NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    
    // Do any additional setup after loading the view.
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
                                          
                                          
                                          //                                          UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"                                                                                                  bundle: nil];
                                          //
                                          //                                          authentication1 *controller = (authentication1*)[mainStoryboard                                                       instantiateViewControllerWithIdentifier: @"authentication1"];
                                          //
                                          //                                          //                                          if (![[self topViewController] isKindOfClass:[authentication1 class]]) {
                                          //                                          [self presentViewController:controller animated:false completion:nil];
                                          //                                          //                                         }
                                          
                                          //[self dismissViewControllerAnimated:NO completion:nil];
                                          [_textfield becomeFirstResponder];
                                          [_viewauthentication setHidden:NO];
                                          
                                          return;
                                      }
                                      
                                      if (success)
                                      {
                                          [self dismissViewControllerAnimated:YES completion:nil];
                                          
                                          AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                          
                                          
                                          UIViewController *topViewController = appDelegate.topViewController1;
                                          if (![topViewController isKindOfClass:[authentication1 class]]) {
                                              if ([topViewController isKindOfClass:[UIViewController class]]) {
                                                  topViewController.view.hidden=false;
                                              }
                                              
                                          }
                                          
                                      } else {
                                          NSLog(@"not match");
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
- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController baseViewController:nil];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController baseViewController: (UIViewController*)baseViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController baseViewController:tabBarController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController baseViewController:navigationController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController baseViewController:presentedViewController];
    } else {
        return baseViewController;
    }
}
@end
