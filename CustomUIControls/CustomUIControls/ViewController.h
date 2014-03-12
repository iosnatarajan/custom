#import <UIKit/UIKit.h>

#import <QuartzCore/QuartzCore.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    UIView * squareView;
    
    NSMutableArray * controls;
}

@end
