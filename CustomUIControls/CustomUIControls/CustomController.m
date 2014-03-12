#import "CustomController.h"

#import "COSwitch.h"

#import "COTipView.h"

#import "COProgressView.h"

#import "COSlider.h"

@interface CustomController ()

@end

@implementation CustomController

@synthesize type = _type;

@synthesize controlName = _controlName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
    
    UINavigationBar * bar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0.0, topHeight, 320.0, 44.0)];
    
    UINavigationItem * titlView = [[UINavigationItem alloc] initWithTitle:_controlName];
    
    titlView.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(backSelected)];
    
    [bar setItems:[NSArray arrayWithObject:titlView]];
    
    titlView = nil;
    
    [self.view addSubview:bar];
    
    CGRect frame = bar.frame;
    
    bar = nil;
    
    switch (_type)
    {
        case custom_Switch:
        {
            COSwitch * swi = [[COSwitch alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2 - 100.0), topHeight + 200, 200.0, 50.0)];
            
            swi.isOn = NO;
            
            [swi addTarget:self selector:@selector(switchStatus:)];
            
            [self.view addSubview:swi];
            
            break;
        }
        case custom_TipView:
        {
            frame.origin.y += frame.size.height + 100;
            
            frame.origin.x = (self.view.frame.size.width - 200.0) / 2;
            
            frame.size.height = 200.0;
            
            frame.size.width = 200.0;
            
            COTipView * tip = [[COTipView alloc] initWithFrame:frame];
            
            tip.tipX = 90.0;
            
            tip.tipY = 0.0;
            
            tip.tipWidth = 10.0;
            
            tip.tipHeight = 10.0;
            
            tip.leftPadding = 10.0;
            
            tip.rightPadding = 10.0;
            
            tip.topPadding = 10.0;
            
            tip.bottomPadding = 10.0;
            
            [tip setText:@"This is custom tip view used to show the text content as like tip message."];
            
            [self.view addSubview:tip];
            
            tip = nil;
            
            break;
        }
        case custom_ProgressView:
        {
            
            frame.origin.y += frame.size.height + 100;
            
            frame.origin.x = (self.view.frame.size.width - 200.0) / 2;
            
            frame.size.height = 20.0;
            
            frame.size.width = 200.0;
            
            prog = [[COProgressView alloc] initWithFrame:frame];                        
            
            prog.progColor = [UIColor redColor];
            
            [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(progressUpdate) userInfo:nil repeats:YES];
            
            [self.view addSubview:prog];
            
            break;
        }
        case custom_Slider:
        {
            COSlider * coSlider = [[COSlider alloc] initWithFrame:CGRectMake(20.0, 100.0, 30.0, 200.0)];
            
            coSlider.type = sliderTypeVertical;
            
            [self.view addSubview:coSlider];
            
            coSlider = nil;
            
            break;
        }
        default:
            break;
    }
}

-(void)progressUpdate
{
    if (prog.progress >= 1.0)
        [prog setProgress:0.0];
    else
        [prog setProgress:prog.progress+0.001];
}

-(void)switchStatus:(id)sender
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Switch" message:[@"" stringByAppendingFormat:@"Staus is %@",([sender isOn])?@"ON":@"OFF"] delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    
    [alert show];
    
    alert = nil;
}

-(void)backSelected
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
