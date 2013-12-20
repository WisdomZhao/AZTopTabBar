//
//  AZTabBarItem.h
//  AZTopTabBar
//
//  Created by zhihui zhao on 13-12-17.
//  Copyright (c) 2013 zhihui zhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZTabBarItem : UIView

@property (nonatomic, strong) UIImage	*backgroundImage;
@property (nonatomic, strong) UIImage	*selectedBackgroundImage;
@property (nonatomic, strong) UIColor	*bgColor;
@property (nonatomic, strong) UIColor	*selectedBgColor;
@property (nonatomic, strong) UIColor	*textColor;
@property (nonatomic, strong) UIColor	*selectedTextColor;
@property (nonatomic, strong) UILabel	*titleLabel;
@property (nonatomic, assign) BOOL		selected;

@end
