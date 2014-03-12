#import "COSwitch.h"

#define TOUCH_DURATION      0.5

@implementation COSwitch

@synthesize isOn = _isOn;

@synthesize target = _target;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _isOn = YES;
        
        self.backgroundColor = [UIColor clearColor];
        
        self.layer.masksToBounds = YES;
        
        self.layer.cornerRadius = self.frame.size.height / 2;
        
        sView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width * 2, self.frame.size.height)];
        
        sView.backgroundColor = [UIColor clearColor];
        
        onView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, self.frame.size.width, self.frame.size.height)];
        
        onView.backgroundColor = [UIColor redColor];
        
        onView.layer.masksToBounds = YES;
        
        onView.layer.cornerRadius = onView.frame.size.height / 2;
        
        onView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        onView.layer.borderWidth = 1.0;
        
        onView.textAlignment = NSTextAlignmentCenter;
        
        onView.text = @"SHOW";
        
        offView = [[UILabel alloc] initWithFrame:CGRectMake(onView.frame.size.width, 0.0, self.frame.size.width, self.frame.size.height)];
        
        offView.backgroundColor = [UIColor whiteColor];
        
        offView.text = @"HIDE";
        
        offView.textAlignment = NSTextAlignmentCenter;
        
        offView.layer.masksToBounds = YES;
        
        offView.layer.cornerRadius = offView.frame.size.height / 2;
        
        offView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        
        offView.layer.borderWidth = 1.0;
        
        [sView addSubview:onView];
        
        [sView addSubview:offView];
        
        [self addSubview:sView];
    }
    
    return self;
}

-(void)addTarget:(id)target selector:(SEL)select
{
    selector = select;
    
    _target = target;
}

-(BOOL)isOn
{
    return _isOn;
}

-(void)setIsOn:(BOOL)isOn
{
    _isOn = isOn;
    
    [self setSwitchView];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    touchStartTime = [event timestamp];
    
    UITouch * touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:sView];
    
    bX = touchLocation.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{    
    isDragging = YES;
    
    UITouch * touch = [touches anyObject];
    
    CGPoint touchLocation = [touch locationInView:sView];
    
    eX = touchLocation.x;
    
    if ([touch.view isEqual:sView])
    {
        CGRect frame = sView.frame;
        
        frame.origin.x =  frame.origin.x + (eX - bX);
        
        if (frame.origin.x >= -sView.frame.size.width/2 && frame.origin.x <= 0)
            sView.frame = frame;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSTimeInterval touchTimeDuration = [event timestamp] - touchStartTime;
    
    UITouch * touch = [touches anyObject];
    
    if ([touch.view isEqual:sView])
    {
        if (!isDragging || (touchTimeDuration < TOUCH_DURATION && _isOn && sView.frame.origin.x != 0.0) || (touchTimeDuration < TOUCH_DURATION && !_isOn && sView.frame.origin.x != -sView.frame.size.width/2))
        {
            _isOn = !_isOn;
            
            [self setSwitchView];
            
            return;
        }
        
        _isOn = (sView.frame.origin.x < -sView.frame.size.width/4)?NO:YES;
        
        [self setSwitchView];
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
    
    NSTimeInterval touchTimeDuration = [event timestamp] - touchStartTime;
    
    UITouch * touch = [touches anyObject];
    
    if ([touch.view isEqual:sView])
    {
        if (!isDragging || (touchTimeDuration < TOUCH_DURATION && _isOn && sView.frame.origin.x != 0.0) || (touchTimeDuration < TOUCH_DURATION && !_isOn && sView.frame.origin.x != -sView.frame.size.width/2))
        {
            _isOn = !_isOn;
            
            [self setSwitchView];
            
            return;
        }
        
        _isOn = (sView.frame.origin.x < -sView.frame.size.width/4)?NO:YES;
        
        [self setSwitchView];
    }
}

-(void)setSwitchView
{
    isDragging = NO;

    void (^nextOpen)(void);
    
    nextOpen = ^(void)
    {
        sView.frame = (_isOn)?CGRectMake(0.0, 0.0, sView.frame.size.width, sView.frame.size.height):CGRectMake(-sView.frame.size.width/2, 0.0, sView.frame.size.width, sView.frame.size.height);
    };
    
    void (^completed)(BOOL finished);
    
#pragma clang diagnostic push
    
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    
    completed = ^(BOOL finished)
    {
        if ([_target respondsToSelector:selector])
            [_target performSelector:selector withObject:self];
    };

#pragma clang diagnostic pop
        
    [UIView  animateWithDuration:0.2 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:nextOpen completion:completed];
}

@end
