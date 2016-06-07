//
//  timeline.m
//  Dream keep
//
//  Created by Paras Chodavadiya on 17/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import "timeline.h"
#import "class1.h"
#import "Timelinecell.h"
#import <AVFoundation/AVFoundation.h>
#import "play.h"
#import "editdream.h"
#import "scrolling.h"
#import "record sound.h"
#import "settings.h"
#import "zero.h"
#import <LocalAuthentication/LocalAuthentication.h>
#import "touchcheak.h"
#import "authentication.h"
#import "authentication1.h"
#
@interface timeline ()<UITableViewDataSource,UITableViewDelegate,AVAudioRecorderDelegate, AVAudioPlayerDelegate,UIAlertViewDelegate,UITextFieldDelegate,UISearchBarDelegate>
{
    NSMutableArray *record,*revece,*FilterData,*holddata,*holddata1;
    AVAudioRecorder *recorder;
    AVAudioPlayer *player;
    NSURL *url;
    NSInteger flag1;
    NSMutableArray *month,*finalmonth,*finalrecode;
    play *abc;
    NSInteger currentindexpath,currentsection;
     NSInteger preindexpath,presection;
}
@end
@implementation timeline
@synthesize isFiltered;
@synthesize isplaying;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    flag1=0;
    finalrecode = [[NSMutableArray alloc] init];
    finalmonth = [[NSMutableArray alloc] init];
    
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [_segmen setSelectedSegmentIndex:1];
    [self retrivdata];
   [self retrivedata1];
    [[_segmen.subviews objectAtIndex:_segmen.selectedSegmentIndex] setTintColor:[UIColor whiteColor]];
    
    currentsection=-1;
    currentindexpath=-1;
    presection=-1;
    preindexpath=-1;
    
}
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
   
    currentsection=-1;
    currentindexpath=-1;
    [_tbl reloadData];
   
    [self retrivedata1];
    [_segmen setSelectedSegmentIndex:1];
}

-(void)viewDidDisappear:(BOOL)animated {
    //[[NSNotificationCenter defaultCenter] removeObserver:self name:@"TestNotification" object:nil];
}


- (IBAction)segact:(id)sender {
    if(_segmen.selectedSegmentIndex==0)
    {
        [self.navigationController popViewControllerAnimated:NO];
    }
}
#pragma mark-get data from data base  m
-(void)retrivdata
{
        record=[[NSMutableArray alloc]init];
        class1 *data=[[class1 alloc]init];
        NSString *query=[[NSString alloc]initWithFormat:@"select * from dreamkeep"];
        record=[data selectdata:query];
        //revece=[[record reverseObjectEnumerator]allObjects];
        int i=[record count];
        if (i!=0) {
    
            //_txt1.text=[record objectAtIndex:1];
            //NSLog(@"%@",record);
            _txtsearch.hidden=NO;
            _tbl.hidden=NO;
          
        }
        else
        {
            _txtsearch.hidden=YES;
            _tbl.hidden=YES;
            
        }
}
-(void)retrivedata1
{
    finalmonth=[[NSMutableArray alloc]init];
    finalrecode=[[NSMutableArray alloc]init];
    record=[[NSMutableArray alloc]init];
    class1 *data=[[class1 alloc]init];
    NSString *query=[[NSString alloc]initWithFormat:@"select * from dreamkeep group by yearmonth"];
    record=[data selectdata:query];
    //revece=[[record reverseObjectEnumerator]allObjects];
    NSMutableArray *row=[[NSMutableArray alloc]init];
    month=[[NSMutableArray alloc]init];
    for (int i=0;i<[record count]; i++)
    {
        row=[[NSMutableArray alloc]init];
        row=[record objectAtIndex:i];
        [month addObject:[row objectAtIndex:5]];
        //NSLog(@"%@",month);
    }
    for(int i=0; i<[month count];i++)
    {    NSMutableArray *temp=[[NSMutableArray alloc]init];
        row=[[NSMutableArray alloc]init];
        row=[month objectAtIndex:i];
        NSString *query=[[NSString alloc]initWithFormat:@"select * from dreamkeep where yearmonth='%@' order by dream_id desc",row];
        [temp addObject:row];
        [finalmonth addObject:temp];
        
        [finalrecode addObject:[data selectdata:query]];
    }
    
    NSLog(@"all month %@",finalmonth);
    NSLog(@" all data%@",finalrecode);
}

#pragma mark -tableview method
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    int rowCount;
    if(self.isFiltered)
    {
        rowCount = 1;
    }
    else
    {
        rowCount = finalrecode.count;
    }
    return rowCount;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    int rowCount;
    if(self.isFiltered)
    {
        rowCount = FilterData.count;
    }
    else
    {
        rowCount = [[finalrecode objectAtIndex:section] count];
    }
    return rowCount;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    Timelinecell *Cell = [tableView dequeueReusableCellWithIdentifier:@"SimpleTableCell"];
    if (Cell == nil) {
        Cell = [[NSBundle mainBundle]loadNibNamed:@"Timelinecell" owner:self options:nil][0];
    }
    if(isFiltered)
    {
        NSMutableArray *temp=[[NSMutableArray alloc]init];
        temp= [FilterData objectAtIndex:indexPath.row];
        NSString *str = [[temp objectAtIndex:1] stringByReplacingOccurrencesOfString:@"sq"
                                                                          withString:@"'"];
        Cell.dreamname.text=str;
        Cell.date.text=[temp objectAtIndex:3];
        Cell.dreamday.text=[temp objectAtIndex:4];
        if([[temp objectAtIndex:2] isEqualToString:@"(null)"])
        {
            [Cell.playbtn setHidden:YES];
        }
        else
        {
            [Cell.playbtn setHidden:NO];
        }
        Cell.playbtn.tag2=indexPath.row;
        Cell.playbtn.tag1=indexPath.section;
        [Cell.playbtn addTarget:self action:@selector(playaudio:)
               forControlEvents:UIControlEventTouchUpInside];;
        Cell.view1.frame=CGRectMake(_tbl.frame.size.width+10,0,55,Cell.contentView.frame.size.height);
        [Cell.scrollview addSubview:Cell.view1];
        Cell.scrollview.contentSize=CGSizeMake(Cell.view1.frame.size.width+Cell.view1.frame.origin.x,Cell.scrollview.frame.size.height);
        Cell.scrollview.userInteractionEnabled = YES;
        Cell.scrollview.tag2 = indexPath.row;
        Cell.scrollview.tag1=indexPath.section;
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapscroll:)];
        [Cell.scrollview addGestureRecognizer:tap];
        if(currentindexpath == indexPath.row)// && player.playing)
        {
            [Cell.playbtn setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];
            
        }
        else
        {
            [Cell.playbtn setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
            
        }
    }
    else
    {
        NSMutableArray *temp=[[NSMutableArray alloc]init];
        temp=[[finalrecode objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSString *str = [[temp objectAtIndex:1] stringByReplacingOccurrencesOfString:@"sq"
                                                                   withString:@"'"];
        Cell.dreamname.text=str;
        Cell.date.text=[temp objectAtIndex:3];
        Cell.dreamday.text=[temp objectAtIndex:4];
       
        if([[temp objectAtIndex:2] isEqualToString:@"(null)"])
        {
            [Cell.playbtn setHidden:YES];
        }
        else
        {
         [Cell.playbtn setHidden:NO];
        }
        Cell.playbtn.tag2=indexPath.row;
        Cell.playbtn.tag1=indexPath.section;
        [Cell.playbtn addTarget:self action:@selector(playaudio:)
               forControlEvents:UIControlEventTouchUpInside];;
        Cell.view1.frame=CGRectMake(_tbl.frame.size.width+10,0,55,Cell.contentView.frame.size.height);
        [Cell.scrollview addSubview:Cell.view1];
        Cell.scrollview.contentSize=CGSizeMake(Cell.view1.frame.size.width+Cell.view1.frame.origin.x,Cell.scrollview.frame.size.height);
        Cell.scrollview.userInteractionEnabled = YES;
        Cell.scrollview.tag2 = indexPath.row;
        Cell.scrollview.tag1=indexPath.section;
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapscroll:)];
        [Cell.scrollview addGestureRecognizer:tap];
        Cell.deletvtn.tag1=indexPath.section;
        Cell.deletvtn.tag2=indexPath.row;
        [Cell.deletvtn addTarget:self action:@selector(deleterecode:)
                forControlEvents:UIControlEventTouchUpInside];;
        if(currentsection==indexPath.section && currentindexpath == indexPath.row)// && player.playing)
        {
            [Cell.playbtn setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];
           
        }
        else
        {
             [Cell.playbtn setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
           
        }
        
        
    }
    
    
    
    return Cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section

{
    
    UIView *viewabc  = [[UIView alloc]init];
    if(isFiltered)
    { if(FilterData.count==0)
    {
        viewabc.backgroundColor=[UIColor colorWithRed:0.29 green:0.29f blue:0.29 alpha:1.0f];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.6, 0, 105, 20)];
        lbl.textColor=[UIColor whiteColor];
        lbl.text=@"No results";
        
        [viewabc addSubview:lbl];
    }else
    {
       viewabc.backgroundColor=[UIColor colorWithRed:0.29f green:0.29f blue:0.29f alpha:1.0f];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.75, 0, 110, 20)];
        lbl.textColor=[UIColor whiteColor];
        lbl.text=@"Search results";
        
        [viewabc addSubview:lbl];
    }
   }
    else
    {
        viewabc.backgroundColor=[UIColor colorWithRed:0.29f green:0.29f blue:0.29 alpha:1.0f];
        UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.6, 0, 100, 20)];
        lbl.textColor=[UIColor whiteColor];
        NSMutableArray *temp=[[NSMutableArray alloc]init];
        temp =[finalmonth objectAtIndex:section];
        lbl.text=[temp objectAtIndex:0];
        
        [viewabc addSubview:lbl];
    }
    
    return viewabc;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
#pragma mark-audio player method
-(void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    [abc setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
    flag1=0;
}
- (void) audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
    
    currentindexpath=-1;
    currentsection=-1;
     flag1=0;
    [_tbl reloadData];
}
-(void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags
{
    [abc setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
    flag1=0;
}


#pragma mark -searchbar method
-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString*)text
{
    _txtsearch.showsCancelButton = YES;
        [_txtsearch setShowsCancelButton:YES animated:YES];
        FilterData = [[NSMutableArray alloc]init];
        //new data get
        record=[[NSMutableArray alloc]init];
        class1 *data=[[class1 alloc]init];
        NSString *query=[[NSString alloc]initWithFormat:@"select * from dreamkeep"];
        record=[data selectdata:query];
        // NSLog(@"%@",record);
    
        NSMutableArray *row=[[NSMutableArray alloc]init];

    if(text.length == 0)
    {
        isFiltered = FALSE;
    }
    else
    {
        isFiltered = true;
        FilterData = [[NSMutableArray alloc] init];
        
        
        for (int i = 0; i < record.count ; i++)
        {
            row=[[NSMutableArray alloc]init];
            row=[record objectAtIndex:i];
            NSString *str = [[row objectAtIndex:1] stringByReplacingOccurrencesOfString:@"sq"
                                                                              withString:@"'"];
            NSRange nameRange = [str rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound )
            {
                [FilterData addObject:row];
            }
        }
    }
    
    [self.tbl reloadData];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    _txtsearch.showsCancelButton = YES;
    [_txtsearch setShowsCancelButton:YES animated:YES];
    return YES;
}
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    _txtsearch.showsCancelButton = NO;
    [_txtsearch setShowsCancelButton:NO animated:YES];
   [searchBar resignFirstResponder];
    [_tbl reloadData];
}

#pragma mark-player play insade cell
-(void)playaudio:(play *)sender
{
    
    abc=sender;
   
    if(isFiltered)
    {
        if ([sender tag2] != currentindexpath)
        {
            flag1 = 0;
        }
        currentindexpath=sender.tag2;

        if(flag1==0)
        {
            if(player.playing)
            {
                [player stop];
            }
            NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
            NSMutableArray *temp=[[NSMutableArray alloc]init];
            temp=[FilterData objectAtIndex:sender.tag2];
            NSString  *output = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,[temp objectAtIndex:2]];
        [sender setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];

            url = [[NSURL alloc]initWithString:output];
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [player setDelegate:self];
            [player play];
            preindexpath=sender.tag2;
            flag1 = 1;
            
        }
        else
        {
            if(currentindexpath==preindexpath)
            {
               
                currentindexpath=-1;
                [sender setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
                [player stop];
                flag1=0;
            }
            else{
                if(player.playing)
                {
                    [player stop];
                }
                NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
                NSMutableArray *temp=[[NSMutableArray alloc]init];
                temp=[FilterData objectAtIndex:sender.tag2];
                NSString  *output = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,[temp objectAtIndex:2]];
                [sender setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];
                
                url = [[NSURL alloc]initWithString:output];
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                [player setDelegate:self];
                [player play];
                preindexpath=sender.tag2;
                flag1 = 1;
            }

        }
        [self.tbl reloadData];
    }
    else
    {
        if ([sender tag1] != currentsection && [sender tag2] != currentindexpath)
        {
            flag1 = 0;
        }
        
        currentindexpath=sender.tag2;
        currentsection=sender.tag1;
        
        
        if(flag1==0)
        {
            if(player.playing)
            {
                [player stop];
            }
            NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
            NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
            NSMutableArray *temp=[[NSMutableArray alloc]init];
            temp=[[finalrecode objectAtIndex:sender.tag1] objectAtIndex:sender.tag2];
            NSString  *output = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,[temp objectAtIndex:2]];
            [sender setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];
            url = [[NSURL alloc]initWithString:output];
            player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
            [player setDelegate:self];
            [player play];
            preindexpath=sender.tag2;
            presection=sender.tag1;
            flag1 = 1;
        }
        else
        {
            if(currentsection==presection && currentindexpath==preindexpath)
            {
                currentsection=-1;
                currentindexpath=-1;
                [sender setImage:[UIImage imageNamed:@"Triangle 1 Blue.png"]forState:UIControlStateNormal];
                [player stop];
                flag1=0;
            }
            else
            {
                if(player.playing)
            {
                [player stop];
            }
                NSArray *pathcomponent = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                NSURL *outputfileur = [NSURL fileURLWithPathComponents:pathcomponent];
                NSMutableArray *temp=[[NSMutableArray alloc]init];
                temp=[[finalrecode objectAtIndex:sender.tag1] objectAtIndex:sender.tag2];
                NSString  *output = [[NSString alloc]initWithFormat:@"%@%@",outputfileur,[temp objectAtIndex:2]];
                [sender setImage:[UIImage imageNamed:@"ic_pause@3x.png"]forState:UIControlStateNormal];
                url = [[NSURL alloc]initWithString:output];
                player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
                [player setDelegate:self];
                [player play];
                preindexpath=sender.tag2;
                presection=sender.tag1;
                flag1 = 1;
            }
            
        }
        [self.tbl reloadData];
    }
    
}
#pragma mark-delete and edit recode
-(void)deleterecode:(delete *)sender
{
    if (player.playing) {
        [player stop];
    }
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    temp=[[finalrecode objectAtIndex:sender.tag1] objectAtIndex:sender.tag2];
    NSString *str=[temp objectAtIndex:0];
    [[finalrecode objectAtIndex:sender.tag1] removeObjectAtIndex:sender.tag2];
    [finalrecode removeObjectAtIndex:sender.tag1];
    NSLog(@"%@",str);
    class1 *data=[[class1 alloc]init];
    NSString *query=[[NSString alloc]initWithFormat:@"Delete from dreamkeep where dream_id='%@'",str];
    BOOL status=[data dboperation:query];
    if (status==true) {
        
        NSLog(@"delet");
        [self retrivedata1];
        [self retrivdata];
        [_tbl reloadData];
    }
    else
    {
        NSLog(@"no delet");
        
    }
    
}

-(void)tapscroll:(UITapGestureRecognizer *)sender
{
    if (player.playing) {
        [player stop];
    }
    Timelinecell *Cell = (Timelinecell *)[[sender.view superview] superview];
    NSInteger indexx = Cell.scrollview.tag2;
    NSInteger section= Cell.scrollview.tag1;
    NSMutableArray *temp=[[NSMutableArray alloc]init];
    temp=[[finalrecode objectAtIndex:section] objectAtIndex:indexx];
    NSUserDefaults *dif=[NSUserDefaults standardUserDefaults];
    [dif setObject:temp forKey:@"edit"];
    editdream *tim=[self.storyboard instantiateViewControllerWithIdentifier:@"editdream"];
    [self.navigationController pushViewController:tim animated:YES];
}

- (IBAction)back:(id)sender {
    settings *set=[self.storyboard instantiateViewControllerWithIdentifier:@"settings"];
    [self presentViewController:set animated:YES completion:nil];
}

@end
