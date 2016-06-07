//
//  authentication.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 31/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "authentication.h"
#import "timeline.h"
@interface authentication ()

@end

@implementation authentication

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    [dif removeObjectForKey:@"active"];
    _img1.hidden=YES;
    _img2.hidden=YES;
    _img3.hidden=YES;
    _img4.hidden=YES;
    _textfield.hidden=YES;
    [_textfield becomeFirstResponder];
    
    BOOL ab=[dif valueForKey:@"authpass1"];
    if ( ab != YES)
    {
        
    }
    else
    {
        [_cross setHidden:YES];
        [dif removeObjectForKey:@"authpass1"];
    }
    BOOL xyz=[dif valueForKey:@"bagbool"];
    if(xyz!=YES)
    {
        
    }
    else
    {
      [_cross setHidden:YES];  
    }

    // Do any additional setup after loading the view.
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (IBAction)back:(id)sender
{
     NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    BOOL ab=[dif valueForKey:@"switchauth"];
    if ( ab != YES)
    {
        [dif setBool:YES forKey:@"scan"];
        [self.navigationController popViewControllerAnimated:NO];
        
    }
    else
    {
        [self.view endEditing:YES];
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [_textfield addTarget:self
                   action:@selector(textFieldDidChange)
         forControlEvents:UIControlEventEditingChanged];
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 4);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)viewWillAppear:(BOOL)animated
{
    [_textfield becomeFirstResponder];
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
            NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
            BOOL ab=[dif valueForKey:@"switchauth"];
            if ( ab != YES)
            {
                
                [dif removeObjectForKey:@"authpass"];
                timeline *tim=[self.storyboard instantiateViewControllerWithIdentifier:@"timeline"];
                [self.navigationController pushViewController:tim animated:NO];
                [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
            }
            else
            {
                [dif removeObjectForKey:@"switchauth"];
                [dif removeObjectForKey:@"switch"];
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            BOOL xyz=[dif valueForKey:@"bagbool"];
            if(xyz!=YES)
            {
                
            }
            else
            {
                [self.view endEditing:YES];
                [self dismissViewControllerAnimated:YES completion:nil];
                [dif removeObjectForKey:@"bagbool"];
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
            [self viewDidLoad];
        }
        
        
    }
}

@end
