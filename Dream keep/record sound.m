//
//  record sound.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 16/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "record sound.h"
#import "class1.h"
#import "timeline.h"
#import <AudioToolbox/AudioServices.h>
#import <LocalAuthentication/LocalAuthentication.h>

#import "authentication1.h"
@interface record_sound ()<UITextViewDelegate,UIAlertViewDelegate>
{
  
        AVAudioRecorder *recorder;
        AVAudioPlayer *player;
    
    NSString *output;
    NSInteger flag;
    NSString *resultstring;
    BOOL abc;
    
}



@end
@implementation record_sound
@synthesize stopButton, playButton, recordPauseButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initrecoder];
       
    _view1.hidden=YES;
    flag=0;
    abc=true;
    
   
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEEE, MMMM d";
    NSString *string = [formatter stringFromDate:[NSDate date]];
    NSLog(@"%@",string);
//    NSDate *date=[[NSDate alloc]init];
//    NSLog(@"%@",date);
    [_textview1 becomeFirstResponder];
    
    _lb_date.text=string;
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
-(void)initrecoder
{
    // Disable Stop/Play button when application launches
    [stopButton setEnabled:NO];
    [playButton setEnabled:NO];
     [_deletbtn setHidden:YES];
    [_recoding setHidden:YES];
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
#pragma mark-start stop and play record
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
        [recordPauseButton setTitle:@"Pause" forState:UIControlStateNormal];
        
    } else {
        
        // Pause recording
        [recorder pause];
        [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    }
    
    [stopButton setEnabled:YES];
    [playButton setEnabled:NO];
}

- (IBAction)stopTapped:(id)sender {
    [recorder stop];
    [stopButton setHidden:YES];
    [_recoding setHidden:YES];
  [_deletbtn setHidden:NO];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    flag=1;
}

- (IBAction)playTapped:(id)sender {
    
    if(abc==true)
    {
    if (!recorder.recording){
        
        [playButton setImage:[UIImage imageNamed:@"RecordStop@2x.png"] forState:UIControlStateNormal];
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:recorder.url error:nil];
        [player setVolume:1.0];
        [player setDelegate:self];
        [player play];
        abc=false;
    }
    }
    else
    {
    [playButton setImage:[UIImage imageNamed:@"RecordPlay@2x.png"] forState:UIControlStateNormal];
     [player stop];
        abc=true;
    }
}
#pragma mark-add to timekine new dream
- (IBAction)addtimeline:(id)sender {
    
    if(flag==0)
    {
        resultstring=nil;
    }
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    formatter1.dateFormat=@"dd";
    NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
    formatter2.dateFormat=@"EEEE";
    NSDateFormatter *formatter3 = [[NSDateFormatter alloc] init];
    formatter3.dateFormat=@"MMMM yyyy";
    NSString *string1 = [formatter1 stringFromDate:[NSDate date]];
    NSString *string2 = [formatter2 stringFromDate:[NSDate date]];
    NSString *string3 = [formatter3 stringFromDate:[NSDate date]];
    NSString *str = [_textview1.text stringByReplacingOccurrencesOfString:@"'"
                                         withString:@"sq"];
   
    class1 *data=[[class1 alloc]init];
    NSString *query=[[NSString alloc]initWithFormat:@"insert into dreamkeep(dream_Name,Path,date,datename,yearmonth,full_date) values('%@','%@','%@','%@','%@','%@')",str,resultstring,string1,string2,string3,_lb_date.text
                     ];
    BOOL status=[data dboperation:query];
    if (status==true) {
        [self viewDidLoad];
        NSLog(@"insert");
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
        timeline *rec=[self.storyboard instantiateViewControllerWithIdentifier:@"timeline"];
        [self.navigationController pushViewController:rec animated:NO];
        
        [self initrecoder];
        [self.view2 setHidden:YES];
        [recordPauseButton setHidden:NO];
        [stopButton setHidden:NO];
    }
    else
    {
        NSLog(@"not insert");
        
    }
    NSLog(@"velid");
    [self viewDidLoad];
    _textview1.text=@"";

}

#pragma mark - AVAudioRecorderDelegate

- (void) audioRecorderDidFinishRecording:(AVAudioRecorder *)avrecorder successfully:(BOOL)flag{
    
    [recordPauseButton setTitle:@"Record" forState:UIControlStateNormal];
    [stopButton setEnabled:NO];
    [playButton setEnabled:YES];
}

#pragma mark - AVAudioPlayerDelegate

- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
  [playButton setImage:[UIImage imageNamed:@"RecordPlay@2x.png"] forState:UIControlStateNormal];
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if([text isEqualToString:@"\n"])
//        [_textview1 resignFirstResponder];
//    return YES;
//}




- (IBAction)segact:(id)sender {
    if(_segment.selectedSegmentIndex==1)
    {
        timeline *tim=[self.storyboard instantiateViewControllerWithIdentifier:@"timeline"];
        [self.navigationController pushViewController:tim animated:NO];
        
    }
}
#pragma mark-delete recoding
- (IBAction)deletebutton:(id)sender {
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
    [self.view2 setHidden:YES];
}


- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark-alert view to conferm delete
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex==0)
    {
        
    }
    else
    {
        [self initrecoder];
        [player stop];
        flag=0;
        [recordPauseButton setHidden:NO];
        [stopButton setHidden:NO];
    }
}
#pragma mark-textview method
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    
    return YES;
}
@end
 
