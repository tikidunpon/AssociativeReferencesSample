
#import "KTViewController.h"
#import "UIView+Hidable.h"

@interface KTViewController ()
@property (nonatomic,strong) UIView *myView;
@end

@implementation KTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
}

- (void)configureView
{
    _myView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 150, 150)];
    [_myView setBackgroundColor:[UIColor darkGrayColor]];
    [self.view addSubview:_myView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showHideSwitchBtnPressed:(id)sender
{
    self.myView.hideFrame = CGRectMake(100, -150, 150, 150);
    self.myView.showFrame = CGRectMake(20, 20, 150, 150);
    [self.myView switchShowHide];
}

@end
