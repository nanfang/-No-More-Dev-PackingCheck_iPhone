//
//  PCKHelper.h
//  PackingCheck
//
//  Created by nanfang on 7/21/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

// TODO find a better place for this delegate
@protocol PCKCheckListDelegate <NSObject>
- (void) addListWithName:(NSString*)name imageName:(NSString*)imageName;
@end

@interface PCKCommon : NSObject

+(FMDatabase*)database;

// colors
+(UIColor*)dottedColor;
+(UIColor*)transparent;
+(UIColor*)borderColor;
+(UIColor*)labelColor;
+(UIColor*)cellLabelColor;
+(UIColor*)inputColor;
+(UIColor*)tableBackground;


// fonts
+(UIFont*) bigFont;



@end
