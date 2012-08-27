//
//  PCKItem.m
//  PackingCheck
//
//  Created by nanfang on 7/14/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKItem.h"
#import "pinyin.h"

@implementation PCKItem
@synthesize itemId=_itemId, name=_name;
- (id)initWithId:(int)itemId name:(NSString*)name
{
    self = [super init];
    if (self) {
        self.itemId = itemId;
        self.name = name;
    }
    return self;
    
}

- (id)initWithResultSet:(FMResultSet*)rs
{
    self = [self initWithId:[(NSNumber *)[rs objectForColumnName:@"id"] intValue]  
                       name:[rs objectForColumnName:@"name"]];
    return self;
}

+ (id)ItemWithId:(int)itemId name:(NSString*)name
{
    return [[PCKItem alloc]initWithId:itemId name:name];
    
}

+ (NSMutableArray*) all
{
    return [self find:@"SELECT * FROM item"];
}

-(NSString*)indexName
{
    char myChar = pinyinFirstLetter([_name characterAtIndex:0]);
    if (myChar == '#'){
        return [_name substringToIndex:1];
    }
    return [NSString stringWithFormat:@"%c" , myChar];

}

@end
