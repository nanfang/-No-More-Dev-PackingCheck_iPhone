//
//  PCKModel.m
//  PackingCheck
//
//  Created by nanfang on 7/29/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKModel.h"
#import "PCKCommon.h"

@implementation PCKModel

- (id)initWithResultSet:(FMResultSet*)rs
{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return nil;
}

+ (NSArray*) find:(NSString *)sql
{
    FMDatabase *db = [PCKCommon database];
    FMResultSet *rs = [db executeQuery:sql];
    NSMutableArray *list = [NSMutableArray array];
    while([rs next]){
        [list addObject:[[[self class] alloc]initWithResultSet:rs ]];
    }
    return list;
}

@end
