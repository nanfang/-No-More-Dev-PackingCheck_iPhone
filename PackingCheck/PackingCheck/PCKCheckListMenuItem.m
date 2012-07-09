//
//  PCKMenuItem.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 tukeQ.com. All rights reserved.
//

#import "PCKCheckListMenuItem.h"
#import "PCKCheckList.h"

@implementation PCKCheckListMenuItem
@synthesize checkList = _checkList;
- (id) initWithCheckList:(PCKCheckList *)checkList viewController:(UIViewController *)viewController
{
    self = [super initWithTitle:checkList.name :checkList.imageName :viewController :YES];
    if (self) {
        self.checkList = checkList;
    }
    return self;
}

+ (id) initWithCheckList:(PCKCheckList *)checkList viewController:(UIViewController *)viewController
{
	return [[PCKCheckListMenuItem alloc] initWithCheckList:checkList viewController:viewController];
}



@end
