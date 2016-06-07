//
//  newpassword.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 27/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "newpassword.h"
#import "repeatpassword.h"
#define MAX_LENGTH 4
@interface newpassword ()<UITextFieldDelegate>

@end

@implementation newpassword

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _img1.hidden=YES;
    _img2.hidden=YES;
    _img3.hidden=YES;
    _img4.hidden=YES;
    _textfield.hidden=YES;
    [_textfield becomeFirstResponder];
    NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
   
    if([pass valueForKey:@"pass"]==nil)
    {
        [_removepass setHidden:YES];
    }
    else
    {
       
    }
    [pass removeObjectForKey:@"active1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
  
    [_textfield becomeFirstResponder];
 
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    BOOL ab=[dif valueForKey:@"setting1"];
    if ( ab != YES)
    {
        
    }
    else
    {
        [dif removeObjectForKey:@"setting1"];
        
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)back:(id)sender {
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    [_textfield addTarget:self
                   action:@selector(textFieldDidChange)
         forControlEvents:UIControlEventEditingChanged];
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    return !([newString length] > 4);
   
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
        [pass setObject:str forKey:@"pass1"];
        NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
        [dif setBool:YES forKey:@"setting1"];
        [self dismissViewControllerAnimated:NO completion:nil];
    }
}
- (IBAction)removepass:(id)sender {
    NSUserDefaults *pass=[NSUserDefaults standardUserDefaults];
    [pass removeObjectForKey:@"pass"];
    [_removepass setHidden:YES];
    [self.view endEditing:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
