#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

#define ZI_BUY_NOW_TITLE @"Buy Now"
#define ZI_MAX_WIDTH 120.0f
#define ZI_PADDING 10.0f

typedef void (^ActionBlock)();

@interface PCKBuyButton : UIButton 
{
	CAGradientLayer *innerLayer3;
	BOOL isBlued;
	ActionBlock _actionBlock;
}

-(void)setBuyBlock:(ActionBlock)action;


@end
