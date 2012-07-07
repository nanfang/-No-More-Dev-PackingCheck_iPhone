//
//  PCKViewController.m
//  PackingCheck
//
//  Created by nanfang on 7/7/12.
//  Copyright (c) 2012 tukeQ.com. All rights reserved.
//

#import "PCKMainViewController.h"
#import "PCKCheckListViewController.h"
#import "SEMenuItem.h"
#import "SESpringBoard.h"

@interface PCKMainViewController ()

@end

@implementation PCKMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	PCKCheckListViewController * vc1 = [[PCKCheckListViewController alloc] initWithNibName:nil bundle:nil];
    PCKCheckListViewController * vc2 = [[PCKCheckListViewController alloc] initWithNibName:nil bundle:nil];

    
    // Create an array of SEMenuItem objects
    NSMutableArray *items = [NSMutableArray array];
    [items addObject:[SEMenuItem initWithTitle:@"爬山" imageName:@"facebook.png" viewController:vc1 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"上班" imageName:@"twitter.png" viewController:vc2 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"出差" imageName:@"youtube.png" viewController:vc1 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"踢球" imageName:@"linkedin.png" viewController:vc2 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"徒步" imageName:@"rss.png" viewController:vc1 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"野营" imageName:@"google.png" viewController:vc2 removable:NO]];
    [items addObject:[SEMenuItem initWithTitle:@"游泳" imageName:@"su.png" viewController:vc2 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"看病" imageName:@"digg.png" viewController:vc2 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"骑车" imageName:@"technorati.png" viewController:vc2 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"逛街" imageName:@"facebook.png" viewController:vc1 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"逛超市" imageName:@"facebook.png" viewController:vc2 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"打羽毛球" imageName:@"youtube.png" viewController:vc1 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"西藏之旅" imageName:@"linkedin.png" viewController:vc1 removable:YES]];
    [items addObject:[SEMenuItem initWithTitle:@"云南之旅" imageName:@"facebook.png" viewController:vc1 removable:YES]];
    
    // Pass the array to a newly created SESpringBoard and add it to your view.
    // The launcher image is the image for the button on the top left corner of the view controller that is gonna appear in the screen
    // after a SEMenuItem is tapped. It is used for going back to the home screen
    
    SESpringBoard *board = [SESpringBoard initWithTitle:@"旅途清单" items:items launcherImage:[UIImage imageNamed:@"navbtn_home.png"]];
    [self.view addSubview:board];

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
