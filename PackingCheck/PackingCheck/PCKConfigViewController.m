//
//  PCKConfigFolderViewController.m
//  PackingCheck
//
//  Created by nanfang on 7/12/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import "PCKConfigViewController.h"

@interface PCKConfigViewController ()

@end

@implementation PCKConfigViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.frame = CGRectMake(0, 0, 320, 80);
	// Do any additional setup after loading the view.
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
