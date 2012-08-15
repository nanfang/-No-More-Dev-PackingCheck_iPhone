//
//  PCKViewController.h
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PCKCheckListViewController.h"
#import "PCKConfigViewController.h"
#import "SEMenuItem.h"
#import "PCKSpringBoard.h"

@protocol PCKCheckListDelegate <NSObject>
- (void) addCheckList:(NSString*)name;
//- (void) removeCheckList:(int)listId;
@end

@interface PCKMainViewController : UIViewController<PCKCheckListDelegate>{
}
@property (nonatomic, strong) PCKConfigViewController *configViewController;

- (void)startSetting;
@end
