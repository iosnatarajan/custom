#import "COProgressView.h"

@implementation COProgressView

@synthesize progColor,drawRect,progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
        
        self.clipsToBounds = YES;
        
        self.layer.cornerRadius = frame.size.height/2;
        
        self.layer.borderColor = [UIColor whiteColor].CGColor;
        
        self.layer.borderWidth = 0.5;
    }
    
    return self;
}

-(float)progress
{
    return progress;
}

-(void)setProgress:(float)prog
{    
    progress = prog;
        
    float curr = prog * self.bounds.size.width;
        
    self.drawRect =  CGRectMake(0.0, 0.0, curr, self.bounds.size.height);        
    
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), self.backgroundColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), rect);

    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), self.progColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), self.drawRect);
 
}

@end
