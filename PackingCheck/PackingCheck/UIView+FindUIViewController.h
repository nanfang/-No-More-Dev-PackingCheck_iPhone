//
//  UIView+UIKitCategories.h
//  PackingCheck
//
//  Created by nanfang on 7/12/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (FindUIViewController)
- (UIViewController *) firstAvailableUIViewController;
- (id) traverseResponderChainForUIViewController;
@end
