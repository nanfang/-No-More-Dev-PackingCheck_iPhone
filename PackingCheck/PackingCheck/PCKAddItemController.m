//
//  PCKAddItemController.m
//  PackingCheck
//
//  Created by nanfang on 8/21/12.
//  Copyright (c) 2012 lvtuxiongdi.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexString.h"
#import "PCKAddItemController.h"
#import "PCKCommon.h"
#import "PCKIndexedItems.h"
#import "PCKItem.h"

@interface PCKAddItemController (){
    UITableView * _tableView;
    UITextField* _searchBar;
    PCKIndexedItems* _indexItems;
}

@end

@implementation PCKAddItemController

- (void) addItem
{
    NSLog(@"add item");
    [self.navigationController popViewControllerAnimated:YES];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"添加宝贝";
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStylePlain target:self action:@selector(addItem)] ;
        
        self.navigationItem.rightBarButtonItem = doneButton;

    }
    return self;
}

- (void)dismissKeyboard
{
    if ([_searchBar isFirstResponder]) {
        [_searchBar resignFirstResponder];
    }
}


- (void)loadTableView
{
    _tableView = [[UITableView alloc]init];
    _tableView.backgroundColor = [PCKCommon tableBackground];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.frame = CGRectMake(0, 79, 320, 480-79-20);
    [self.view addSubview:_tableView];
}

- (void)loadTopview
{
    
    // top view
    UIControl *topView = [[UIControl alloc]init];
    
    topView.backgroundColor = [PCKCommon dottedColor];
    topView.frame = CGRectMake(0, 0, 320, 79);
    
    UILabel * indicatorLabel = [[UILabel alloc]init];
    [topView addSubview:indicatorLabel];
    indicatorLabel.text = @"填入(逗号分隔)或选择几个宝贝:";
    indicatorLabel.font = [PCKCommon bigFont];
    indicatorLabel.textColor = [PCKCommon labelColor];
    indicatorLabel.frame = CGRectMake(15, 11, 300, 14);
    indicatorLabel.backgroundColor = [PCKCommon transparent];
    
    // search bar
    _searchBar = [[UITextField alloc]init];

    _searchBar.frame = CGRectMake(11, 35, 298, 38);
    _searchBar.backgroundColor = [PCKCommon transparent];
    _searchBar.borderStyle = UITextBorderStyleNone;
    _searchBar.layer.borderWidth = 1;
    _searchBar.layer.cornerRadius = 5;
    _searchBar.layer.borderColor = [[PCKCommon borderColor] CGColor];
    _searchBar.backgroundColor = [UIColor whiteColor];    
    _searchBar.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
    _searchBar.leftViewMode = UITextFieldViewModeAlways;
    _searchBar.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;    
    _searchBar.font = [PCKCommon bigFont];
    _searchBar.textColor = [PCKCommon inputColor];

    [topView addSubview:_searchBar];
    [topView addTarget:self action:@selector(dismissKeyboard) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:topView];    
}

- (void)loadView
{
    [super loadView];
    [self loadTableView];
    [self loadTopview];
    
//    UIImageView * separator = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wave-separator.png"]];
    
//    separator.clipsToBounds=NO;
//    separator.frame = CGRectMake(0, 79, 320, 6);
//    [self.view addSubview:separator];
}

-(void)loadData
{
    NSArray * items = [PCKItem all]; 
    _indexItems = [[PCKIndexedItems alloc] initWithItems:(NSArray*)items]; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setToolbarHidden:YES];
    [self loadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView 
{
    return [_indexItems indexNames];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    
    int i = [_indexItems indexOfName:title];
    return i>=0? i:0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section 
{
    return [_indexItems.indexNames count] == 0 ? @"" : [_indexItems.indexNames objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[_indexItems itemsAtIndexNumber:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_indexItems.indexNames count];
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ItemCell";
    UITableViewCell *cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];  
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [PCKCommon cellLabelColor];
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    PCKItem * item = [[_indexItems itemsAtIndexNumber:indexPath.section] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    
    return cell;

}




@end
