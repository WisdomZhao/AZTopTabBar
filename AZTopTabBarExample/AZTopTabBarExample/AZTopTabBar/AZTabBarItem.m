//
//  AZTabBarItem.m
//  AZTopTabBar
//
//  Created by zhihui zhao on 13-12-17.
//  Copyright (c) 2013 zhihui zhao. All rights reserved.
//

#import "AZTabBarItem.h"

@interface AZTabBarItem()
@property (nonatomic, strong) UIImageView *backgroundView;
@end

@implementation AZTabBarItem

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		_bgColor = [UIColor clearColor];
		_textColor = [UIColor blackColor];
		CGSize size = frame.size;
		_backgroundView = [[UIImageView alloc] initWithFrame:self.bounds];
		_backgroundView.backgroundColor = [UIColor clearColor];
		_backgroundView.contentMode = UIViewContentModeCenter;
		_backgroundView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		[self addSubview:_backgroundView];
		
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, size.height/2.0 - 20/2.0, size.width, 20)];
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_titleLabel.textAlignment = NSTextAlignmentCenter;
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.font = [UIFont systemFontOfSize:16];
		[self addSubview:_titleLabel];
	}
	return self;
}

- (void)setBackgroundImage:(UIImage *)backgroundImage
{
	_backgroundImage = backgroundImage;
	if (!_selected) _backgroundView.image = backgroundImage;
}

- (void)setSelectedBackgroundImage:(UIImage *)selectedBackgroundImage
{
	_selectedBackgroundImage = selectedBackgroundImage;
	if (_selected) _backgroundView.image = selectedBackgroundImage;
}

- (void)setBgColor:(UIColor *)bgColor
{
	_bgColor = bgColor;
	if (!_selected) self.backgroundColor = bgColor;
}

- (void)setSelectedBgColor:(UIColor *)selectedBgColor
{
	_selectedBgColor = selectedBgColor;
	if (_selected) self.backgroundColor = selectedBgColor;
}

- (void)setTextColor:(UIColor *)textColor
{
	_textColor = textColor;
	if (!_selected) _titleLabel.textColor = textColor;
}

- (void)setSelectedTextColor:(UIColor *)selectedTextColor
{
	_selectedTextColor = selectedTextColor;
	if (_selected) _titleLabel.textColor = selectedTextColor;
}

- (void)setSelected:(BOOL)selected
{
	if (_selected != selected)
	{
		_selected = selected;
		_backgroundView.image = selected ? _selectedBackgroundImage : _backgroundImage;
		self.backgroundColor = selected ? (_selectedBgColor == nil ? _bgColor:_selectedBgColor) : _bgColor;
		_titleLabel.textColor = selected ? (_selectedTextColor == nil ? _textColor:_selectedTextColor) : _textColor;
	}
}

@end
