//
//  class1.m
//  sqlite_demo
//
//  Created by MAC OS on 1/2/1938 Saka.
//  Copyright (c) 1938 Saka MAC OS. All rights reserved.
//

#import "class1.h"
@implementation class1

-(id)init
{
    if (self=[super init]) {
        appdelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
        self.strDBName=[[NSString alloc]initWithString:appdelegate.StrdbPAth];
        
    }
    return self;
}

-(BOOL)dboperation:(NSString *)strquery
{
    BOOL result=false;
    if (sqlite3_open([_strDBName UTF8String], &Database)==SQLITE_OK) {
        sqlite3_stmt *compilestmt;
        if (sqlite3_prepare_v2(Database, [strquery UTF8String], -1, &compilestmt, nil)==SQLITE_OK) {
            sqlite3_step(compilestmt);
            result=true;
        }
        sqlite3_finalize(compilestmt);
    }
    sqlite3_close(Database);
    return result;
}

-(NSMutableArray *)selectdata:(NSString *)strquery
{
     NSMutableArray *finalarray=[[NSMutableArray alloc]init];
    NSMutableArray *Arrdata=[[NSMutableArray alloc]init];
    if (sqlite3_open([_strDBName UTF8String], &Database)==SQLITE_OK) {
        sqlite3_stmt *compilestmt;
        if (sqlite3_prepare_v2(Database, [strquery UTF8String], -1, &compilestmt, nil)==SQLITE_OK) {
            while (sqlite3_step(compilestmt)==SQLITE_ROW) {
                NSString *d_id=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 0)];
                NSString *d_name=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 1)];
                NSString *d_path=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 2)];
                 NSString *d_date=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 3)];
                NSString *d_date_name=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 4)];
                NSString *d_date_myear=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 5)];
                NSString *d_date_full=[[NSString alloc]initWithUTF8String:(char *)sqlite3_column_text(compilestmt, 6)];
                 Arrdata=[[NSMutableArray alloc]init];
                [Arrdata addObject:d_id];
                [Arrdata addObject:d_name];
                [Arrdata addObject:d_path];
                [Arrdata addObject:d_date];
                [Arrdata addObject:d_date_name];
                [Arrdata addObject:d_date_myear];
                [Arrdata addObject:d_date_full];
                [finalarray addObject:Arrdata];
            }
        }
        sqlite3_finalize(compilestmt);
    }
    sqlite3_close(Database);
    return finalarray;
}
@end
