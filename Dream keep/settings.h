//
//  settings.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 17/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface settings : UIViewController<MFMailComposeViewControllerDelegate>

- (IBAction)appstorerate:(id)sender;
- (IBAction)sendfeedback:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *switch1;
@end
