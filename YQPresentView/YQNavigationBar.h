//
//  YQNavigationBar.h
//  YQPresentViewController
//
//  Created by Wang on 14-9-4.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YQViewController;

@interface YQNavigationBar : UIToolbar
@property (nonatomic,strong) NSString *leftTitle;
@property (nonatomic,strong) NSString *rightTitle;
@property (strong,nonatomic) void (^leftBlock)(void);
@property (strong,nonatomic) void (^rightBlock)(void);
@property (strong,nonatomic) NSString *title;
@property (assign,nonatomic) CGFloat titleAlpha;
-(void)clear;
@end
