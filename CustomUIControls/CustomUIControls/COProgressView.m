#import "COProgressView.h"

@implementation COProgressView

@synthesize progColor,drawRect,progress;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) 
    {
        // Initialization code
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
    CGContextSetFillColorWithColor(UIGraphicsGetCurrentContext(), self.progColor.CGColor);
    
    CGContextFillRect(UIGraphicsGetCurrentContext(), self.drawRect);
 
}

@end
