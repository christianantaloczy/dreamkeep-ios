//
//  class1.h
//  sqlite_demo
//
//  Created by MAC OS on 1/2/1938 Saka.
//  Copyright (c) 1938 Saka MAC OS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <sqlite3.h>

@interface class1 : NSObject
{
    AppDelegate *appdelegate;
    sqlite3 *Database;
}
@property(retain,nonatomic)NSString *strDBName;
-(BOOL)dboperation:(NSString *)strquery;
-(NSMutableArray *)selectdata:(NSString *)strquery;
@end
