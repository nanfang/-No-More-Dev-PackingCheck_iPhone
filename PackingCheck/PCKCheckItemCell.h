#import <UIKit/UIKit.h>

enum {
    PCKSlidingTableViewCellSwipeRight        = UISwipeGestureRecognizerDirectionRight,   // Reveal backgroundView only with a right swipe
    PCKSlidingTableViewCellSwipeLeft         = UISwipeGestureRecognizerDirectionLeft,    // Reveal backgroundView only with a left swipe
    PCKSlidingTableViewCellSwipeBoth         = -1,                                       // Reveal backgroundView is allowed both with right and left swipe
    PCKSlidingTableViewCellSwipeNone         = -2                                        // Reveal is not active
}; typedef NSInteger PCKSlidingTableViewCellSwipe;

enum {
    PCKEventTypeWillOccurr   = 0,            // Posted event will occour
    PCKEventTypeDidOccurr    = 1             // Posted event just occurred
}; typedef NSUInteger PCKEventType;

typedef void (^PCKSlidingTableViewCellEventHandler)(PCKEventType eventType, BOOL backgroundRevealed, PCKSlidingTableViewCellSwipe swipeDirection);

@interface PCKCheckItemCell : UITableViewCell {
    
}

@property (copy)                PCKSlidingTableViewCellEventHandler          eventHandler;                   // Event delegate handler via blocks
@property (nonatomic,assign)    PCKSlidingTableViewCellSwipe                 swipeDirection;                 // Allowed swipe-to-reveal direction

@property (readonly)            PCKSlidingTableViewCellSwipe                 lastSwipeDirectionOccurred;     // Last swipe occurred
@property (nonatomic,readonly)  BOOL                                        backgroundIsRevealed;           // YES if backgroundView is visible

// Reveal or hide backgroundView
- (void) setBackgroundVisible:(BOOL) revealBackgroundView;

// Toggle backgroundView visibility by animating cell top view to set direction (works even if it's not allowed to swipeDirection, so be careful)
- (BOOL) toggleCellStatus;
- (void) showBackground;
@end
