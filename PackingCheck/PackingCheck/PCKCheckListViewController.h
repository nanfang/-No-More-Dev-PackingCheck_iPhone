#import <UIKit/UIKit.h>
#import "SEViewController.h"
#import "PCKCheckList.h"
#import "PCKCheckItemCell.h"

@interface PCKCheckListViewController : SEViewController<UITableViewDataSource, UITableViewDelegate, PCKCheckItemCellSlideDelegate> { 
    
}
@property(strong, nonatomic) UITableView *tableView;
@property(strong, nonatomic) PCKCheckList* checkList;

@end
