#import "COSlider.h"

@implementation COSlider

@synthesize indicatorColor = _indicatorColor, drawRect = _drawRect, value = _value, minValue = _minValue, maxValue = _maxValue, type = _type;

@synthesize slideHeight = _slideHeight, slideWidth = _slideWidth;

@synthesize indicatorBackgroundColor = _indicatorBackgroundColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        // Initialization code
        
        sliderView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, frame.size.height - ((frame.size.width > frame.size.height)?frame.size.height:frame.size.width), (frame.size.width > frame.size.height)?frame.size.height:frame.size.width, (frame.size.width > frame.size.height)?frame.size.height:frame.size.width)];
        
        sliderView.userInteractionEnabled = YES;
        
        sliderView.clipsToBounds = YES;
        
        sliderView.layer.borderWidth = 0.2;
        
        sliderView.layer.borderColor = [UIColor darkGrayColor].CGColor;
        
        sliderView.backgroundColor = [UIColor greenColor];
        
        UIPanGestureRecognizer *panGestureImg = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetectedSlider:)];
        
        [sliderView addGestureRecognizer:panGestureImg];
        
        panGestureImg = nil;
        
        [self addSubview:sliderView];
        
        _indicatorColor = [UIColor redColor];
        
        self.backgroundColor = [UIColor clearColor];

        _indicatorBackgroundColor = [UIColor grayColor];

        _minValue = 0.0;
        
        _maxValue = 10.0;
        
        _slideHeight = frame.size.height;
        
        _slideWidth = 20;
        
        _type = sliderTypeHorizontal;
        
        [self setType:_type];
        
        [self setValue:0.0];
    }
    
    return self;
}

-(void)setType:(SliderType)type
{
    SliderType prevType = _type;
    
    _type = type;
    
    if (prevType == _type)
        return;
    
    [self setValue:_value];
}

-(float)value
{
    return _value;
}

-(void)setValue:(float)value
{
    _value = value;
        
    if (_type == sliderTypeHorizontal)
    {
        float witdh = (_value/(_maxValue - _minValue)) * self.bounds.size.width;
        
        _drawRect =  CGRectMake(0.0, 5.0, witdh, _slideHeight);
        
        sliderView.layer.cornerRadius = sliderView.frame.size.height/2;

    }
    else if (_type == sliderTypeVertical)
    {
        float height = ((_value/(_maxValue - _minValue)) * self.bounds.size.height);
        
        _drawRect =  CGRectMake(5.0, self.bounds.size.height - height, _slideWidth, height);
        
        sliderView.layer.cornerRadius = sliderView.frame.size.width/2;
    }
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(),self.backgroundColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);
    
    CGRect backRect = _drawRect;

    backRect.origin.y = 0.0;
    
    backRect.size.height = rect.size.height;
    
    UIBezierPath * clip3 = [UIBezierPath bezierPathWithRoundedRect:backRect cornerRadius:10.0];
    
    [clip3 addClip];
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _indicatorBackgroundColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), backRect);
    
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), _indicatorColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), _drawRect);    
}

-(void)panDetectedSlider:(UIPanGestureRecognizer *)panRecognizer
{
    if ([panRecognizer state] == UIGestureRecognizerStateBegan)
    {
        //Start
    }
    else if([panRecognizer state] == UIGestureRecognizerStateChanged)
    {
        //Change
        CGPoint translation = [panRecognizer translationInView:self];
                
        CGPoint imageViewPosition = sliderView.center;
        
        imageViewPosition.y += translation.y;
        
        NSLog(@"imageViewPosition :%@", NSStringFromCGPoint(imageViewPosition));

        if (imageViewPosition.y >= 0 && imageViewPosition.y <= self.frame.size.height - 10)
        {            
            sliderView.center = imageViewPosition;
                        
            [panRecognizer setTranslation:CGPointZero inView:self];
        }
        
        if (_type == sliderTypeHorizontal)
        {
            [self setValue:(sliderView.center.x/self.bounds.size.width) * (_maxValue - _minValue)];
        }
        else
        {
            [self setValue:((self.frame.size.height - sliderView.center.y)/self.bounds.size.height) * (_maxValue - _minValue)];
        }

     }
    else if([panRecognizer state] == UIGestureRecognizerStateCancelled || [panRecognizer state] == UIGestureRecognizerStateFailed || [panRecognizer state] == UIGestureRecognizerStateEnded)
    {
        //End
    }
}

/*

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{    
    UITouch * touch = [touches anyObject];
    
    if ([touch.view isEqual:sliderView])
    {
        CGPoint touchLocation = [touch locationInView:self];

        CGPoint touchLocation1 = [touch locationInView:sliderView];
        
        ePoint = (_type == sliderTypeHorizontal)?touchLocation.x:touchLocation.y;
                
        if ((ePoint >= 0 && (_type == sliderTypeHorizontal && ePoint <= (self.bounds.size.width - sliderView.frame.size.width - touchLocation1.x))) || (ePoint >= 0 && (_type == sliderTypeVertical && ePoint <= (self.bounds.size.height - sliderView.frame.size.height))))
        {
            CGRect frame = sliderView.frame;
            
            if (_type == sliderTypeHorizontal)
            {
                frame.origin.x = ePoint;
                
                [self setValue:(ePoint/self.bounds.size.width) * (_maxValue - _minValue)];
            }
            else
            {
                frame.origin.y = ePoint;
                
                [self setValue:((self.bounds.size.height - ePoint)/self.bounds.size.height) * (_maxValue - _minValue)];
            }
            
            sliderView.frame = frame;
        }
    }
}
 
 */

@end
