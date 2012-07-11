//
//  PCKMenuItem.h
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "SEMenuItem.h"
#import "PCKCheckList.h"

@interface PCKCheckListMenuItem : SEMenuItem
@property PCKCheckList * checkList;
- (id) initWithCheckList:(PCKCheckList *)checkList viewController:(UIViewController *)viewController;
+ (id) initWithCheckList:(PCKCheckList *)checkList viewController:(UIViewController *)viewController;
@end
    