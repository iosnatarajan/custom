#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface COSwitch : UIView
{
    UIView * sView;
    
    UILabel * onView;
    
    UILabel * offView;
    
    UIButton * toggBut;
    
    float bX, eX;
    
    BOOL isDragging;
    
    NSTimeInterval touchStartTime;
    
    SEL selector;
}

@property (nonatomic) BOOL isOn;

@property (nonatomic, retain) id target;

-(BOOL)isOn;

-(void)setIsOn:(BOOL)isOn;

-(void)setSwitchView;

-(void)addTarget:(id)target selector:(SEL)selector;

@end
