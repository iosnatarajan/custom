#import <UIKit/UIKit.h>

typedef enum
{
    custom_Switch,
    
    custom_TipView,
    
    custom_ProgressView,
    
    custom_Slider,
    
}CustomControllerType;

#import "COProgressView.h"

@interface CustomController : UIViewController
{
    COProgressView * prog;
}

@property (nonatomic) CustomControllerType type;

@property (nonatomic, retain) NSString * controlName;

@end
