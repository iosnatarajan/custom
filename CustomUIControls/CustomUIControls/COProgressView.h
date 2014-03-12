#import <UIKit/UIKit.h>

@interface COProgressView : UIView

@property (nonatomic,retain) UIColor * progColor;

@property (nonatomic) float progress;

@property CGRect drawRect;

-(void)setProgress:(float)progress;

@end
