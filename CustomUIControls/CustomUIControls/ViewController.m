#import "ViewController.h"

#import "COSwitch.h"

#import "COTipView.h"

#import "COSlider.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    COSwitch * swi = [[COSwitch alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2 - 100.0), 20, 200.0, 50.0)];
//    
//    swi.isOn = NO;
//    
//    [swi addTarget:self selector:@selector(switchStatus:)];
//    
//    [self.view addSubview:swi];
    
    squareView = [[UIView alloc] initWithFrame:CGRectMake(100.0, 340.0, 30.0, 30.0)];
    
    squareView.backgroundColor = [UIColor redColor];
    
    squareView.layer.cornerRadius = 5.0;
    
    [self.view addSubview:squareView];
    
    UIButton * icon = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 320.0)];
    
    icon.backgroundColor = [UIColor whiteColor];
    
    [icon addTarget:self action:@selector(animate:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:icon];
    
    icon = nil;

//    COTipView * tipView = [[COTipView alloc] initWithFrame:CGRectMake(110.0, 100.0, 100.0, 100.0)];
//    
//    [tipView setText:@"AAAAAAAAAAAAAAAAAAAAAAAAAAAA AAAAAAAA AAAAAAAAAAAA AAAAAAAA"];
//    
//    tipView.tag = 454;
//    
//    [self.view addSubview:tipView];
//    
//    tipView = nil;
    
    /*
    
    COSlider * coSlider = [[COSlider alloc] initWithFrame:CGRectMake(20.0, 100.0, 30.0, 200.0)];
    
    coSlider.type = sliderTypeVertical;
    
    [self.view addSubview:coSlider];
    
    coSlider = nil;
     */
    
//    UISlider * slider = [[UISlider alloc] initWithFrame:CGRectMake(30.0, 200.0, 200.0, 6.0)];
//    
//    slider.maximumValue = 5.0;
//    
//    slider.minimumValue = 1.0;
//    
//    UIImage *sliderMinimum = [[UIImage imageNamed:@"maxtrack-layer.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
//    
//    [slider setMinimumTrackImage:sliderMinimum forState:UIControlStateNormal];
//    
//    UIImage *sliderMaximum = [[UIImage imageNamed:@"mintrack-layer.png"] stretchableImageWithLeftCapWidth:10 topCapHeight:0];
//    
//    [slider setMaximumTrackImage:sliderMaximum forState:UIControlStateNormal];
//    
//    [self.view addSubview:slider];
//    
//    slider = nil;
}

-(void)animate:(UIButton *)icon
{
//    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"transform"];
//    
//    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    anim.duration = 0.125;
//    
//    anim.repeatCount = 1;
//    
//    anim.autoreverses = YES;
//    
//    anim.removedOnCompletion = YES;
//    
//    anim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)];
    
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    
    [movePath moveToPoint:icon.center];
    
    [movePath addQuadCurveToPoint:squareView.center controlPoint:CGPointMake(squareView.center.x, icon.center.y)];
    
    CAKeyframeAnimation * moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    moveAnim.path = movePath.CGPath;
    
    moveAnim.removedOnCompletion = YES;
    
    CABasicAnimation *scaleAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    scaleAnim.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    
    scaleAnim.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    
    scaleAnim.removedOnCompletion = YES;
    
    CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"alpha"];
    
    opacityAnim.fromValue = [NSNumber numberWithFloat:1.0];
    
    opacityAnim.toValue = [NSNumber numberWithFloat:0.1];
    
    opacityAnim.removedOnCompletion = YES;
    
    CAAnimationGroup * animGroup = [CAAnimationGroup animation];
    
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, scaleAnim, opacityAnim, nil];
    
    animGroup.delegate = self;
    
    animGroup.duration = 0.5;
    
    [icon.layer addAnimation:animGroup forKey:nil];
}

- (void)animationDidStart:(CAAnimation *)anim
{
    NSLog(@"animationDidStart");
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
}

-(void)switchStatus:(id)sender
{
    NSLog(@"Sender status is:%d",[sender isOn]);
    
    [[self.view viewWithTag:454] setHidden:![sender isOn]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
