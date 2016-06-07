//
//  permisson mic.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "permisson mic.h"
#import "record sound.h"
#import "timeline.h"
@implementation permisson_mic

- (IBAction)allowmic:(id)sender {
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    [dif setBool:YES forKey:@"abc" ];
    [self alert];
}
-(void)alert
{
//    UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"Alloe to acess Mic"
//                                                        message:nil delegate:self
//                                              cancelButtonTitle:nil
//                                              otherButtonTitles:@"Allow",@"Not Allow",nil];
//    [alertView show];
    
    
    timeline *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"timeline"];
    [self.navigationController pushViewController:rec animated:NO];
   
    
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0)
//    {
//        AVAudioSession *session = [AVAudioSession sharedInstance];
//        
//        // AZ DEBUG @@ iOS 7+
//        AVAudioSessionRecordPermission sessionRecordPermission = [session recordPermission];
//        switch (sessionRecordPermission) {
//            case AVAudioSessionRecordPermissionUndetermined:
//            {
//                NSLog(@"Mic permission indeterminate. Call method for indeterminate stuff.");
//                record_sound *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"record_sound"];
//                [self.navigationController pushViewController:rec animated:YES];
//            }
//            case AVAudioSessionRecordPermissionDenied:
//                NSLog(@"Mic permission denied. Call method for denied stuff.");
//                break;
//            case AVAudioSessionRecordPermissionGranted:
//            {
//                NSLog(@"Mic permission granted.  Call method for granted stuff.");
//               record_sound *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"record_sound"];
//                [self.navigationController pushViewController:rec animated:YES];
//            }
//                break;
//            default:
//                break;
//        }
//        
//       
//    }
//    else if (buttonIndex == 1)
//    {
//        [alertView dismissWithClickedButtonIndex:1 animated:TRUE];
//    }
//}
@end
