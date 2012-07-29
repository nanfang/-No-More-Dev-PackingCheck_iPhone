//
//  PCKHelper.m
//  PackingCheck
//
//  Created by nanfang on 7/21/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKCommon.h"
#import "PCKConstants.h"
#import "CommonUtils.h"

@implementation PCKCommon

+(FMDatabase*)database{
    static FMDatabase *_database = nil;
    @synchronized(self){
        if(!_database){
            _database = [FMDatabase databaseWithPath:[[CommonUtils documentPath] stringByAppendingPathComponent:DB_PATH]];
            [_database open];
        }
        return _database;    
    }
}

@end
