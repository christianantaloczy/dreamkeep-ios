//
//  sendfeedback.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 28/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface sendfeedback : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *Email;
- (IBAction)submit:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *message;
- (IBAction)back:(id)sender;
@end
