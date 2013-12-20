//
//  AZTopTabBar.h
//  AZTopTabBar
//
//  Created by zhihui zhao on 13-12-17.
//  Copyright (c) 2013 zhihui zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AZTopTabBar;
@protocol AZTopTabBarDelegate <NSObject>
@optional
- (void)tabBar:(AZTopTabBar*)tabBarView didSelectIndex:(NSInteger)index;
@end



@interface AZTopTabBar : UIView
@property (nonatomic, weak)		id<AZTopTabBarDelegate>	barDelegate;

@property (nonatomic, strong)	UIView*					backgroundView;
@property (nonatomic, readonly)	UIScrollView*			scrollView;

@property (nonatomic, readonly) NSMutableArray			*itemViews;//a array of AZTabBarItem object
@property (nonatomic, assign)	NSInteger				currentIndex;

@property (nonatomic, assign)	CGSize					itemSize;
@property (nonatomic, assign)	CGFloat					itemSpace;
@property (nonatomic, strong)	UIFont*					itemFont;

@property (nonatomic, strong)	NSArray*				titles;

@property (nonatomic, strong)	NSArray*				itemImages;//number of itemImages equal to number of titles, if use itemImages and itemSelectedImages, u should not use itemLeftImages, itemRightImages, itemMiddleImages
@property (nonatomic, strong)	NSArray*				itemSelectedImages;//number of itemSelectedImages equal to number of titles

@property (nonatomic, strong)	NSArray*				itemLeftImages;//should contain 2 images, index 0 is normal image, index 1 is selected images
//this property should be used together with itemRightImages and itemMiddleImages,
@property (nonatomic, strong)	NSArray*				itemRightImages;//should contain 2 images, index 0 is normal image, index 1 is selected images
@property (nonatomic, strong)	NSArray*				itemMiddleImages;//should contain 2 images, index 0 is normal image, index 1 is selected images

@property (nonatomic, strong)	UIColor*				itemTitleColor;
@property (nonatomic, strong)	UIColor*				itemSelectedTitleColor;

@property (nonatomic, assign)	BOOL					itemSizeToFit;//default is NO. if YES, adjust item size to fit length of title of item
@property (nonatomic, assign)	BOOL					showSelectedMark;//default is NO. if YES, show a mark line on bottem of item while item is selected

- (void)resetTopTabBar;
@end
