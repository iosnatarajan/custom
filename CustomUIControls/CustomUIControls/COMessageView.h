#import <UIKit/UIKit.h>

@interface COMessageView : UIView

@property (nonatomic) float tipHeight;

@property (nonatomic) float tipWidth;

@property (nonatomic) float shadowHeight;

@property (nonatomic) float borderWidth;

@property (nonatomic) float cornerRadius;

@property (nonatomic) float tipX;

@property (nonatomic) float tipY;

@property (nonatomic, retain) UIColor * backgroundColor, * borderColor;

@property (nonatomic, retain) UITextView * messageTextView;

@property (nonatomic) BOOL tipDown;

-(void)setTipView;

@end
