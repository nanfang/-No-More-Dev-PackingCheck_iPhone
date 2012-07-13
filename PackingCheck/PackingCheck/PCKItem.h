//
//  PCKItem.h
//  PackingCheck
//
//  Created by nanfang on 7/14/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCKItem : NSObject
@property(nonatomic) int itemId;
@property(nonatomic, strong) NSString * name;

+ (id)ItemWithId:(int)itemId name:(NSString*)name;
@end
