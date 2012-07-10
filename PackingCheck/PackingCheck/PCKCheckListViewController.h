//
//  ChildViewController.h
//  SESpringBoardDemo
//
//  Created by Sarp Erdag on 11/5/11.
//  Copyright (c) 2011 Sarp Erdag. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SEViewController.h"
#import "PCKCheckList.h"
#import "PCKCheckItemCell.h"

@interface PCKCheckListViewController : SEViewController<UITableViewDataSource, UITableViewDelegate, PCKCheckItemCellSlideDelegate> { 
    
}
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) PCKCheckList* checkList;
@end
