//
//  timeline.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 17/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "delete.h"
@interface timeline : UIViewController
{
    UITapGestureRecognizer *tap;
}

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmen;
- (IBAction)segact:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tbl;

@property (weak, nonatomic) IBOutlet UISearchBar *txtsearch;
@property (nonatomic, assign) bool isFiltered;
@property (nonatomic, assign) bool isplaying;
- (IBAction)back:(id)sender;
@end
