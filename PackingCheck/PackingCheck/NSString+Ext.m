//
//  NSString+Ext.m
//  PackingCheck
//
//  Created by nanfang on 7/23/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "NSString+Ext.h"

@implementation NSString (Ext)

- (int) indexOf:(NSString *)text {
    NSRange range = [self rangeOfString:text];

    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}

- (int) lastIndexOf:(NSString *)text
{
    NSRange range = [self rangeOfString:text options:NSBackwardsSearch];
    
    if ( range.length > 0 ) {
        return range.location;
    } else {
        return -1;
    }
}
@end
