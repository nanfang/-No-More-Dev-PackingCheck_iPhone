#import "PCKCheckListViewController.h"
#import "TDBadgedCell.h"
#import "PCKCheckItemCell.h"
@interface PCKCheckListViewController(){
    NSSet * _checkedItems;
    NSMutableArray* _items;
}
@end
@implementation PCKCheckListViewController
@synthesize checkList=_checkList, tableView=_tableView;

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
    self.tableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.tableView];
    _items = [NSMutableArray array];
    for (int i=1; i<=30; i++) {
        [_items addObject:[NSString stringWithFormat:@"物品%d", i]];
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"PCKCheckListCell";
    
    PCKCheckItemCell *cell = (PCKCheckItemCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[PCKCheckItemCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = [UIFont systemFontOfSize: 18];
        cell.swipeDirection = PCKSlidingTableViewCellSwipeRight;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentView.backgroundColor = [UIColor whiteColor];
        cell.eventHandler = ^(PCKEventType eventType, BOOL backgroundRevealed, PCKSlidingTableViewCellSwipe swipeDirection) {
            if (eventType == PCKEventTypeDidOccurr) {
//                NSLog(@"1");
            }else if (eventType == PCKEventTypeWillOccurr) {
//                NSLog(@"2");
            }
        };
        

    }
    NSString * item = [_items objectAtIndex:indexPath.row];
    cell.textLabel.text = item;
    return cell;

}

@end
