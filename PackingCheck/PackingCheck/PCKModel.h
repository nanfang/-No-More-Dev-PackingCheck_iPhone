//
//  PCKModel.h
//  PackingCheck
//
//  Created by nanfang on 7/29/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
@interface PCKModel : NSObject
- (id)initWithResultSet:(FMResultSet*)rs;
+ (NSArray*) find:(NSString *)sql;
@end
