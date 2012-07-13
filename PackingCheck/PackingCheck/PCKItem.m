//
//  PCKItem.m
//  PackingCheck
//
//  Created by nanfang on 7/14/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKItem.h"

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

+ (id)ItemWithId:(int)itemId name:(NSString*)name
{
    return [[PCKItem alloc]initWithId:itemId name:name];
    
}

@end
