//
//  AppViewController.m
//  AZTopTabBarExample
//
//  Created by zhihui zhao on 13-12-20.
//  Copyright (c) 2013 zhihui zhao. All rights reserved.
//

#import "AppViewController.h"
#import "TemplateViewController.h"

#define TAB_BAR_TAG1 989788

@interface AppViewController ()
{
	NSArray*		_titles;
	AZTopTabBar*	_topTabBar;
	AZTopTabBar*	_topTabBar2;
	UIScrollView*	_scrollView;
}

- (void)switchDidChange:(UISwitch *)aSwitch;

@end

@implementation AppViewController

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
	CGSize size = self.view.frame.size;
	
	_titles =  [NSArray arrayWithObjects:@"电影",@"电视剧",@"大家都在看",@"音乐戏曲",@"军事观察",@"爆笑港澳台",@"综艺",@"彩票",@"体育",@"篮球",@"旅游",@"环球地理",nil, @"",@"",@"",@"",@"",@"",@"",@"",@"",@"", nil];
	
	_topTabBar = [[AZTopTabBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
	_topTabBar.backgroundColor = [UIColor grayColor];
	_topTabBar.tag = TAB_BAR_TAG1;
	_topTabBar.barDelegate = self;
	_topTabBar.currentIndex = 0;
	_topTabBar.itemSize = CGSizeMake(85, 39);
	_topTabBar.itemSpace = 8;
	_topTabBar.itemFont = [UIFont systemFontOfSize:18];
	_topTabBar.titles = _titles;
	_topTabBar.itemSizeToFit = YES;
	_topTabBar.showSelectedMark = YES;
	_topTabBar.itemTitleColor = [UIColor whiteColor];
	_topTabBar.itemSelectedTitleColor = [UIColor blackColor];
	[self.view addSubview:_topTabBar];
	
	UILabel* label1 = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_topTabBar.frame) + 5, 120, 20)];
	label1.backgroundColor = [UIColor clearColor];
	label1.textAlignment = NSTextAlignmentCenter;
	label1.textColor = [UIColor blueColor];
	label1.font = [UIFont systemFontOfSize:16];
	label1.text = @"item size to fit";
	[self.view addSubview:label1];
	
	UISwitch* switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(label1.frame) + 5, 0, 0)];
	switch1.tag = 1;
	switch1.on = YES;
	[switch1 addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:switch1];
	
	UILabel* label2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(label1.frame) + 10, CGRectGetMaxY(_topTabBar.frame) + 5, 120, 20)];
	label2.backgroundColor = [UIColor clearColor];
	label2.textAlignment = NSTextAlignmentCenter;
	label2.textColor = [UIColor blueColor];
	label2.font = [UIFont systemFontOfSize:16];
	label2.text = @"show mark line";
	[self.view addSubview:label2];

	UISwitch* switch2 = [[UISwitch alloc] initWithFrame:CGRectMake(CGRectGetMinX(label2.frame), CGRectGetMaxY(label2.frame) + 5, 0, 0)];
	switch2.tag = 2;
	switch2.on = YES;
	[switch2 addTarget:self action:@selector(switchDidChange:) forControlEvents:UIControlEventValueChanged];
	[self.view addSubview:switch2];
	
	_topTabBar2 = [[AZTopTabBar alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(switch1.frame) + 10, self.view.bounds.size.width, 44)];
	_topTabBar2.backgroundColor = [UIColor grayColor];
	_topTabBar2.tag = TAB_BAR_TAG1 + 1;
	_topTabBar2.barDelegate = self;
	_topTabBar2.currentIndex = 0;
	_topTabBar2.itemSize = CGSizeMake(85, 39);
	_topTabBar2.itemSpace = 8;
	_topTabBar2.itemFont = [UIFont systemFontOfSize:18];
	_topTabBar2.titles = _titles;
	_topTabBar2.itemSizeToFit = YES;
	_topTabBar2.showSelectedMark = YES;
	_topTabBar2.itemTitleColor = [UIColor whiteColor];
	_topTabBar2.itemSelectedTitleColor = [UIColor yellowColor];
	[self.view addSubview:_topTabBar2];
	
	_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_topTabBar2.frame) + 10, size.width, size.height - CGRectGetMaxY(_topTabBar2.frame) + 10)];
	_scrollView.backgroundColor = [UIColor greenColor];
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.showsVerticalScrollIndicator = NO;
	_scrollView.bounces = YES;
	_scrollView.alwaysBounceHorizontal = YES;
	_scrollView.pagingEnabled = YES;
	_scrollView.delegate = self;
	[self.view addSubview:_scrollView];
	
	for (int i = 0; i < _titles.count;i++)
	{
		TemplateViewController* tempController = [[TemplateViewController alloc] init];
		tempController.title = [_titles objectAtIndex:i];
		tempController.view.frame = CGRectMake(_scrollView.bounds.size.width * i, 0, _scrollView.bounds.size.width, _scrollView.bounds.size.height);
		[_scrollView addSubview:tempController.view];
	}
	
	_scrollView.contentSize = CGSizeMake(_scrollView.bounds.size.width * _titles.count, _scrollView.bounds.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tabBar:(AZTopTabBar *)tabBarView didSelectIndex:(NSInteger)index
{
	if (tabBarView.tag == TAB_BAR_TAG1) {
		_topTabBar2.currentIndex = index;
	}else{
		_topTabBar.currentIndex = index;
	}
	[_scrollView setContentOffset:CGPointMake(index * _scrollView.bounds.size.width, 0) animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	int page = scrollView.contentOffset.x / scrollView.bounds.size.width;
	if (page < 0 || page >= _titles.count)
		return;

	_topTabBar.currentIndex = page;
	_topTabBar2.currentIndex = page;
}

- (void)switchDidChange:(UISwitch *)aSwitch
{
	if (aSwitch.tag == 1) {
		_topTabBar.itemSizeToFit = aSwitch.on;
		_topTabBar2.itemSizeToFit = aSwitch.on;
	}else{
		_topTabBar.showSelectedMark = aSwitch.on;
		_topTabBar2.showSelectedMark = aSwitch.on;
	}
}

@end
