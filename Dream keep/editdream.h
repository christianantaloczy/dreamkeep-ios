//
//  editdream.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 24/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface editdream : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *back;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITextView *textview1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
- (IBAction)editdream:(id)sender;
- (IBAction)deletbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *textview2;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)playbutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deletebtn;
@property (weak, nonatomic) IBOutlet UILabel *recoding;
@end
