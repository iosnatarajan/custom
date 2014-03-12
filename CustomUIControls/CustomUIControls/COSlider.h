#import <UIKit/UIKit.h>

typedef enum
{
    sliderTypeHorizontal = 0,
    sliderTypeVertical
}SliderType;

@interface COSlider : UIView
{
    @private
    
    UIImageView * sliderView;
    
    float bPoint, ePoint;
}

@property (nonatomic,retain) UIColor * indicatorColor;

@property (nonatomic,retain) UIColor * indicatorBackgroundColor;

@property (nonatomic) float value;

@property (nonatomic) float slideWidth;

@property (nonatomic) float slideHeight;

@property (nonatomic) float minValue;

@property (nonatomic) float maxValue;

@property (nonatomic) SliderType type;

@property CGRect drawRect;

@end
