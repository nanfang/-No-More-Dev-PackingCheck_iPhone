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
    // TODO load checklists from storages
    NSMutableArray *checkLists = [NSMutableArray array];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:1 name:@"爬山" imageName:@"golf-club.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:2 name:@"打篮球" imageName:@"basketball.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:3 name:@"上班" imageName:@"briefcase.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:4 name:@"出差" imageName:@"airport.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:5 name:@"踢球" imageName:@"football.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:6 name:@"徒步" imageName:@"furniture.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:7 name:@"野营" imageName:@"star.png"]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:8 name:@"游泳" imageName:@"golf-club.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:9 name:@"看病" imageName:@"hospital.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:10 name:@"骑车" imageName:@"bicycle.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:11 name:@"逛街" imageName:@"shopping.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:12 name:@"逛超市" imageName:@"shopping.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:13 name:@"打羽毛球" imageName:@"badminton.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:14 name:@"西藏之旅" imageName:@"passport.png" ]];
    [checkLists addObject:[[PCKCheckList alloc]initWithId:15 name:@"云南之旅" imageName:@"passport.png" ]];
    return checkLists;
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

