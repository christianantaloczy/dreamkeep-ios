//
//  record sound.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface record_sound : UIViewController<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet UIButton *recordPauseButton;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;
@property (weak, nonatomic) IBOutlet UILabel *lb_date;
@property (weak, nonatomic) IBOutlet UIButton *playButton;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UITextView *textview2;

@property (weak, nonatomic) IBOutlet UIButton *btntest;
@property (weak, nonatomic) IBOutlet UILabel *lb2;
@property (weak, nonatomic) IBOutlet UITextView *textview1;
@property (weak, nonatomic) IBOutlet UILabel *lb1;
- (IBAction)recordPauseTapped:(id)sender;
- (IBAction)stopTapped:(id)sender;
- (IBAction)playTapped:(id)sender;
- (IBAction)addtimeline:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *add_timeline;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;
- (IBAction)segact:(id)sender;
- (IBAction)deletebutton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *back;
- (IBAction)back:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *deletbtn;

@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UILabel *recoding;
@end
