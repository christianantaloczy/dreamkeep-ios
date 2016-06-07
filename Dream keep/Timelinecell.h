//
//  Timelinecell.h
//  Dream keep
//
//  Created by Paras Chodavadiya on 18/05/16.
//  Copyright © 2016 IBLinfotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "play.h"
#import "scrolling.h"
#import "delete.h"
@interface Timelinecell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *dreamday;
@property (weak, nonatomic) IBOutlet UILabel *dreamname;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet play *playbtn;
@property (weak, nonatomic) IBOutlet scrolling *scrollview;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet delete *deletvtn;


@end
