#import <UIKit/UIKit.h>
#import "SEViewController.h"
#import "PCKCheckList.h"
#import "PCKCheckItemCell.h"
#import "DACircularProgressView.h"

@interface PCKCheckListViewController : SEViewController<UITableViewDataSource, UITableViewDelegate, PCKCheckItemCellSlideDelegate> { 
}

- (void)increaseOpens;
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) PCKCheckList* checkList;
@property(strong, nonatomic) DACircularProgressView* progressView;
@end
