#import <UIKit/UIKit.h>

@interface COTipView : UIView

@property (nonatomic) float tipHeight;

@property (nonatomic) float tipWidth;

@property (nonatomic) float shadowHeight;

@property (nonatomic) float borderWidth;

@property (nonatomic) float cornerRadius;

@property (nonatomic) float tipX;

@property (nonatomic) float tipY;

@property (nonatomic) float leftPadding;

@property (nonatomic) float rightPadding;

@property (nonatomic) float topPadding;

@property (nonatomic) float bottomPadding;

@property (nonatomic, retain) UIColor * backgroundColor, * borderColor;

@property (nonatomic, retain) UILabel * tipLabel;

@property (nonatomic) BOOL tipDown;

-(void)updateTipView;

-(void)setText:(NSString *)text;

@end
