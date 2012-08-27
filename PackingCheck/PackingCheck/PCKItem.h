//
//  PCKItem.h
//  PackingCheck
//
//  Created by nanfang on 7/14/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PCKModel.h"

@interface PCKItem : PCKModel<PCKIndexed>
@property(nonatomic) int itemId;
@property(nonatomic, strong) NSString * name;

+ (NSMutableArray*) all;
+ (id)ItemWithId:(int)itemId name:(NSString*)name;
@end
