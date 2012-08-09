//
//  PCKModel.m
//  PackingCheck
//
//  Created by nanfang on 7/29/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKModel.h"
#import "PCKCommon.h"
@interface FMDatabase ()
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray*)arrayArgs orDictionary:(NSDictionary *)dictionaryArgs orVAList:(va_list)args;
@end
@implementation PCKModel

- (id)initWithResultSet:(FMResultSet*)rs
{
    NSAssert(NO, @"Subclasses need to overwrite this method");
    return nil;
}

+ (NSMutableArray*) find:(NSString *)sql, ...
{
    va_list args;
    va_start(args, sql);

    FMDatabase *db = [PCKCommon database];
    FMResultSet *rs = [db executeQuery:sql withArgumentsInArray:nil orDictionary:nil orVAList:args];
    va_end(args);
    NSMutableArray *list = [NSMutableArray array];
    
    while([rs next]){
        [list addObject:[[[self class] alloc]initWithResultSet:rs ]];
    }
    return list;
}


@end
