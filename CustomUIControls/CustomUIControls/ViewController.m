#import "ViewController.h"

#import "COSwitch.h"

#import "COTipView.h"

#import "COSlider.h"

#import "CustomController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (CGFloat)topOfViewOffset
{
    CGFloat top = 0;
    
    if ([self respondsToSelector:@selector(topLayoutGuide)])
    {
        top = self.topLayoutGuide.length;
    }
    
    return top;
}

- (CGFloat)bottomOfViewOffset
{
    CGFloat bottom = 0;
    
    if ([self respondsToSelector:@selector(bottomLayoutGuide)])
    {
        bottom = self.bottomLayoutGuide.length;
    }
    
    return bottom;
}

-(void)viewDidLayoutSubviews
{
    float topHeight = [self topOfViewOffset];
    
    controls = [[NSMutableArray alloc] initWithObjects:@"Custom Switch", @"Custom Tip View", @"Custom Progress View", @"Custom Slider View", nil];
    
    CGRect frame = self.view.frame;
    
    frame.origin.y = topHeight;
    
    frame.size.height -= topHeight;
    
    UITableView * table = [[UITableView alloc] initWithFrame:frame];
    
    table.delegate = self;
    
    table.dataSource = self;
    
    [self.view addSubview:table];
    
    table = Nil;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return controls.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellID";
    
    UITableViewCell * cell = (UITableViewCell *) [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [controls objectAtIndex:indexPath.row];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CustomController * controller = [[CustomController alloc] init];
    
    controller.type = indexPath.row;
    
    controller.controlName = [controls objectAtIndex:indexPath.row];
    
    [self presentViewController:controller animated:YES completion:nil];
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
