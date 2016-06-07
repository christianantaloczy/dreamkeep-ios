//
//  editdream.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 24/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "editdream.h"
#import <AudioToolbox/AudioServices.h>
#import "class1.h"
#import <LocalAuthentication/LocalAuthentication.h>

#import "authentication1.h"
@interface editdream ()<UITextViewDelegate,UIAlertViewDelegate>
{
    
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSMutableArray *arr;
    NSString *output;
    NSString *resultstring;
    NSString *playingstring;
    NSURL *url;
    NSInteger flag,flag1;
    NSString *finalstring;
    NSString *str;
    BOOL abc;
}
@end

@implementation editdream
@synthesize stopButton, playButton, recordPauseButton;
- (void)viewDidLoad {
    [super viewDidLoad];
     abc=true;
    //[self btnformet];
    [self initrecoder];
    flag=0;
    flag1=1;
    _view1.hidden=YES;
    [_recoding setHidden:YES];
    
    // Do any additional setup after loading the view.
    arr=[[NSMutableArray alloc]init];
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    arr=[dif valueForKey:@"edit"];
    NSLog(@"%@",arr);
    _time.text=[arr objectAtIndex:6];
    NSString *str1 = [[arr objectAtIndex:1] stringByReplacingOccurrencesOfString:@"sq"
                                                                      withString:@"'"];
    _textview1.text=str1;
    _textview2.text=_textview1.text;
    _lb1.hidden=YES;
   // [_textview1 setReturnKeyType:UIReturnKeyDone];
    //[_textview2 setReturnKeyType:UIReturnKeyDone];
    recordPauseButton.hidden=YES;
    stopButton.hidden=YES;
    str=[arr objectAtIndex:0];
    playingstring=[arr objectAtIndex:2];
    finalstring=playingstring;
    if([[arr objectAtIndex:2] isEqualToString:@"(null)"])
    {
        finalstring=resultstring;
        recordPauseButton.hidden=NO;
        stopButton.hidden=NO;
        flag=1;
        flag1=0;
        [_deletebtn setHidden:YES];
    }
    else
    {
        
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
-(void)dismissKeyboard {
    [_textview1 resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
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
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)editdream:(id)sender {
    if(flag1==0)
    {
        finalstring=nil;
    }
    NSString *str1 = [_textview1.text stringByReplacingOccurrencesOfString:@"'"
                                                                      withString:@"sq"];
    class1 *data=[[class1 alloc]init];
    NSString *query=[[NSString alloc]initWithFormat:@"UPDATE dreamkeep SET dream_Name = '%@',Path = '%@' WHERE dream_ID ='%@'",str1,finalstring,str];
    BOOL status=[data dboperation:query];
    if (status==true) {
        [self viewDidLoad];
        NSLog(@"Update");
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        NSLog(@" Not Update");
        
    }

}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return YES;
}
//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//        [_textview1 resignFirstResponder];
//    return YES;
//}
- (IBAction)deletbutton:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Are you sure?"
                                                    message: @""
                                                   delegate: self
                                          cancelButtonTitle:@"Cancel"
                                          otherButtonTitles:@"Delete",nil];
    [alert show];
}
-(void)btnformet
{
    recordPauseButton.layer.borderWidth=10.0f;
    recordPauseButton.layer.borderColor=[[UIColor colorWithRed:0.93f green:0.64f blue:0.45f alpha:1.0f]CGColor];
    recordPauseButton.layer.cornerRadius = recordPauseButton.frame.size.width/2;
    recordPauseButton.clipsToBounds = YES;
    stopButton.layer.cornerRadius = self.stopButton.frame.size.width/2;
    stopButton.clipsToBounds = YES;
    playButton.layer.borderWidth=10.0f;
    playButton.layer.borderColor=[[UIColor colorWithRed:0.93f green:0.64f blue:0.45f alpha:1.0f]CGColor];
    playButton.layer.cornerRadius = playButton.frame.size.width/2;
    playButton.clipsToBounds = YES;
    
    
}
-(void)initrecoder
{
    // Disable Stop/Play button when application launches
    [stopButton setEnabled:NO];
    [playButton setEnabled:YES];
    NSDate *date   = [NSDate date];
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    [dateformatter setDateFormat:@"dd_MM_YYYY_hh:mm:ss"];
    
    NSString *result =[dateformatter stringFromDate:date];
    
    resultstring = [result stringByAppendingString:@".m4a"];
    
    NSLog(@"file name %@",resultstring);
    
    
    
    NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
    
    output = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,resultstring];
    
    NSLog(@"path  %@",output);
    
    NSURL *outputfileurl = [[NSURL alloc]initWithString:output];
    
    AVAudioSession *session =[AVAudioSession sharedInstance];
    
    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    
    
    NSMutableDictionary *recordstring = [[NSMutableDictionary alloc]init];
    
    
    
    [recordstring setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    
    [recordstring setValue:[NSNumber  numberWithFloat:44100.0] forKey:AVSampleRateKey];
    
    [recordstring setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [recordstring setValue:[NSNumber numberWithInt: AVAudioQualityMax] forKey:AVEncoderAudioQualityKey];
    
    
    
    recorder=[[AVAudioRecorder alloc]initWithURL:outputfileurl settings:recordstring error:nil];
    
    recorder.delegate=self;
    
    recorder.meteringEnabled=YES;
    
    
    [recorder prepareToRecord];
}
- (IBAction)playbutton:(id)sender {
    if(flag==0)
    {

        if(abc==true)
        {
            [playButton setImage:[UIImage imageNamed:@"RecordStop@2x.png"] forState:UIControlStateNormal];
            NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
            NSString  *output1 = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,playingstring];
            url = [[NSURL alloc]initWithString:output1];
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [player setDelegate:self];
            [player play];
            abc=false;
        }
        else
        {
            [playButton setImage:[UIImage imageNamed:@"RecordPlay@2x.png"] forState:UIControlStateNormal];
            [player stop];
            abc=true;
        }
        
        
        
        
        
    }
    else if(flag==1)
    {
        if(abc==true)
        {
            if (!recorder.recording){
                [playButton setImage:[UIImage imageNamed:@"RecordStop@2x.png"] forState:UIControlStateNormal];
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
                [player setVolume:1.0];
                [player setDelegate:self];
                [player play];
                abc=false;
            }        }
        else
        {
            [playButton setImage:[UIImage imageNamed:@"RecordPlay@2x.png"] forState:UIControlStateNormal];
            [player stop];
            abc=true;
        }
    }

}


- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    abc=true;
    [playButton setImage:[UIImage imageNamed:@"RecordPlay@2x.png"] forState:UIControlStateNormal];
}
- (IBAction)recordPauseTapped:(id)sender {
    // Stop the audio player before recording
    if (player.playing) {
        [player stop];
    }
    
    if (!recorder.recording) {
        AVAudioSession *session = [AVAudioSession sharedInstance];
        [session setActive:YES error:nil];
        [recordPauseButton setHidden:YES];
        // Start recording
        [_recoding setHidden:NO];
        [recorder record];
        [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [recorder pause];
        [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [stopButton setEnabled:YES];
    [playButton setEnabled:YES];
}

- (IBAction)stopTapped:(id)sender {
    [recorder stop];
    [stopButton setHidden:YES];
    [_deletebtn setHidden:NO];
    [_recoding setHidden:YES];
    flag1=1;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    _view2.hidden=NO;
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        
    }
    else
    {
        [player stop];
        finalstring=resultstring;
        recordPauseButton.hidden=NO;
        stopButton.hidden=NO;
        flag=1;
        flag1=0;
        abc=true;
        [_deletebtn setHidden:YES];
    }
}

@end
