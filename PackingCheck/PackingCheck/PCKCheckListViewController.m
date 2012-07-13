#import "PCKCheckListViewController.h"
#import "TDBadgedCell.h"
#import "PCKCheckItemCell.h"
#import "PCKItem.h"
@interface PCKCheckListViewController(){
    NSMutableSet * _checkedItems;
    NSMutableArray* _items;
}
@end
@implementation PCKCheckListViewController
@synthesize checkList=_checkList, tableView=_tableView;


- (void) loadItems
{
    _items = [NSMutableArray array];
    for (int i=1; i<=30; i++) {
        [_items addObject:[PCKItem ItemWithId:i name:[NSString stringWithFormat:@"我的物品%d", i]]];
    }
    _checkedItems = [NSMutableSet set];
}

#pragma mark - View lifecycle

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // place any dynamic stuff you want to initialize in the child view here
    [self.navigationController setToolbarHidden:NO];    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *buttonCheck = [[ UIBarButtonItem alloc ] initWithTitle: @"开始检查" style: UIBarButtonItemStyleBordered target:self action: nil ];
    UIBarButtonItem *buttonManage = [[ UIBarButtonItem alloc ] initWithTitle: @"管理清单" style: UIBarButtonItemStyleBordered target:self action: nil ];
    NSArray *toolBarItems = [[NSArray alloc] initWithObjects:buttonCheck, buttonManage, nil];
    self.toolbarItems = toolBarItems;
    
    self.title = self.checkList.name;
    CGRect tvFrame = self.view.bounds;
    
    tvFrame.size = CGSizeMake(tvFrame.size.width, tvFrame.size.height - 80);
    self.tableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
//    self.tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableView];
    [self loadItems];


}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
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
}

- (void)cellDidUnhide:(PCKCheckItemCell *)cell
{
    [_checkedItems removeObject:[NSNumber numberWithInt:cell.item.itemId]];
}


@end
