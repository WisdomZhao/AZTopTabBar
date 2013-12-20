//
//  AZTopTabBar.m
//  AZTopTabBar
//
//  Created by zhihui zhao on 13-12-17.
//  Copyright (c) 2013 zhihui zhao. All rights reserved.
//

#import "AZTopTabBar.h"
#import "AZTabBarItem.h"

static const NSTimeInterval MARK_ANIMATE_TIME = 0.3;
static const NSTimeInterval VISIBLE_ANIMATE_TIME = 0.3;

@interface AZTopTabBar ()
{
	UIView*		_selectedMarkView;
}
- (void)tapAction:(UITapGestureRecognizer*)gesture;
- (BOOL)containsIndex:(NSInteger)index;
- (void)resetNeedsLayout;
- (void)resetNeedsDisplay;
- (void)scrollToVisibleFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex;
@end

@implementation AZTopTabBar

@synthesize scrollView = _scrollView;

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame])
	{
		_currentIndex = -1;
		_itemSize = CGSizeZero;
		_itemSpace = 0.0f;
		_itemFont = [UIFont systemFontOfSize:17];
		
		_itemViews = [[NSMutableArray alloc] initWithCapacity:3];
		
		_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		_scrollView.showsHorizontalScrollIndicator = NO;
		_scrollView.showsVerticalScrollIndicator = NO;
		[self addSubview:_scrollView];
	}
	return self;
}

- (void)dealloc
{
	
}

- (void)resetNeedsLayout
{
	for (AZTabBarItem *tabItem in self.itemViews)
	{
		if (tabItem.superview != nil)
			[tabItem removeFromSuperview];
	}
	[self.itemViews removeAllObjects];
	if ([_selectedMarkView superview])
	{
		[_selectedMarkView removeFromSuperview];
		_selectedMarkView = nil;
	}
	
	if (_titles.count <= 0 && _itemImages.count <= 0)
		return;
	
	@autoreleasepool {
		CGFloat totalWidth = 0.0f;
		NSMutableArray* widthArr = [NSMutableArray arrayWithCapacity:_titles.count];
		
		if (_itemSizeToFit)
		{
			for (int i = 0; i < _titles.count; i++)
			{
				NSString* title = [_titles objectAtIndex:i];
				CGFloat width = [title sizeWithFont:_itemFont].width;
				[widthArr addObject:[NSNumber numberWithFloat:width]];
				totalWidth += width + _itemSpace;
			}
			totalWidth -= _itemSpace;
		}
		else
		{
			totalWidth = [_titles count] * (_itemSize.width + _itemSpace) - _itemSpace;
		}
		_scrollView.contentSize = CGSizeMake(totalWidth, self.bounds.size.height);
		CGFloat offsetX = 0.0f;
		if (totalWidth < self.bounds.size.width)
			offsetX = (self.bounds.size.width - totalWidth)/2.0;
		
		for (int i = 0; i < _titles.count; i++)
		{
			CGFloat tabItemWidth = _itemSizeToFit ? [[widthArr objectAtIndex:i] floatValue]:_itemSize.width;
			AZTabBarItem* tabItem = [[AZTabBarItem alloc] initWithFrame:CGRectMake(offsetX, self.bounds.size.height/2.0 - _itemSize.height/2.0, tabItemWidth, _itemSize.height)];
			tabItem.tag = i;
			tabItem.textColor = _itemTitleColor;
			tabItem.selectedTextColor = _itemSelectedTitleColor;
			tabItem.selected = (i == _currentIndex) ? YES : NO;
			tabItem.bgColor = [UIColor clearColor];
			tabItem.titleLabel.text = [_titles objectAtIndex:i];
			
			if (_itemImages.count > i || _itemSelectedImages.count > i)
			{
				tabItem.backgroundImage = _itemImages.count > i ? [_itemImages objectAtIndex:i]:nil;
				tabItem.selectedBackgroundImage = _itemSelectedImages.count > i ? [_itemSelectedImages objectAtIndex:i]:nil;
			}
			else if (i == 0 && _itemLeftImages.count > 0)
			{
				tabItem.backgroundImage = [_itemLeftImages objectAtIndex:0];
				tabItem.selectedBackgroundImage = _itemLeftImages.count > 1 ? [_itemLeftImages objectAtIndex:1]:nil;
			}
			else if (i == _titles.count - 1 && _itemRightImages.count > 0)
			{
				tabItem.backgroundImage = [_itemRightImages objectAtIndex:0];
				tabItem.selectedBackgroundImage = _itemRightImages.count > 1 ? [_itemRightImages objectAtIndex:1]:nil;
			}
			else if (_itemMiddleImages.count > 0)
			{
				tabItem.backgroundImage = [_itemMiddleImages objectAtIndex:0];
				tabItem.selectedBackgroundImage = _itemMiddleImages.count > 1 ? [_itemMiddleImages objectAtIndex:1]:nil;
			}
						
			UITapGestureRecognizer* tapGestuer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
			tapGestuer.numberOfTapsRequired = 1;
			tapGestuer.numberOfTouchesRequired = 1;
			[tabItem addGestureRecognizer:tapGestuer];
			[self.itemViews addObject:tabItem];
			[_scrollView addSubview:tabItem];
			
			if (_showSelectedMark && i == _currentIndex)
			{
				CGFloat titleH = [[_titles objectAtIndex:i] sizeWithFont:_itemFont].height;
				_selectedMarkView = [[UIView alloc] initWithFrame:CGRectMake(offsetX, CGRectGetMinY(tabItem.frame) + _itemSize.height/2.0 + titleH/2.0, tabItemWidth, 2)];
				_selectedMarkView.backgroundColor = _itemSelectedTitleColor;
				[_scrollView addSubview:_selectedMarkView];
			}
			
			offsetX += tabItemWidth + _itemSpace;
		}
		
		if (_showSelectedMark)
			[_scrollView bringSubviewToFront:_selectedMarkView];
	}
}

- (void)resetNeedsDisplay
{
	for (int i = 0; i < self.itemViews.count; i++)
	{
		AZTabBarItem* tabItem = [self.itemViews objectAtIndex:i];
		tabItem.textColor = _itemTitleColor;
		tabItem.selectedTextColor = _itemSelectedTitleColor;
		if (_selectedMarkView)
			_selectedMarkView.backgroundColor = _itemSelectedTitleColor;
		
		if (_itemImages.count > i || _itemSelectedImages.count > i)
		{
			tabItem.backgroundImage = _itemImages.count > i ? [_itemImages objectAtIndex:i]:nil;
			tabItem.selectedBackgroundImage = _itemSelectedImages.count > i ? [_itemSelectedImages objectAtIndex:i]:nil;
		}
		else if (i == 0 && _itemLeftImages.count > 0)
		{
			tabItem.backgroundImage = [_itemLeftImages objectAtIndex:0];
			tabItem.selectedBackgroundImage = _itemLeftImages.count > 1 ? [_itemLeftImages objectAtIndex:1]:nil;
		}
		else if (i == _titles.count - 1 && _itemRightImages.count > 0)
		{
			tabItem.backgroundImage = [_itemRightImages objectAtIndex:0];
			tabItem.selectedBackgroundImage = _itemRightImages.count > 1 ? [_itemRightImages objectAtIndex:1]:nil;
		}
		else if (_itemMiddleImages.count > 0)
		{
			tabItem.backgroundImage = [_itemMiddleImages objectAtIndex:0];
			tabItem.selectedBackgroundImage = _itemMiddleImages.count > 1 ? [_itemMiddleImages objectAtIndex:1]:nil;
		}
	}
}

- (void)tapAction:(UITapGestureRecognizer*)gesture
{
	AZTabBarItem* tabItem = (AZTabBarItem*)gesture.view;
	self.currentIndex = tabItem.tag;
	
	if ([self containsIndex:tabItem.tag] && [self.barDelegate respondsToSelector:@selector(tabBar:didSelectIndex:)])
		[self.barDelegate tabBar:self didSelectIndex:tabItem.tag];
}

- (BOOL)containsIndex:(NSInteger)index
{
	return (index >= 0 && index < self.itemViews.count) ? YES:NO;
}

- (void)scrollToVisibleFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex
{
	if (toIndex > fromIndex && toIndex + 1 < self.itemViews.count)
	{
		AZTabBarItem* tabItem = [self.itemViews objectAtIndex:(toIndex + 1)];
		CGFloat offsetX = CGRectGetMaxX(tabItem.frame) - (_scrollView.contentOffset.x + CGRectGetWidth(_scrollView.bounds));
		if (offsetX > 0)
		{
			CGPoint offset = _scrollView.contentOffset;
			offset.x += offsetX;
			[UIView animateWithDuration:VISIBLE_ANIMATE_TIME delay:(_showSelectedMark ? MARK_ANIMATE_TIME:0.0) options:0 animations:^{
				_scrollView.contentOffset = offset;
			} completion:NULL];
		}
	}
	else if (toIndex < fromIndex && toIndex - 1 >= 0)
	{
		AZTabBarItem* tabItem = [self.itemViews objectAtIndex:(toIndex - 1)];
		CGFloat offsetX =  CGRectGetMinX(tabItem.frame) - _scrollView.contentOffset.x;
		if (offsetX < 0)
		{
			CGPoint offset = _scrollView.contentOffset;
			offset.x += offsetX;
			[UIView animateWithDuration:VISIBLE_ANIMATE_TIME delay:(_showSelectedMark ? MARK_ANIMATE_TIME:0.0) options:0 animations:^{
				_scrollView.contentOffset = offset;
			} completion:NULL];
		}
	}
}

#pragma mark setters or getters methods

- (void)setBackgroundView:(UIView *)backgroundView
{
	_backgroundView = backgroundView;
	_backgroundView.frame = CGRectMake(0, 1, self.bounds.size.width, self.bounds.size.height);
	[self insertSubview:_backgroundView atIndex:0];
}

- (void)setCurrentIndex:(NSInteger)currentIndex
{
	if (currentIndex == _currentIndex)
		return;
	
	if ([self containsIndex:_currentIndex])
		((AZTabBarItem*)[self.itemViews objectAtIndex:_currentIndex]).selected = NO;
	if ([self containsIndex:currentIndex])
		((AZTabBarItem*)[self.itemViews objectAtIndex:currentIndex]).selected = YES;
	
	if (_showSelectedMark)
	{
		AZTabBarItem* tabItem = [self.itemViews objectAtIndex:currentIndex];
		CGFloat titleH = [[_titles objectAtIndex:currentIndex] sizeWithFont:_itemFont].height;
		CGRect targetR = CGRectMake(CGRectGetMinX(tabItem.frame), CGRectGetMinY(tabItem.frame) + _itemSize.height/2.0 + titleH/2.0, CGRectGetWidth(tabItem.frame), CGRectGetHeight(_selectedMarkView.frame));
		
		[UIView animateWithDuration:MARK_ANIMATE_TIME delay:0.0 options:0 animations:^{
			_selectedMarkView.frame = targetR;
		} completion:^(BOOL finished) {
		}];
	}
	
	[self scrollToVisibleFromIndex:_currentIndex toIndex:currentIndex];
	
	_currentIndex = currentIndex;
}

- (void)setItemSize:(CGSize)itemSize
{
	_itemSize = itemSize;
	[self resetNeedsLayout];
}

- (void)setItemSpace:(CGFloat)itemSpace
{
	_itemSpace = itemSpace;
	[self resetNeedsLayout];
}

- (void)setItemFont:(UIFont *)itemFont
{
	_itemFont = itemFont;
	[self resetNeedsLayout];
}

- (void)setTitles:(NSArray *)titles
{
	_titles = titles;
	if (CGSizeEqualToSize(_itemSize, CGSizeZero))
		_itemSize = CGSizeMake(CGRectGetWidth(self.bounds)/titles.count, CGRectGetHeight(self.bounds));
	
	[self resetNeedsLayout];
}

- (void)setItemImages:(NSArray *)itemImages
{
	_itemImages = itemImages;
	[self resetNeedsDisplay];
}

- (void)setItemSelectedImages:(NSArray *)itemSelectedImages
{
	_itemSelectedImages = itemSelectedImages;
	[self resetNeedsDisplay];
}

- (void)setItemLeftImages:(NSArray *)itemLeftImages
{
	_itemLeftImages = itemLeftImages;
	[self resetNeedsDisplay];
}

- (void)setItemRightImages:(NSArray *)itemRightImages
{
	_itemRightImages = itemRightImages;
	[self resetNeedsDisplay];
}

- (void)setItemMiddleImages:(NSArray *)itemMiddleImages
{
	_itemMiddleImages = itemMiddleImages;
	[self resetNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
	_itemTitleColor = itemTitleColor;
	[self resetNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)itemSelectedTitleColor
{
	_itemSelectedTitleColor = itemSelectedTitleColor;
	[self resetNeedsDisplay];
}

- (void)setItemSizeToFit:(BOOL)itemSizeToFit
{
	_itemSizeToFit = itemSizeToFit;
	[self resetNeedsLayout];
}

- (void)setShowSelectedMark:(BOOL)showSelectedMark
{
	_showSelectedMark = showSelectedMark;
	[self resetNeedsLayout];
}

#pragma mark public methods

- (void)resetTopTabBar
{
	self.currentIndex = -1;
}

@end
