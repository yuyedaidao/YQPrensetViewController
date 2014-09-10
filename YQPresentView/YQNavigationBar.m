//
//  YQNavigationBar.m
//  YQPresentViewController
//
//  Created by Wang on 14-9-4.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "YQNavigationBar.h"
#import "YQViewController.h"

@interface YQNavigationBar()
@property (nonatomic,strong) UIBarButtonItem *leftItem;
@property (nonatomic,strong) UIBarButtonItem *rightItem;
@property (nonatomic,strong) UIBarButtonItem *titleItem;
@property (nonatomic,strong) UILabel *titleLabel;
//@property (nonatomic,strong) UILabel *leftLabel;
//@property (nonatomic,strong) UILabel *rightLabel;
@end
@implementation YQNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
 
        UIBarButtonItem *flexible = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];

        self.leftItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStyleBordered target:self action:@selector(leftClick)];
        self.rightItem = [[UIBarButtonItem alloc] initWithTitle:@"    " style:UIBarButtonItemStyleBordered target:self action:@selector(rightClick)];
        self.titleItem = [[UIBarButtonItem alloc] initWithTitle:@"        " style:UIBarButtonItemStyleBordered target:nil action:nil];
        NSArray *items = @[self.leftItem,flexible,self.titleItem,flexible,self.rightItem];
        self.items = items;
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.titleLabel.backgroundColor = [UIColor clearColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textColor = self.tintColor;
        self.titleLabel.text = @"";
        [self addSubview:self.titleLabel];
        
        self.translucent = NO;
    
    }
    return self;
}
-(void)clear{
    self.leftBlock = nil;
    self.rightTitle = nil;
    self.leftTitle = nil;
    self.rightBlock = nil;
    self.title = nil;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame = self.bounds;
}
-(void)leftClick{
    if(self.leftBlock){
        self.leftBlock();
    }
}
-(void)rightClick{
    if(self.rightBlock){
        self.rightBlock();
    }
}
-(void)setTitle:(NSString *)title{
    if(title!=_title){
        _title = title;
        self.titleLabel.text = title;
    }
}
-(void)setLeftTitle:(NSString *)leftTitle{
    if(leftTitle!=_leftTitle){
        _leftTitle = leftTitle;
        self.leftItem.title = leftTitle;
    }
}
-(void)setRightTitle:(NSString *)rightTitle{
    if(rightTitle!=_rightTitle){
        _rightTitle = rightTitle;
        self.rightItem.title = rightTitle;
    }
}
-(void)setTitleAlpha:(CGFloat)titleAlpha{
    if(titleAlpha<0){
        self.alpha = 0;
    }else if(titleAlpha>1){
        self.alpha = 1.0f;
    }else{
        self.alpha = titleAlpha;
    }
}
-(CGFloat)titleAlpha{
    return self.alpha;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
