//
//  zero.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 26/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "zero.h"
#import "settings.h"
#import <LocalAuthentication/LocalAuthentication.h>

#import "authentication1.h"
@interface zero ()

@end

@implementation zero

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self dismissViewControllerAnimated:NO completion:nil];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
}
-(void)viewDidDisappear:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
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
    settings *set=[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self presentViewController:set animated:YES completion:nil];
}

@end
