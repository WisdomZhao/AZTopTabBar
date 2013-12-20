//
//  TemplateViewController.m
//  AZTopTabBarExample
//
//  Created by zhihui zhao on 13-12-20.
//
//

#import "TemplateViewController.h"

@interface TemplateViewController ()
{
	UILabel*	_titleLabel;
}

@end

@implementation TemplateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 50)];
	_titleLabel.center = self.view.center;
	_titleLabel.backgroundColor = [UIColor clearColor];
	_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.textColor = [UIColor purpleColor];
	_titleLabel.font = [UIFont systemFontOfSize:20];
	_titleLabel.text = self.title;
	[self.view addSubview:_titleLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setTitle:(NSString *)title
{
	[super setTitle:title];
	if ([self isViewLoaded])
		_titleLabel.text = title;
}

@end
