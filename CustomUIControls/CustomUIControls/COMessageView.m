#import "COMessageView.h"

@implementation COMessageView

@synthesize backgroundColor, borderColor, messageTextView = _messageTextView;

@synthesize tipHeight = _tipHeight, shadowHeight = _shadowHeight, borderWidth = _borderWidth, cornerRadius = _cornerRadius, tipX = _tipX, tipWidth = _tipWidth, tipDown = _tipDown, tipY = _tipY;

- (void)drawRect:(CGRect)rect
{
	CGRect bubbleRect = CGRectMake(0.0, (_tipDown)?_tipY + _tipHeight:0.0, rect.size.width, rect.size.height - (_shadowHeight + _tipHeight));
	
	CGContextRef c = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBStrokeColor(c, 1.0, 1.0, 1.0, 1.0);	// black
    
	CGContextSetLineWidth(c, _borderWidth);
    
	CGMutablePathRef bubblePath = CGPathCreateMutable();
    
    if (_tipDown)
    {
        CGPathMoveToPoint(bubblePath, NULL, _tipX, _tipY);
        
        CGPathAddLineToPoint(bubblePath, NULL, _tipX + (_tipWidth/2), _tipY + _tipHeight);
        
        CGPathAddArcToPoint(bubblePath, NULL,
                            bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y,
                            bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y+_cornerRadius,
                            _cornerRadius);
        
        CGPathAddArcToPoint(bubblePath, NULL,
                            bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y+bubbleRect.size.height,
                            bubbleRect.origin.x+bubbleRect.size.width-_cornerRadius, bubbleRect.origin.y+bubbleRect.size.height,
                            _cornerRadius);
        
        CGPathAddArcToPoint(bubblePath, NULL,
                            bubbleRect.origin.x, bubbleRect.origin.y+bubbleRect.size.height,
                            bubbleRect.origin.x, bubbleRect.origin.y+bubbleRect.size.height-_cornerRadius,
                            _cornerRadius);
        
        CGPathAddArcToPoint(bubblePath, NULL,
                            bubbleRect.origin.x, bubbleRect.origin.y,
                            bubbleRect.origin.x+_cornerRadius, bubbleRect.origin.y,
                            _cornerRadius);
        
        CGPathAddLineToPoint(bubblePath, NULL, _tipX - (_tipWidth/2), _tipHeight);
        
    }
    else
    {
        CGPathMoveToPoint(bubblePath, NULL, _tipX, _tipY);
        
        CGPathAddLineToPoint(bubblePath, NULL, _tipX - (_tipWidth/2), _tipY - _tipHeight);
        
        CGPathAddArcToPoint(bubblePath, NULL,
							bubbleRect.origin.x, bubbleRect.origin.y+bubbleRect.size.height,
							bubbleRect.origin.x, bubbleRect.origin.y+bubbleRect.size.height-_cornerRadius,
							_cornerRadius);
        
        CGPathAddArcToPoint(bubblePath, NULL,
							bubbleRect.origin.x, bubbleRect.origin.y,
							bubbleRect.origin.x+_cornerRadius, bubbleRect.origin.y,
							_cornerRadius);
        
		CGPathAddArcToPoint(bubblePath, NULL,
							bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y,
							bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y+_cornerRadius,
							_cornerRadius);
        
		CGPathAddArcToPoint(bubblePath, NULL,
							bubbleRect.origin.x+bubbleRect.size.width, bubbleRect.origin.y+bubbleRect.size.height,
							bubbleRect.origin.x+bubbleRect.size.width-_cornerRadius, bubbleRect.origin.y+bubbleRect.size.height,
							_cornerRadius);
        
		CGPathAddLineToPoint(bubblePath, NULL, _tipX + (_tipWidth/2), _tipY - _tipHeight);
        
    }
    
	CGPathCloseSubpath(bubblePath);
	
	// Draw shadow
    
	CGContextAddPath(c, bubblePath);
    
    CGContextSaveGState(c);
    
	CGContextSetShadow(c, CGSizeMake(0, 3), 3);
    
	CGContextSetRGBFillColor(c, 0.0, 0.0, 0.0, 0.9);
    
	CGContextFillPath(c);
    
    CGContextRestoreGState(c);
    
    // Draw clipped background gradient
    
	CGContextAddPath(c, bubblePath);
    
	CGContextClip(c);
	
	CGFloat bubbleMiddle = (bubbleRect.origin.y+(bubbleRect.size.height/2)) / self.bounds.size.height;
	
	CGGradientRef myGradient;
    
	CGColorSpaceRef myColorSpace;
    
	size_t locationCount = 5;
    
	CGFloat locationList[] = {0.0, bubbleMiddle-0.03, bubbleMiddle, bubbleMiddle+0.03, 1.0};
    
	CGFloat red;
    
	CGFloat green;
    
	CGFloat blue;
    
	CGFloat alpha;
    
	int numComponents = CGColorGetNumberOfComponents([self.backgroundColor CGColor]);
    
	const CGFloat * components = CGColorGetComponents([self.backgroundColor CGColor]);
    
	if (numComponents == 2)
    {
		red = components[0];
        
        green = components[0];
		
        blue = components[0];
        
		alpha = components[1];
	}
	else
    {
		red = components[0];
        
		green = components[1];
        
		blue = components[2];
        
		alpha = components[3];
	}
    
	CGFloat colorList[] =
    {
		//red, green, blue, alpha
		red , green, blue , alpha,
		red , green, blue , alpha,
		red , green, blue , alpha,
		red , green, blue , alpha,
		red , green, blue , alpha
	};
    
	myColorSpace = CGColorSpaceCreateDeviceRGB();
    
	myGradient = CGGradientCreateWithColorComponents(myColorSpace, colorList, locationList, locationCount);
    
	CGPoint startPoint, endPoint;
    
	startPoint.x = 0;
    
	startPoint.y = 0;
    
	endPoint.x = 0;
    
	endPoint.y = CGRectGetMaxY(self.bounds);
	
	CGContextDrawLinearGradient(c, myGradient, startPoint, endPoint,0);
    
	CGGradientRelease(myGradient);
    
	CGColorSpaceRelease(myColorSpace);
	
    //Draw Border
    int numBorderComponents = CGColorGetNumberOfComponents([borderColor CGColor]);
    
    const CGFloat * borderComponents = CGColorGetComponents(borderColor.CGColor);
    
    CGFloat r, g, b, a;
    
	if (numBorderComponents == 2)
    {
		r = borderComponents[0];
		g = borderComponents[0];
		b = borderComponents[0];
		a = borderComponents[1];
	}
	else
    {
		r = borderComponents[0];
		g = borderComponents[1];
		b = borderComponents[2];
		a = borderComponents[3];
	}
    
	CGContextSetRGBStrokeColor(c, r, g, b, a);
	CGContextAddPath(c, bubblePath);
	CGContextDrawPath(c, kCGPathStroke);
	
	CGPathRelease(bubblePath);
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Initialization code
		self.opaque = NO;
        
		self.backgroundColor = [UIColor blackColor];
        
        self.borderColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)setTipView
{
    [self setNeedsDisplay];
    
    CGRect frame = CGRectMake(2.0, (_tipDown)?_tipHeight + 2.0:2.0, self.frame.size.width - 4.0, self.frame.size.height - (_tipHeight + _shadowHeight));
    
    _messageTextView = [[UITextView alloc] initWithFrame:frame];
        
    _messageTextView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:_messageTextView];
}

- (void)dealloc
{
	backgroundColor = nil;
    
    borderColor = nil;
}

@end
