//
//  PCKHelper.m
//  PackingCheck
//
//  Created by nanfang on 7/21/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKCommon.h"
#import "PCKConstants.h"

@implementation PCKCommon
+ (NSString*)documentPath{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];  
}

+(NSString*)databasePath
{
    return [[self documentPath] stringByAppendingPathComponent:DB_PATH] ;
}

@end
