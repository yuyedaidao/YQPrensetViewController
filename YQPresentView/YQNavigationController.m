//
//  YQPresentViewController.m
//  YQPresentViewController
//
//  Created by Wang on 14-9-4.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "YQNavigationController.h"
#import "YQNavigationBar.h"
#import "YQViewController.h"
#import <POP.h>

#define DefaultSize CGSizeMake(200,250)

@interface YQNavigationController ()
@property (strong,nonatomic) UIView *containerView;
@property (strong,nonatomic) UIView *containerBackgroundView;
@property (strong,nonatomic) UIView *grayBackgroundView;
@property (strong,nonatomic) NSMutableArray *viewControllers;
@property (assign,nonatomic) BOOL animating;
@property (strong,nonatomic) YQViewController *tempCurrentVC;
@property (strong,nonatomic) YQViewController *tempToVC;
//@property (strong,nonatomic) NSMutableArray *navigationBars;

@end

__strong static YQNavigationController *present = nil;

@implementation YQNavigationController

+(instancetype)shareInstance{
   
    return present;
}

-(void)show:(BOOL)isShow animated:(BOOL)animated{
    //把根视图加进去
  
    if(isShow){
        
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        [window addSubview:self.view];
        
        self.view.hidden = NO;
        if(animated){
            POPSpringAnimation *animation = [self.containerBackgroundView pop_animationForKey:@"spring"];
            if(animation==nil){
                animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
                animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.3, 0.3)];
                animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0f)];
                animation.springBounciness = 20;
                animation.springSpeed = 40;
                [self.containerBackgroundView pop_addAnimation:animation forKey:@"spring"];
            }else{
                animation.fromValue = [NSValue valueWithCGSize:CGSizeMake(0.5, 0.5)];
                animation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.0, 1.0f)];
            }
            
        }
        
    }else{
//        [self.grayBackgroundView removeFromSuperview];
        if(animated){
            
            ((YQViewController *)self.viewControllers.lastObject).navigationBar.translucent = NO;
            [UIView animateWithDuration:0.2 animations:^{
                self.grayBackgroundView.alpha = 0.3;
                self.containerBackgroundView.alpha = 0.3;
            } completion:^(BOOL finished) {
                [self clear];
                [self.view removeFromSuperview];
                present = nil;
            }];
        }else{
            [self clear];
            [self.view removeFromSuperview];
            present = nil;
        }
    }
}
-(void)clear{
    self.rootViewController = nil;
    for (UIViewController *vc in self.childViewControllers) {
        [vc removeFromParentViewController];
    }
    self.viewControllers = nil;
}
-(void)setRootViewController:(YQViewController *)rootViewController{
    if(_rootViewController!=rootViewController && rootViewController!=nil){
        _rootViewController = rootViewController;
        [self.viewControllers removeAllObjects];
        [self.viewControllers addObject:rootViewController];
    }
}
-(id)init{
   
    return [self initWithSize:DefaultSize rootViewController:nil];

}
-(id)initWithSize:(CGSize)size rootViewController:(YQViewController *)viewController{
    
    if(self=[super init]){
        
        self.viewControllers = [NSMutableArray array];
        _size = size;
        
        self.containerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.size.width, self.size.height)];
        self.containerBackgroundView.backgroundColor = [UIColor clearColor];

        //圆角
        self.containerBackgroundView.layer.cornerRadius = 4.0f;
        self.containerBackgroundView.clipsToBounds = YES;
        
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 44, size.width, size.height-44)];
        self.containerView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        [self.containerBackgroundView addSubview:self.containerView];
        
        
        self.rootViewController = viewController;
        if(self.rootViewController){
            [self.viewControllers addObject:self.rootViewController];
        }
        
        
        present = self;
    }
    return self;
}
-(void)tapHandle{
    if(self.touchSpaceHide){
        [self show:NO animated:YES];
    }
}
-(void)panHandle:(UIPanGestureRecognizer *)gesture{
    if(self.panPopView && self.viewControllers.count>1){
        
        CGPoint loc = [gesture locationInView:self.containerView];
        CGPoint loc2 = [gesture locationInView:gesture.view];
        CGPoint tran = [gesture translationInView:self.containerView];

        CGFloat flag = loc.x-loc2.x;
        if(gesture.state == UIGestureRecognizerStateBegan){
            if(flag>=0){
                self.tempCurrentVC = self.viewControllers.lastObject;
                self.tempToVC = self.viewControllers[self.viewControllers.count-2];
                
               
                [self.containerView addSubview:self.tempToVC.view];
                [self.containerView sendSubviewToBack:self.tempToVC.view];
                self.tempToVC.view.center = CGPointMake(0, self.tempToVC.view.center.y);
                self.tempToVC.view.hidden = NO;
                self.tempToVC.view.center = CGPointMake(self.tempToVC.view.center.x+tran.x*0.5, self.tempToVC.view.center.y);
                self.tempCurrentVC.view.center = CGPointMake(self.tempCurrentVC.view.center.x+tran.x, self.tempCurrentVC.view.center.y);
                
                self.tempToVC.navigationBar.title = self.tempToVC.title;
                self.tempToVC.navigationBar.hidden = NO;
                self.tempToVC.navigationBar.alpha = 0;
            }
            
        }else if(gesture.state == UIGestureRecognizerStateChanged){
            if(flag>0 && flag<self.size.width){
                self.tempToVC.view.center = CGPointMake(self.tempToVC.view.center.x+tran.x*0.5, self.tempToVC.view.center.y);
                self.tempCurrentVC.view.center = CGPointMake(self.tempCurrentVC.view.center.x+tran.x, self.tempCurrentVC.view.center.y);
                CGFloat alpha = self.tempCurrentVC.view.frame.origin.x/self.size.width;
                self.tempToVC.navigationBar.titleAlpha = alpha*1.5;
                self.tempCurrentVC.navigationBar.titleAlpha = 1.0-alpha*1.5;
            }
        }else{
            if(self.tempCurrentVC.view.center.x>=self.size.width){
                //过了一半完成pop
                [self.tempCurrentVC willMoveToParentViewController:nil];
                [self addChildViewController:self.tempToVC];
                CGFloat duration = (self.size.width-self.tempCurrentVC.view.frame.origin.x)/self.size.width*0.3;
                [UIView animateWithDuration:duration animations:^{
                    self.tempToVC.view.center = CGPointMake(self.size.width/2, self.tempToVC.view.center.y);
                    self.tempCurrentVC.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
                    self.tempCurrentVC.navigationBar.alpha = 0;
                    self.tempToVC.navigationBar.alpha = 1.0f;
                } completion:^(BOOL finished) {
                    self.tempCurrentVC.navigationBar.hidden = YES;
                    self.tempCurrentVC.navigationBar.alpha = 1.0f;
                    [self.tempCurrentVC.navigationBar clear];
                    [self.tempCurrentVC.navigationBar removeFromSuperview];
                    [self.tempCurrentVC removeFromParentViewController];
                    [self.tempToVC didMoveToParentViewController:self];
                    [self.viewControllers removeLastObject];
                }];
                
            }else{
                CGFloat duration = self.tempCurrentVC.view.frame.origin.x/self.size.width*0.3;
                [UIView animateWithDuration:duration animations:^{
                    //tempToVC的中心无所谓
                    self.tempCurrentVC.navigationBar.alpha = 1.0;
//                    [self.containerBackgroundView bringSubviewToFront:self.tempCurrentVC.navigationBar];
                    self.tempCurrentVC.view.center = CGPointMake(self.size.width/2, self.tempCurrentVC.view.center.y);
                } completion:^(BOOL finished) {
                    [self.tempToVC.view removeFromSuperview];
                }];
            }
        }
        
        [gesture setTranslation:CGPointZero inView:self.containerView];
        
    }
    
}
-(void)setSize:(CGSize)size{

    _size = size;
    if(self.containerBackgroundView){
        CGPoint point = self.containerBackgroundView.center;
        self.containerBackgroundView.frame = CGRectMake(0, 0, size.width, size.height);
        self.containerBackgroundView.center = point;
        self.containerView.frame = self.containerBackgroundView.bounds;
        ((YQViewController *)self.viewControllers.lastObject).navigationBar.frame = CGRectMake(0, 0, size.width, 44);
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor clearColor];
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.view.bounds];
    backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
    [self.view addSubview:backgroundView];
    self.grayBackgroundView = backgroundView;
    //点击空白消失手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandle)];
    [backgroundView addGestureRecognizer:tap];
    

    self.containerBackgroundView.center = self.view.center;
    [self.view addSubview:self.containerBackgroundView];
    
    if(self.rootViewController){
       
        [self addChildViewController:self.rootViewController];
        [self.containerView addSubview:self.rootViewController.view];
        self.rootViewController.view.frame = self.containerView.bounds;
        [self.rootViewController didMoveToParentViewController:self];
        self.rootViewController.navigationBar.title = self.rootViewController.title;
        self.rootViewController.navigationBar.leftTitle = @"取消";
        self.rootViewController.navigationBar.frame = CGRectMake(0, 0, self.size.width, 44);
        self.rootViewController.navigationBar.hidden = NO;
        [self.containerBackgroundView addSubview:self.rootViewController.navigationBar];
        
        __weak typeof(self) weakSelf = self;
        self.rootViewController.navigationBar.leftBlock = ^{
            [weakSelf show:NO animated:YES];
        };
        
    }
    
}
-(void)pushYQViewController:(YQViewController *)viewController animated:(BOOL)animated{
    if(viewController){
        
        
        YQViewController *currentViewController = self.viewControllers.lastObject;
        
        YQNavigationBar *currentNavigationBar = currentViewController.navigationBar;
        YQNavigationBar *toNavigationBar = viewController.navigationBar;

        
        [self.viewControllers addObject:viewController];
        [currentViewController willMoveToParentViewController:nil];
        [self addChildViewController:viewController];
        [self.containerView addSubview:viewController.view];
        
        toNavigationBar.frame = currentNavigationBar.frame;
        toNavigationBar.title = viewController.title;
        toNavigationBar.hidden = NO;
        toNavigationBar.leftTitle = currentNavigationBar.title;
        [self.containerBackgroundView addSubview:toNavigationBar];
        
        //添加滑动手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandle:)];
        [viewController.view addGestureRecognizer:pan];
        viewController.view.userInteractionEnabled = YES;
        
        if(animated){
            self.animating = YES;
            toNavigationBar.alpha = 0.0f;
            viewController.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
            [self transitionFromViewController:currentViewController toViewController:viewController duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                toNavigationBar.alpha = 1.0f;
                currentNavigationBar.alpha = 0.0f;
                viewController.view.frame = self.containerView.bounds;
                currentViewController.view.frame = CGRectMake(-self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
            } completion:^(BOOL finished){
                if(finished){
                    
                    currentNavigationBar.hidden = YES;
                    currentNavigationBar.alpha = 1.0f;
                    [viewController didMoveToParentViewController:self];
                    [currentViewController removeFromParentViewController];
                    self.animating = NO;
                }
            }];

        }else{
            viewController.view.frame = self.containerView.bounds;
            currentNavigationBar.hidden = YES;
            [viewController didMoveToParentViewController:self];
            [currentViewController removeFromParentViewController];
            
        }
    }
}
-(void)popYQViewControllerAnimated:(BOOL)animated{
    
    if(self.viewControllers.count>1){
  
        YQViewController *currentViewController = self.viewControllers.lastObject;
        YQViewController *toViewController = self.viewControllers[self.viewControllers.count-2];
        
        YQNavigationBar *currentNavigationBar = currentViewController.navigationBar;
        YQNavigationBar *toNavigationBar = toViewController.navigationBar;
        
        [currentViewController willMoveToParentViewController:nil];
        [self addChildViewController:toViewController];
        [self.containerView addSubview:toViewController.view];
        toViewController.view.frame = CGRectMake(self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
        [self.containerView sendSubviewToBack:toViewController.view];
        
        toNavigationBar.title = toViewController.title;
        toNavigationBar.hidden = NO;
        
        
        if(animated){
            
            self.animating = YES;
            toNavigationBar.alpha = 0.0f;
            toViewController.view.frame = CGRectMake(-self.size.width/2, 0, self.size.width, self.containerView.bounds.size.height);
            [self transitionFromViewController:currentViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionCurveLinear animations:^{
                toNavigationBar.alpha = 1.0f;
                currentNavigationBar.alpha = 0.0f;
                toViewController.view.frame = self.containerView.bounds;
                currentViewController.view.frame = CGRectMake(self.size.width, 0, self.size.width, self.containerView.bounds.size.height);
                
            } completion:^(BOOL finished) {
                if(finished){
                  
                    currentNavigationBar.hidden = YES;
                    currentNavigationBar.alpha = 1.0f;
                    [currentNavigationBar clear];
                    [currentNavigationBar removeFromSuperview];
                    [currentViewController removeFromParentViewController];
                    [toViewController didMoveToParentViewController:self];
                    [self.viewControllers removeLastObject];
                    self.animating = NO;
                }
            }];
        }else{
            
            currentNavigationBar.hidden = YES;
            [currentNavigationBar clear];
            [currentNavigationBar removeFromSuperview];
            [currentViewController removeFromParentViewController];
            [toViewController didMoveToParentViewController:self];
            [self.viewControllers removeLastObject];
        }
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
