//
//  ViewController.m
//  YQPresentViewController
//
//  Created by Leaf on 14-9-3.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "ViewController.h"
#import "YQNavigationController.h"
#import "RootViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
//    UIViewController *vc = [[UIViewController alloc] init];
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
//    [self.view addSubview:nav.view];
//    nav.view.frame = CGRectMake(0, 0, 100, 100);
//    vc.view.backgroundColor = [UIColor greenColor];
//    [self.view addSubview:[YQPresentViewController shareInstance].view];
    YQNavigationController *nav = [[YQNavigationController alloc] initWithSize:CGSizeMake(250, 300) rootViewController:nil];
    RootViewController *root = [[RootViewController alloc] init];
    nav.rootViewController = root;    
    root.title = @"root";
    [nav show:YES animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
