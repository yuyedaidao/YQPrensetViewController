//
//  RootViewController.m
//  YQPresentViewController
//
//  Created by Wang on 14-9-5.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "RootViewController.h"
#import "SecondViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

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
    self.view.backgroundColor = [UIColor blueColor];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LOG;
    self.navigationBar.rightTitle = @"second";
    __weak RootViewController *my = self;
    [self.navigationBar setRightBlock:^{
        SecondViewController *second = [[SecondViewController alloc] init];
        [my.yqNavigationController pushYQViewController:second animated:YES];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    LOG;
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    LOG;
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    LOG;
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
