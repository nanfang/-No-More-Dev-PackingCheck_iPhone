#import "PCKCheckListViewController.h"
#import "TDBadgedCell.h"
#import "PCKCheckItemCell.h"
#import "PCKItem.h"
#import "PCKBuyButton.h"

@interface PCKCheckListViewController(){
    NSMutableSet * _checkedItems;
    NSMutableArray* _items;
}
@end
@implementation PCKCheckListViewController
@synthesize checkList=_checkList, tableView=_tableView, progressView=_progressView;


- (void) loadItems
{
    
    _items = [_checkList items];
    _checkedItems = [NSMutableSet set];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // place any dynamic stuff you want to initialize in the child view here
    [self.navigationController.toolbar addSubview:self.progressView];
    [self.navigationController setToolbarHidden:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;    
    self.navigationController.toolbar.tintColor = [UIColor blackColor];

}

- (void)increaseOpens
{
    [self.checkList increaseOpens];    
}

- (void)addItem: (id)sender
{
    NSLog(@"TODO add");
}

- (void)editItems: (id)sender
{
    NSLog(@"TODO edit");    
}

- (void)checkDone: (id)sender
{
    NSLog(@"TODO check done");    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    PCKBuyButton *resetButton = [[PCKBuyButton alloc]initWithFrame:CGRectMake(10.0, 0.0, 70.0, 30.0)];
    [resetButton addTarget:self action:@selector(checkDone:) forControlEvents:UIControlEventTouchUpInside];
    [resetButton setTitle:@"开始检查" forState:UIControlStateNormal];
    [resetButton setTitle:@"结束检查" forState:UIControlStateSelected];
	resetButton.center = self.view.center;
	[resetButton setBuyBlock:^(void){
        NSLog(@"buy");
    }];
    
    UIBarButtonItem *buttonCheck = [[ UIBarButtonItem alloc ]initWithCustomView:resetButton];
    
    NSArray *toolBarItems = [[NSArray alloc] initWithObjects:buttonCheck, nil];
    self.toolbarItems = toolBarItems;
    
    self.title = self.checkList.name;
    CGRect tvFrame = self.view.bounds;
    
    tvFrame.size = CGSizeMake(tvFrame.size.width, tvFrame.size.height - 80);
    self.tableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    

    [self.view addSubview:self.tableView];
    [self loadItems];

    UIBarButtonItem *addLauncher = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                  target: self
                                                                                  action: @selector (addItem:)];
    UIBarButtonItem *editLauncher = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                 target: self
                                                                                 action: @selector (editItems:)];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects: editLauncher,addLauncher, nil];
    // TODO make it looks better 
    self.progressView = [[DACircularProgressView alloc] initWithFrame:CGRectMake(240.0f, 4.0f, 36.0f, 36.0f)];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_items count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PCKCheckListCell";

    PCKCheckItemCell *cell = (PCKCheckItemCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PCKCheckItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize: 18];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.delegate = self;
    }

    cell.badgeString = [NSString stringWithFormat:@"%d", indexPath.row + 1];

    if(indexPath.row < 3){
        cell.badgeColor = [UIColor redColor];
    }else {
        cell.badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
    }
    
    PCKItem * item = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    cell.item = item;
    cell.hide = NO;

    
    if ([_checkedItems containsObject:[NSNumber numberWithInt:item.itemId]]){
        cell.hide = YES;
    }

    return cell;

}

#pragma PCKCheckItemCellSlideDelegate
- (void)cellDidHide:(PCKCheckItemCell *)cell
{
    [_checkedItems addObject:[NSNumber numberWithInt:cell.item.itemId]];
    // TODO compute right number
    self.progressView.progress += 0.03f;
}

- (void)cellDidUnhide:(PCKCheckItemCell *)cell
{
    [_checkedItems removeObject:[NSNumber numberWithInt:cell.item.itemId]];
    self.progressView.progress -= 0.03f;
}


@end
