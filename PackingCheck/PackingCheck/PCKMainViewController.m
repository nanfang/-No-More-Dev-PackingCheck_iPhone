//
//  PCKViewController.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKMainViewController.h"
#import "PCKCheckListViewController.h"
#import "SEMenuItem.h"
#import "PCKSpringBoard.h"
#import "PCKCheckList.h"
#import "JWFolders.h"


@implementation PCKMainViewController
@synthesize configViewController=_configViewController;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)startSetting
{
    CGPoint openPoint = CGPointMake(0, 44); //arbitrary point
    [JWFolders openFolderWithContentView:self.configViewController.view
                                position:openPoint 
                           containerView:self.view 
                               openBlock:^(UIView *contentView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction) {
                                   //perform custom animation here on contentView if you wish

                               }
                              closeBlock:^(UIView *contentView, CFTimeInterval duration, CAMediaTimingFunction *timingFunction) {
                                  //also perform custom animation here on contentView if you wish

                              }
                         completionBlock:^ {
                             //the folder is closed and gone, lets do something cool!

                         }
                               direction:JWFoldersOpenDirectionDown
     ];
}

- (NSArray *)loadCheckLists
{
    return [PCKCheckList all];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableArray *items = [NSMutableArray array];

    NSArray *checkLists = [self loadCheckLists];

    for (PCKCheckList * checkList in checkLists) {
        PCKCheckListViewController *checkListViewController = [[PCKCheckListViewController alloc] initWithNibName:nil bundle:nil];
        checkListViewController.checkList = checkList;
        SEMenuItem *menuItem = [SEMenuItem initWithTitle:checkList.name imageName:checkList.imageName viewController:checkListViewController removable:YES];
        [items addObject:menuItem];
    }
    PCKSpringBoard *board = [PCKSpringBoard initWithTitle:@"旅途清单" items:items launcherImage:[UIImage imageNamed:@"navbtn_home.png"]];
    [self.view addSubview:board];
    self.configViewController = [[PCKConfigViewController alloc] initWithNibName:nil bundle:nil];


}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

