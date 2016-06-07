//
//  authentication.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 31/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface authentication : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *img2;
@property (weak, nonatomic) IBOutlet UIImageView *img3;
@property (weak, nonatomic) IBOutlet UIImageView *img4;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UILabel *lb3;
@property (weak, nonatomic) IBOutlet UILabel *lb4;
@property (weak, nonatomic) IBOutlet UIButton *cross;
@end
