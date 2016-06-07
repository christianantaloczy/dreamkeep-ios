//
//  sendfeedback.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 28/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "sendfeedback.h"

@interface sendfeedback ()<UITextFieldDelegate,UITextViewDelegate>

@end

@implementation sendfeedback

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_name setReturnKeyType:UIReturnKeyNext];
    [_Email setReturnKeyType:UIReturnKeyNext];
   // [_message setReturnKeyType:UIReturnKeyDone];
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
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField
{
    NSInteger nextTag = textField.tag + 1;
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [_message becomeFirstResponder];
    }
    return NO;
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//        [textView resignFirstResponder];
//    return YES;
//}
- (IBAction)submit:(id)sender {
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    if([_name.text isEqualToString:@""])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Name " delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
        [alert show];
    }
    else if(_name.text.length < 3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"must required 3 word in name" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
        [alert show];
    }
     else if ([emailTest evaluateWithObject:_Email.text] == NO)
    {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter Valid Email Address." delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
        [alert show];
        
    }
     else if ([_message.text isEqualToString:@""])
     {
         
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please Enter message" delegate:nil cancelButtonTitle:@"okay" otherButtonTitles:nil];
         [alert show];
         
     }
     else{
         NSLog(@"submited");
     }
    
}

@end
