//
//  PCKAddListController.m
//  PackingCheck
//
//  Created by nanfang on 8/12/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "PCKAddListController.h"
#import "UIColor+HexString.h"


@interface PCKAddListController (){
    UITextField * _nameField;
}
@end

@implementation PCKAddListController
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"创建清单";
    }
    return self;
}

- (void)addList
{
    NSString* name = _nameField.text;
    // TODO get image name as user choose
    [delegate addListWithName:name imageName:@"icon_default.png"];
    _nameField.text = @"";
    [self quitView];
}

- (void)loadNavBar
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target: self
                                                                                           action: @selector (addList)];
}

- (void)loadNameField
{
    _nameField = [[UITextField alloc]init];
    _nameField.frame = CGRectMake(100, 30, 100, 28);
    _nameField.backgroundColor = [UIColor whiteColor];    
    _nameField.font = [UIFont systemFontOfSize:20];
    _nameField.layer.borderWidth = 1;
    _nameField.layer.cornerRadius = 5;
    _nameField.layer.borderColor = [[UIColor colorWithHexString:@"CACCCE"] CGColor];
    _nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    [self.view addSubview:_nameField];
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor grayColor];
    [self loadNavBar];
    [self loadNameField];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // place any dynamic stuff you want to initialize in the child view here
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    [_nameField becomeFirstResponder];
}


@end
