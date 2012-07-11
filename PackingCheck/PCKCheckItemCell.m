#import "PCKCheckItemCell.h"
#import <QuartzCore/QuartzCore.h>

@interface PCKCheckItemCell ()

@property (nonatomic, retain) UIPanGestureRecognizer   *_panGesture;
@property (nonatomic, assign) CGFloat _initialTouchPositionX;
@property (nonatomic, assign) CGFloat _initialHorizontalCenter;
@property (nonatomic, assign) PCKCheckItemCellDirection _lastDirection;
@property (nonatomic, assign) PCKCheckItemCellDirection _currentDirection;

- (void)_slideInContentViewFromDirection:(PCKCheckItemCellDirection)direction offsetMultiplier:(CGFloat)multiplier;
- (void)_slideOutContentViewInDirection:(PCKCheckItemCellDirection)direction;

- (void)_pan:(UIPanGestureRecognizer *)panGesture;


- (CGFloat)_originalCenter;
- (CGFloat)_bounceMultiplier;

- (BOOL)_shouldDragLeft;
- (BOOL)_shouldDragRight;

@end

@implementation PCKCheckItemCell

#pragma mark - Private Properties

@synthesize _panGesture;
@synthesize _initialTouchPositionX;
@synthesize _initialHorizontalCenter;
@synthesize _lastDirection;
@synthesize _currentDirection;

#pragma mark - Public Properties
@synthesize hide = _hide;
@synthesize direction    = _direction;
@synthesize delegate     = _delegate;
@synthesize shouldBounce = _shouldBounce;

#pragma badge
@synthesize badgeString=_badgeString, badge=_badge, badgeColor=_badgeColor, badgeColorHighlighted=_badgeColorHighlighted, showShadow=_showShadow;

#pragma mark - Lifecycle
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.direction = PCKCheckItemCellDirectionBoth;
		self.shouldBounce = YES;
		
		self._panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(_pan:)] ;
		self._panGesture.delegate = self;
		
		[self addGestureRecognizer:self._panGesture];
		
		self.contentView.backgroundColor = [UIColor whiteColor];
		
		UIView *backgroundView         = [[UIView alloc] initWithFrame:self.contentView.frame] ;
		backgroundView.backgroundColor = [UIColor greenColor];
		self.backgroundView                  = backgroundView;
        
        self.badge = [[TDBadgeView alloc] initWithFrame:CGRectZero];
        self.badge.parent = self;
        
        [self.contentView addSubview:self.badge];
    }
    return self;
}


- (void)layoutSubviews
{
	[super layoutSubviews];	
    
	if(self.badgeString)
	{
        
		//force badges to hide on edit.
		if(self.editing)
			[self.badge setHidden:YES];
		else
			[self.badge setHidden:NO];
		
		
		CGSize badgeSize = [self.badgeString sizeWithFont:[UIFont boldSystemFontOfSize: 11]];
		CGRect badgeframe = CGRectMake(self.contentView.frame.size.width - (badgeSize.width + 25),
                                       (CGFloat)round((self.contentView.frame.size.height - 18) / 2),
                                       badgeSize.width + 13,
                                       18);
		
        if(self.showShadow)
            [self.badge setShowShadow:YES];
        else
            [self.badge setShowShadow:NO];
        
		[self.badge setFrame:badgeframe];
		[self.badge setBadgeString:self.badgeString];
		
		if ((self.textLabel.frame.origin.x + self.textLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.textLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.textLabel.frame = CGRectMake(self.textLabel.frame.origin.x, self.textLabel.frame.origin.y, badgeWidth, self.textLabel.frame.size.height);
		}
		
		if ((self.detailTextLabel.frame.origin.x + self.detailTextLabel.frame.size.width) >= badgeframe.origin.x)
		{
			CGFloat badgeWidth = self.detailTextLabel.frame.size.width - badgeframe.size.width - 10.0f;
			
			self.detailTextLabel.frame = CGRectMake(self.detailTextLabel.frame.origin.x, self.detailTextLabel.frame.origin.y, badgeWidth, self.detailTextLabel.frame.size.height);
		}
        
		//set badge highlighted colours or use defaults
		if(self.badgeColorHighlighted)
			self.badge.badgeColorHighlighted = self.badgeColorHighlighted;
		else 
			self.badge.badgeColorHighlighted = [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.000f];
		
		//set badge colours or impose defaults
		if(self.badgeColor)
			self.badge.badgeColor = self.badgeColor;
		else
			self.badge.badgeColor = [UIColor colorWithRed:0.530f green:0.600f blue:0.738f alpha:1.000f];
        [self.badge setNeedsDisplay];
	}
	else{
		[self.badge setHidden:YES];
	}

    
    if(self.hide){
        [self _hideOutContentViewInDirection:PCKCheckItemCellDirectionRight];
    }
}


#pragma mark - Handing Touch

#define kMinimumVelocity self.contentView.frame.size.width
#define kMinimumPan      60.0

- (void)_pan:(UIPanGestureRecognizer *)recognizer
{
	
	CGPoint translation           = [recognizer translationInView:self];
	CGPoint currentTouchPoint     = [recognizer locationInView:self];
	CGPoint velocity              = [recognizer velocityInView:self];
	
	CGFloat originalCenter        = self._originalCenter;
	CGFloat currentTouchPositionX = currentTouchPoint.x;
	CGFloat panAmount             = self._initialTouchPositionX - currentTouchPositionX;
	CGFloat newCenterPosition     = self._initialHorizontalCenter - panAmount;
	CGFloat centerX               = self.contentView.center.x;
	
	if (recognizer.state == UIGestureRecognizerStateBegan) {
		
		// Set a baseline for the panning
		self._initialTouchPositionX = currentTouchPositionX;
		self._initialHorizontalCenter = self.contentView.center.x;
				
	} else if (recognizer.state == UIGestureRecognizerStateChanged) {
		
		// If the pan amount is negative, then the last direction is left, and vice versa.
		if (newCenterPosition - centerX < 0)
			self._lastDirection = PCKCheckItemCellDirectionLeft;
		else
			self._lastDirection = PCKCheckItemCellDirectionRight;
		
		// Don't let you drag past a certain point depending on direction
		if ((newCenterPosition < originalCenter && !self._shouldDragLeft) || (newCenterPosition > originalCenter && !self._shouldDragRight))
			newCenterPosition = originalCenter;
		
		// Let's not go waaay out of bounds
		if (newCenterPosition > self.bounds.size.width + originalCenter)
			newCenterPosition = self.bounds.size.width + originalCenter;
		
		else if (newCenterPosition < -originalCenter)
			newCenterPosition = -originalCenter;
		
		CGPoint center = self.contentView.center;
		center.x = newCenterPosition;
		
		self.contentView.layer.position = center;
		
	} else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
				
		// Swiping left, velocity is below 0.
		// Swiping right, it is above 0
		// If the velocity is above the width in points per second at any point in the pan, push it to the acceptable side
		// Otherwise, if we are 60 points in, push to the other side
		// If we are < 60 points in, bounce back
		
		CGFloat velocityX = velocity.x;
		
		BOOL push = (velocityX < -kMinimumVelocity);
		push |= (velocityX > kMinimumVelocity);
		push |= ((self._lastDirection == PCKCheckItemCellDirectionLeft && translation.x < -kMinimumPan) || (self._lastDirection == PCKCheckItemCellDirectionRight && translation.x > kMinimumPan));
	
		push &= ((self._lastDirection == PCKCheckItemCellDirectionRight && self._shouldDragRight) || (self._lastDirection == PCKCheckItemCellDirectionLeft && self._shouldDragLeft)); 
		
		if (velocityX > 0 && self._lastDirection == PCKCheckItemCellDirectionLeft)
			push = NO;
		
		else if (velocityX < 0 && self._lastDirection == PCKCheckItemCellDirectionRight)
			push = NO;
		
		if (push && !self.hide) {
			
			[self _slideOutContentViewInDirection:self._lastDirection];
			
			
		} else if (self.hide && translation.x != 0) {
			CGFloat multiplier = self._bounceMultiplier;
			if (!self.hide)
				multiplier *= -1.0;
				
			[self _slideInContentViewFromDirection:self._currentDirection offsetMultiplier:multiplier];
			
			
		} else if (translation.x != 0) {
			// Figure out which side we've dragged on.
			PCKCheckItemCellDirection finalDir = PCKCheckItemCellDirectionRight;
			if (translation.x < 0)
				finalDir = PCKCheckItemCellDirectionLeft;
		
			[self _slideInContentViewFromDirection:finalDir offsetMultiplier:-1.0 * self._bounceMultiplier];
			
		}
	}
}

- (BOOL)_shouldDragLeft
{
	return (self.direction == PCKCheckItemCellDirectionBoth || self.direction == PCKCheckItemCellDirectionLeft);
}

- (BOOL)_shouldDragRight
{
	return (self.direction == PCKCheckItemCellDirectionBoth || self.direction == PCKCheckItemCellDirectionRight);
}

- (CGFloat)_originalCenter
{
	return ceil(self.bounds.size.width / 2);
}

- (CGFloat)_bounceMultiplier
{
	return self.shouldBounce ? MIN(ABS(self._originalCenter - self.contentView.center.x) / kMinimumPan, 1.0) : 0.0;
}

#pragma mark - Sliding
#define kBOUNCE_DISTANCE 20.0

- (void)_slideInContentViewFromDirection:(PCKCheckItemCellDirection)direction offsetMultiplier:(CGFloat)multiplier
{
	CGFloat bounceDistance;
	
	if (self.contentView.center.x == self._originalCenter)
		return;
	
	switch (direction) {
		case PCKCheckItemCellDirectionRight:
			bounceDistance = kBOUNCE_DISTANCE * multiplier;
			break;
		case PCKCheckItemCellDirectionLeft:
			bounceDistance = -kBOUNCE_DISTANCE * multiplier;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	
	[UIView animateWithDuration:0.1
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut|UIViewAnimationOptionAllowUserInteraction 
					 animations:^{ self.contentView.center = CGPointMake(self._originalCenter, self.contentView.center.y); } 
					 completion:^(BOOL f) {
						 						 
						 [UIView animateWithDuration:0.1 delay:0 
											 options:UIViewAnimationCurveLinear
										  animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, bounceDistance, 0); } 
										  completion:^(BOOL f) {                     
											  
												  [UIView animateWithDuration:0.1 delay:0 
																	  options:UIViewAnimationCurveLinear
																   animations:^{ self.contentView.frame = CGRectOffset(self.contentView.frame, -bounceDistance, 0); } 
																   completion:NULL];
										  }
						  ]; 
					 }];
    self.hide = NO;
    if ([self.delegate respondsToSelector:@selector(cellDidUnhide:)]){
        [self.delegate cellDidUnhide:self];        
    }

}

- (void)_slideOutContentViewInDirection:(PCKCheckItemCellDirection)direction;
{
	CGFloat x;
	
	switch (direction) {
		case PCKCheckItemCellDirectionLeft:
			x = - self._originalCenter;
			break;
		case PCKCheckItemCellDirectionRight:
			x = self.contentView.frame.size.width + self._originalCenter;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	
	[UIView animateWithDuration:0.2 
						  delay:0 
						options:UIViewAnimationOptionCurveEaseOut 
					 animations:^{ self.contentView.center = CGPointMake(x, self.contentView.center.y); } 
					 completion:NULL];
    self.hide = YES;
    self._currentDirection = direction;
    if ([self.delegate respondsToSelector:@selector(cellDidHide:)]){
        [self.delegate cellDidHide:self];        
    }
}

- (void)_hideOutContentViewInDirection:(PCKCheckItemCellDirection)direction;
{
	CGFloat x;
	switch (direction) {
		case PCKCheckItemCellDirectionLeft:
			x = - self._originalCenter;
			break;
		case PCKCheckItemCellDirectionRight:
			x = self.contentView.frame.size.width + self._originalCenter;
			break;
		default:
			@throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unhandled gesture direction" userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:direction] forKey:@"direction"]];
			break;
	}
	self.contentView.center = CGPointMake(x, self.contentView.center.y);
    self._currentDirection = direction;
    self._lastDirection = direction;

}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	if (gestureRecognizer == self._panGesture) {
		UIScrollView *superview = (UIScrollView *)self.superview;
		CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:superview];
		
		// Make sure it is scrolling horizontally
		return ((fabs(translation.x) / fabs(translation.y) > 1) ? YES : NO && (superview.contentOffset.y == 0.0 && superview.contentOffset.x == 0.0));
	}
	return NO;
}

@end
