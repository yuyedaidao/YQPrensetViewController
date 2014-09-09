//
//  YQPresentViewController.h
//  YQPresentViewController
//
//  Created by Wang on 14-9-4.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//



#import <UIKit/UIKit.h>
@class  YQViewController;
@class YQNavigationBar;

@interface YQNavigationController : UIViewController
+(instancetype)shareInstance;
-(id)initWithSize:(CGSize)size rootViewController:(YQViewController *)viewController;
//+(instancetype)createInstanceWithSize:(CGSize)size rootViewController:(YQViewController *)viewController;
@property (strong,nonatomic) YQViewController *rootViewController;

@property (assign,nonatomic) BOOL touchSpaceHide;
@property (assign,nonatomic) CGSize size;
-(void)show:(BOOL)isShow animated:(BOOL)animated;
-(void)pushYQViewController:(YQViewController *)viewController animated:(BOOL)animated;
-(void)popYQViewControllerAnimated:(BOOL)animated;
@end
