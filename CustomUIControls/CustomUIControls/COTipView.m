#import "COTipView.h"

@implementation COTipView

@synthesize backgroundColor = _backgroundColor, borderColor = _borderColor, tipLabel = _tipLabel;

@synthesize tipHeight = _tipHeight, shadowHeight = _shadowHeight, borderWidth = _borderWidth, cornerRadius = _cornerRadius, tipX = _tipX, tipWidth = _tipWidth, tipDown = _tipDown, tipY = _tipY, topPadding = _topPadding, bottomPadding = _bottomPadding, leftPadding = _leftPadding, rightPadding = _rightPadding;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        // Initialization code
        
		self.opaque = NO;
        
        _leftPadding = _rightPadding = _topPadding = _bottomPadding = 2.0;
        
        _tipHeight = _tipWidth = 10.0;
        
        _shadowHeight = 3.0;
        
        _tipX = 10.0;
        
        _tipY = 0.0;
        
        _borderWidth = 1.0;
        
        _cornerRadius = 5.0;
        
        _tipDown = YES;
        
		_backgroundColor = [UIColor blackColor];
        
        _borderColor = [UIColor whiteColor];
        
        _tipLabel = [[UILabel alloc] init];
        
        _tipLabel.textColor = [UIColor whiteColor];
                
        _tipLabel.backgroundColor = [UIColor clearColor];
        
        _tipLabel.numberOfLines = 0;
        
        [self addSubview:_tipLabel];
        
        [self updateTipView];
    }
    
    return self;
}

-(void)setTipHeight:(float)tipHeight
{
    _tipHeight = tipHeight;
    
    [self updateTipView];
}

-(void)setTipWidth:(float)tipWidth
{
    _tipWidth = tipWidth;
    
    [self updateTipView];
}

-(void)setShadowHeight:(float)shadowHeight
{
    _shadowHeight = shadowHeight;
    
    [self updateTipView];
}

-(void)setTipDown:(BOOL)tipDown
{
    _tipDown = tipDown;
    
    [self updateTipView];
}

-(void)setTipX:(float)tipX
{
    _tipX = tipX;
    
    [self updateTipView];
}

-(void)setTipY:(float)tipY
{
    _tipY = tipY;
    
    [self updateTipView];
}

-(void)setTopPadding:(float)topPadding
{
    _topPadding = topPadding;
    
    [self updateTipView];
}

-(void)setBottomPadding:(float)bottomPadding
{
    _bottomPadding = bottomPadding;
    
    [self updateTipView];
}

-(void)setLeftPadding:(float)leftPadding
{
    _leftPadding = leftPadding;
    
    [self updateTipView];
}

-(void)setRightPadding:(float)rightPadding
{
    _rightPadding = rightPadding;
    
    [self updateTipView];
}

-(void)setBorderWidth:(float)borderWidth
{
    _borderWidth = borderWidth;
    
    [self updateTipView];
}

-(void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    
    [self updateTipView];
}

-(void)setCornerRadius:(float)cornerRadius
{
    _cornerRadius = cornerRadius;
    
    [self updateTipView];
}

-(void)setBackgroundColor:(UIColor *)backgroundColor
{
    _backgroundColor = backgroundColor;
    
    [self updateTipView];
}

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
    
	int numComponents = CGColorGetNumberOfComponents([_backgroundColor CGColor]);
    
	const CGFloat * components = CGColorGetComponents([_backgroundColor CGColor]);
    
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
    int numBorderComponents = CGColorGetNumberOfComponents([_borderColor CGColor]);
    
    const CGFloat * borderComponents = CGColorGetComponents(_borderColor.CGColor);
    
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

-(void)setText:(NSString *)text
{
    _tipLabel.text = text;
    
    [self updateTipView];
}

-(void)updateTipView
{
    if (_tipLabel.text.length)
    {
        CGRect labFrame = CGRectMake(_leftPadding, (_tipDown)?_tipHeight + _topPadding:_topPadding, self.frame.size.width - (_leftPadding + _rightPadding), _tipLabel.frame.size.height);
        
        NSLog(@"labFrame :%@", NSStringFromCGRect(labFrame));
        
        CGSize size = [_tipLabel.text sizeWithFont:_tipLabel.font constrainedToSize:CGSizeMake(labFrame.size.width, CGFLOAT_MAX)];
        
        NSLog(@"size :%@", NSStringFromCGSize(size));
        
        labFrame.size.width = size.width;
        
        labFrame.size.height = size.height;
        
        _tipLabel.frame = labFrame;
        
        [_tipLabel sizeToFit];

        CGRect frame = self.frame;
        
        frame.size.width = _tipLabel.frame.size.width + _leftPadding + _rightPadding;
        
        frame.size.height = _tipLabel.frame.size.height + _topPadding + _bottomPadding + _tipHeight + _shadowHeight;
        
        self.frame = frame;
        
        [self setNeedsDisplay];
    }
}

- (void)dealloc
{
	_backgroundColor = nil;
    
    _borderColor = nil;
}

@end
