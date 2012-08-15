//
//  PCKAddListController.m
//  PackingCheck
//
//  Created by nanfang on 8/12/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKAddListController.h"

@implementation PCKAddListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.title = @"创建清单";

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // place any dynamic stuff you want to initialize in the child view here
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;    
}


@end
