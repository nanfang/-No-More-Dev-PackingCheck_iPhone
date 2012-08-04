//
//  PCKCheckList.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKCheckList.h"
#import "FMDatabase.h"
#import "PCKCommon.h"
#import "DBUtils.h"

@implementation PCKCheckList
@synthesize name=_name, listId=_listId, imageName=_imageName;
- (id)initWithId:(int)listId name:(NSString*)name imageName:(NSString*)imageName
{
    self = [super init];
    if (self) {
        self.listId = listId;
        self.name = name;
        self.imageName = imageName;
    }
    return self;

}

- (id)initWithResultSet:(FMResultSet*)rs
{
    self = [self initWithId:[(NSNumber *)[rs objectForColumnName:@"id"] intValue]  
                       name:[rs objectForColumnName:@"name"] 
                    imageName:[rs objectForColumnName:@"image_name"]];
    return self;
}

- (void)increaseOpens
{
    NSLog(@"incr");
    FMDatabase* db = [PCKCommon database];
    [db executeUpdate:@"UPDATE check_list SET opens=opens+1 WHERE id=?", [NSNumber numberWithInt:self.listId]];
}

+ (NSArray*) all
{
    return [self find:@"SELECT * FROM check_list ORDER BY opens DESC"];
}
@end
