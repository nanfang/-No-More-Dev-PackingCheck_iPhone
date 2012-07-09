#import "PCKCheckItemCell.h"

#define kPCKSlidingCellBounce            20.0f
#define kPCKSlidingInAnimationDuration   0.2f
#define kPCKSlidingOutAnimationDuration  0.1f

@interface PCKCheckItemCell() {
    NSMutableArray*                     associatedSwipeRecognizer;
    PCKSlidingTableViewCellSwipe         lastSwipeDirectionOccurred;
    PCKSlidingTableViewCellEventHandler  eventHandler;
    BOOL                                isAnimating;
}

- (UIGestureRecognizer *) swipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection) dir;
- (void) setOffsetForView:(UIView *) targetView offset:(CGPoint) offset;

@end

@implementation PCKCheckItemCell

@synthesize swipeDirection,lastSwipeDirectionOccurred;
@synthesize eventHandler;
@synthesize backgroundIsRevealed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        swipeDirection = PCKSlidingTableViewCellSwipeNone;
        lastSwipeDirectionOccurred = PCKSlidingTableViewCellSwipeNone;
        
        UIView *defaultBackgroundView = [[UIView alloc] initWithFrame:self.contentView.frame];
        defaultBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        defaultBackgroundView.backgroundColor = [UIColor grayColor];
        self.backgroundView = defaultBackgroundView;
        self.swipeDirection = PCKSlidingTableViewCellSwipeRight;
    }
    return self;
}

- (void) setSwipeDirection:(PCKSlidingTableViewCellSwipe)newSwipeDirection {
    if (newSwipeDirection == swipeDirection) return;
    NSArray* loadedGestures = [self gestureRecognizers];
    [loadedGestures enumerateObjectsUsingBlock:^(UIGestureRecognizer* obj, NSUInteger idx, BOOL *stop) {
        [self removeGestureRecognizer:obj];
    }];
    
    swipeDirection = newSwipeDirection;
    if (swipeDirection != PCKSlidingTableViewCellSwipeNone) {
        [self addGestureRecognizer:[self swipeGestureRecognizerWithDirection:
                                    UISwipeGestureRecognizerDirectionLeft]];
        
        [self addGestureRecognizer:[self swipeGestureRecognizerWithDirection:
                                    UISwipeGestureRecognizerDirectionRight]];
    }
}

- (UIGestureRecognizer *) swipeGestureRecognizerWithDirection:(UISwipeGestureRecognizerDirection) dir {
    UISwipeGestureRecognizer *swipeG = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleSwipeGesture:)];
    swipeG.direction = dir;
    return swipeG;
}


- (void)handleSwipeGesture:(UISwipeGestureRecognizer *) gesture {
    if (isAnimating)
        return;
    
    UISwipeGestureRecognizerDirection directionMade = gesture.direction;
    UISwipeGestureRecognizerDirection activeSwipe = self.swipeDirection;

    // If we allow both swipe direction allowed swipe used to slide out and bring back the contentView
    // is the last swipe taken: so if you swipe to the right to bring back the contentView you should
    // swipe to left, and viceversa.
    if (activeSwipe == PCKSlidingTableViewCellSwipeBoth)
        activeSwipe = lastSwipeDirectionOccurred;
    if (lastSwipeDirectionOccurred == PCKSlidingTableViewCellSwipeNone)
        lastSwipeDirectionOccurred = directionMade;
    
    // We can reveal background view only if background is not yet visible and:
    //  - swipe made = allowedSwipe
    //  - allowed swipe is PCKSlidingTableViewCellSwipeBoth
    BOOL canRevealBack = ((directionMade == activeSwipe ||
                           self.swipeDirection == PCKSlidingTableViewCellSwipeBoth)
                          && self.backgroundIsRevealed == NO);
    // You can hide backgroundView only if it's visible yet and
    // user's swipe is not the allowed (to reveal) swipe set.
    BOOL canHide = (self.backgroundIsRevealed && directionMade != activeSwipe);
    
    if (canRevealBack){
        [self setBackgroundVisible:YES];
        // save user's last swipe direction
        lastSwipeDirectionOccurred = directionMade;
    } else if (canHide) {
        [self setBackgroundVisible:NO];
        if (self.swipeDirection == PCKSlidingTableViewCellSwipeBoth)
            lastSwipeDirectionOccurred = PCKSlidingTableViewCellSwipeNone;
    }
}

- (BOOL) toggleCellStatus {
    if (lastSwipeDirectionOccurred == PCKSlidingTableViewCellSwipeNone)
        return NO;

    [self setBackgroundVisible:(self.backgroundIsRevealed ? NO : YES)];
    return YES;
}

- (BOOL) backgroundIsRevealed {
    // Return YES if cell's contentView is not visible (backgroundView is revealed)
    return (self.contentView.frame.origin.x < 0 || self.contentView.frame.origin.x >= self.contentView.frame.size.width);
}

- (void) showBackground
{
    CGFloat offset_x = -self.contentView.frame.size.width;
    [self setOffsetForView:self.contentView offset:CGPointMake(offset_x, 0.0f)];
}

- (void) setBackgroundVisible:(BOOL) revealBackgroundView {
    if (isAnimating) return;
    CGFloat offset_x = 0.0f;
    CGFloat bounce_distance = kPCKSlidingCellBounce;
    CGFloat contentViewWidth = self.contentView.frame.size.width;

    UISwipeGestureRecognizerDirection swipeMade = lastSwipeDirectionOccurred;
    if (swipeMade == UISwipeGestureRecognizerDirectionLeft) {
        offset_x = (revealBackgroundView ? -contentViewWidth : contentViewWidth);
        bounce_distance = (revealBackgroundView ? 0.0f : kPCKSlidingCellBounce);
    } else if (swipeMade == UISwipeGestureRecognizerDirectionRight) {
        offset_x = (revealBackgroundView ? contentViewWidth : - contentViewWidth);
        bounce_distance = (revealBackgroundView ? 0.0f : -kPCKSlidingCellBounce);
    }
    
    if (eventHandler)
        eventHandler(PCKEventTypeWillOccurr,revealBackgroundView,lastSwipeDirectionOccurred);
    
    isAnimating = YES;
    if (revealBackgroundView) {
        [UIView animateWithDuration:kPCKSlidingInAnimationDuration
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             [self setOffsetForView:self.contentView offset:CGPointMake(offset_x, 0.0f)];
                         } completion:^(BOOL finished) {
                             if (finished) {
                                 isAnimating = NO;
                                 if (eventHandler)
                                     eventHandler(PCKEventTypeDidOccurr,revealBackgroundView,lastSwipeDirectionOccurred);
                             }
                             
                         }];
    } else {
        [UIView animateWithDuration:kPCKSlidingOutAnimationDuration
                              delay:0.0f
                            options:(UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             [self setOffsetForView:self.contentView offset:CGPointMake(offset_x, 0.0f)];
                         } completion:^(BOOL finished) {
                            [UIView animateWithDuration:kPCKSlidingOutAnimationDuration
                                                  delay:0
                                                options:UIViewAnimationCurveLinear
                                             animations:^{
                                                 [self setOffsetForView:self.contentView
                                                                    offset:CGPointMake(bounce_distance, 0.0f)];
                                             } completion:^(BOOL finished) {
                                                 [UIView animateWithDuration:kPCKSlidingOutAnimationDuration
                                                                       delay:0.0f
                                                                     options:UIViewAnimationCurveLinear
                                                                  animations:^{
                                                                       
                                                                   } completion:^(BOOL finished) {
                                                                       [self setOffsetForView:self.contentView
                                                                                       offset:CGPointMake(-bounce_distance, 0.0f)];
                                                                       
                                                                        if (eventHandler)
                                                                            eventHandler(PCKEventTypeDidOccurr,revealBackgroundView,lastSwipeDirectionOccurred);
                                                                     
                                                                       if (finished)
                                                                           isAnimating = NO;
                                                                   }];
                                              }];
                         }];
    }
}

- (void) setOffsetForView:(UIView *) targetView offset:(CGPoint) offset {
    targetView.frame = CGRectOffset(targetView.frame, offset.x, offset.y);
}
- (void)layoutSubviews
{
	[super layoutSubviews];
//    [self showBackground];
}

@end
