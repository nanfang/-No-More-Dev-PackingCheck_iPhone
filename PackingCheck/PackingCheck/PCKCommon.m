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

// TODO make it singleton
+(FMDatabase*)database{
    FMDatabase* db = [FMDatabase databaseWithPath:[[CommonUtils documentPath] stringByAppendingPathComponent:DB_PATH]];
    if ([db open]) {
        return db;
    }
    return nil;
}
@end
