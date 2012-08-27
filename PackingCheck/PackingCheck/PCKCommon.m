//
//  PCKHelper.m
//  PackingCheck
//
//  Created by nanfang on 7/21/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKCommon.h"
#import "PCKConstants.h"
#import "CommonUtils.h"
#import "UIColor+HexString.h"

@implementation PCKCommon

+(FMDatabase*)database{
    static FMDatabase *_database = nil;
    @synchronized(self){
        if(!_database){
            _database = [FMDatabase databaseWithPath:[[CommonUtils documentPath] stringByAppendingPathComponent:DB_PATH]];
            [_database open];
        }
        return _database;    
    }
}

// colors
+(UIColor*)dottedColor
{
    static UIColor * _dottedColor = nil;
    if(!_dottedColor){
        _dottedColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted.png"]];
    }
    return _dottedColor;
}

+(UIColor*)transparent
{
    static UIColor * _transparent = nil;
    if(!_transparent){
        _transparent = [UIColor clearColor];
    }
    return _transparent;
}

+(UIColor*)borderColor
{
    static UIColor * _borderColor = nil;
    if(!_borderColor){
        _borderColor = [UIColor colorWithHexString:@"CACCCE"];
    }
    return _borderColor;
}

+(UIColor*)labelColor
{
    static UIColor * _labelColor = nil;
    if(!_labelColor){
        _labelColor = [UIColor colorWithHexString:@"#555555"];
    }
    return _labelColor;
}

+(UIColor*)cellLabelColor
{
    static UIColor * _cellLabelColor = nil;
    if(!_cellLabelColor){
        _cellLabelColor = [UIColor colorWithHexString:@"#777777"];
    }
    return _cellLabelColor;
}

+(UIColor*)inputColor
{
    static UIColor * _inputColor = nil;
    if(!_inputColor){
        _inputColor = [UIColor colorWithHexString:@"#999999"];
    }
    return _inputColor;
}

+(UIColor*)tableBackground
{
    static UIColor * _tableBackgroundColor = nil;
    if(!_tableBackgroundColor){
        _tableBackgroundColor = [UIColor colorWithHexString:@"#F9F8F5"];
    }
    return _tableBackgroundColor;
    
}

// fonts
+(UIFont*) bigFont
{
    static UIFont * _bigFont = nil;
    if(!_bigFont){
        _bigFont = [UIFont systemFontOfSize:14];
    }
    return _bigFont;
}

@end
