#import <UIKit/UIKit.h>

@class PCKCheckItemCell;

typedef enum {
	PCKCheckItemCellDirectionRight = 0,
	PCKCheckItemCellDirectionLeft,
	PCKCheckItemCellDirectionBoth,
	PCKCheckItemCellDirectionNone,
} PCKCheckItemCellDirection;

@protocol PCKCheckItemCellSlideDelegate <NSObject>

@optional
- (void)cellDidHide:(PCKCheckItemCell *)cell;
- (void)cellDidUnhide:(PCKCheckItemCell *)cell;
@end

@interface PCKCheckItemCell : UITableViewCell


@property BOOL hide;
@property (weak) id <PCKCheckItemCellSlideDelegate> delegate;
@property (nonatomic, assign) PCKCheckItemCellDirection direction;
@property BOOL shouldBounce;

@end
