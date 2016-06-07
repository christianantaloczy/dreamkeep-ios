//
//  settings.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 17/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "settings.h"
#import "newpassword.h"
#import "currentpassoword.h"
#import "repeatpassword.h"
#import "sendfeedback.h"
#import "authentication1.h"
#import <LocalAuthentication/LocalAuthentication.h>

#import "authentication.h"
#import "authentication1.h"

@implementation settings
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    [dif removeObjectForKey:@"authentication1"];
    [dif removeObjectForKey:@"touchcheak1"];
    // Do any additional setup after loading the view.
    [self swichstate];
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)viewDidDisappear:(BOOL)animated
{
    
}
-(void)viewWillAppear:(BOOL)animated
{
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(receiveTestNotification:)
//                                                 name:@"TestNotification"
//                                               object:nil];
    [self swichstate];
   NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
//    BOOL pqr=[dif valueForKey:@"touchcheak1"];
//    if ( pqr != YES)
//    {
//        
//    }
//    else
//    {
//    [dif removeObjectForKey:@"touchcheak1"];
//        authentication1 *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"authentication1"];
//        [self presentViewController:rec animated:YES completion:^{}];
//    }
//    BOOL opq=[dif valueForKey:@"authentication1"];
//    if(opq != YES)
//    {
//        [dif removeObjectForKey:@"authentication1"];
//    }
//    else
//    {
//        [dif removeObjectForKey:@"authentication1"];
//        touchcheak1 *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"touchcheak1"];
//        [self presentViewController:rec animated:YES completion:^{}];
//    }
    BOOL ab=[dif valueForKey:@"setting"];
    if ( ab != YES)
    {
    }
    else
    {
        [dif removeObjectForKey:@"setting"];
        newpassword *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"newpassword"];
        [self presentViewController:rec animated:NO completion:^{}];
    }
    
    NSUserDefaults *dif1=[NSUserDefaults standardUserDefaults];
    BOOL abc=[dif1 valueForKey:@"setting1"];
    if ( abc != YES)
    {
        
    }
    else
    {
        [dif1 removeObjectForKey:@"setting1"];
        repeatpassword *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"repeatpassword"];
        [self presentViewController:rec animated:YES completion:^{}];
    }
   
    BOOL xyz=[dif valueForKey:@"switch"];
    if ( xyz != YES)
    {
        [_switch1 setOn:NO animated:YES];
        
    }
    else
    {
        [_switch1 setOn:YES animated:YES];
    }


    
}
- (IBAction)passcode:(id)sender {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
    NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
    
    if([pass valueForKey:@"pass"]==nil)
    {
        newpassword *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"newpassword"];
        [self presentViewController:rec animated:YES completion:^{}];
    }
    else
    {
        currentpassoword *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"currentpassoword"];
        [self presentViewController:rec animated:YES completion:^{}];
    }
}
- (IBAction)appstorerate:(id)sender {
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://appsto.re/in/gjF-q.i"]];
}

- (IBAction)sendfeedback:(id)sender {
//    sendfeedback *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"sendfeedback"];
//    [self presentViewController:rec animated:YES completion:^{}];
    if([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mailCont = [[MFMailComposeViewController alloc] init];
        mailCont.mailComposeDelegate = self;        // Required to invoke mailComposeController when send
        
        [mailCont setSubject:@"Feedback"];
       [mailCont setToRecipients:[NSArray arrayWithObject:@"support@dreamkeep.co"]];
       // [mailCont setMessageBody:@"" isHTML:NO];
        
        [self presentViewController:mailCont animated:YES completion:nil];
    }
}
- (IBAction)shareapp:(id)sender
{
   
    NSString *sharedMsg=[NSString stringWithFormat:@"Hello world"];
    UIImage* sharedImg=[UIImage imageNamed:@"logo.jpg"];
    NSArray* sharedObjects=[NSArray arrayWithObjects:sharedMsg, sharedImg, nil];
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:sharedObjects applicationActivities:nil];
    activityViewController.popoverPresentationController.sourceView = self.view;
    [self presentViewController:activityViewController animated:YES completion:nil];
   }
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    [controller dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)switchact:(id)sender {
    if([sender isOn]){
        NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
        
        if([pass valueForKey:@"pass"]==nil)
        {
            NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
            [dif setBool:YES forKey:@"swichon"];
            [self passcode:sender];
        }
        else
        {
            NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
            [dif setBool:YES forKey:@"switch"];
        }
        
    } else{
        
        NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
        
        if([pass valueForKey:@"pass"]==nil)
        { NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
           [dif removeObjectForKey:@"switch"];
        }
        else
        {
            authentication *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"authentication"];
            [self presentViewController:rec animated:YES completion:^{}];
            NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
            [dif setBool:YES forKey:@"switchauth"];
        }
        
        
    }

}
//- (void) receiveTestNotification:(NSNotification *) notification
//{
//    NSLog(@"notification : %@",notification);
//    
//    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        //update ui
//    });
//    LAContext *context = [[LAContext alloc] init];
//    
//    NSError *error = nil;
//    
//    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//        // Authenticate User
//        
//        NSError *error = nil;
//        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
//            
//            BOOL ab=[dif valueForKey:@"switch"];
//            if ( ab != YES)
//            {
//                NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
//                
//                if([pass valueForKey:@"pass"]==nil)
//                {
//                   
//                    
//                }
//                else
//                { [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
//                    [dif setBool:YES forKey:@"cross1"];
//                   authentication1  *auth=[self.storyboard instantiateViewControllerWithIdentifier:@"authentication1"];
//                    [self presentViewController:auth animated:YES completion:nil];
//                    
//                    
//                }
//            }
//            else
//            {
//                 [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
//                touchcheak1 *auth=[self.storyboard instantiateViewControllerWithIdentifier:@"touchcheak1"];
//                [self presentViewController:auth animated:YES completion:nil];
//            }
//            
//        }
//    }
//    else
//    {
//        NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
//        
//        if([pass valueForKey:@"pass"]==nil)
//        {
//          
//            
//        }
//        else
//        {
//             [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
//            [dif setBool:YES forKey:@"cross1"];
//            authentication1 *auth=[self.storyboard instantiateViewControllerWithIdentifier:@"authentication1"];
//            [self presentViewController:auth animated:YES completion:nil];
//        }
//    }
//   
//}
-(void)swichstate
{
    dispatch_async(dispatch_get_main_queue(), ^{
        //update ui
    });
    LAContext *context = [[LAContext alloc] init];
    
    NSError *error = nil;
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        // Authenticate User
        
        NSError *error = nil;
        if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
            NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
            
            BOOL ab=[dif valueForKey:@"switch"];
            if ( ab != YES)
            {
                
                [_switch1 setOn:NO animated:YES];
            }
            else
            {
                NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
                
                if([pass valueForKey:@"pass"]==nil)
                {
                    [_switch1 setOn:YES animated:YES];
                    [dif removeObjectForKey:@"switch"];
                }
                else
                {
                    [_switch1 setOn:YES animated:YES];
                    
                    [dif setBool:YES forKey:@"switch"];
                }
                
                
            }
            
        }
    }
    else
    {
        [_switch1 setEnabled:NO];
    }

}
@end
