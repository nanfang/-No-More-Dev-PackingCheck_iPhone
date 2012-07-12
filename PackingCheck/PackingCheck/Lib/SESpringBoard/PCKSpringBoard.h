//
//  SESpringBoard.h
//  SESpringBoardDemo
//
//  Created by Sarp Erdag on 11/5/11.
//  Copyright (c) 2011 Sarp Erdag. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SEMenuItem.h"
#import "PCKConfigViewController.h"

@interface PCKSpringBoard : UIView <MenuItemDelegate, UIScrollViewDelegate> {
    UINavigationBar *navigationBar;
    UINavigationController *nav;
    UIScrollView *itemsContainer;
    UIPageControl *pageControl;
    UIButton *doneEditingButton;
} 

@property (nonatomic) NSString *title;
@property (nonatomic) UIImage *launcher;
@property (nonatomic) NSMutableArray *items;
@property (nonatomic) NSMutableArray *itemCounts;    // holds how many items there are in each page
@property BOOL isInEditingMode;

+ (id) initWithTitle:(NSString *)boardTitle items:(NSMutableArray *)menuItems launcherImage:(UIImage *)image;

- (void) disableEditingMode;
- (void) enableEditingMode;

@end
