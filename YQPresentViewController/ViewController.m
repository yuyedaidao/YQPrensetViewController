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
@property (weak, nonatomic) IBOutlet UIButton *show;
- (IBAction)showPresentView:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showPresentView:(id)sender {
    YQNavigationController *nav = [[YQNavigationController alloc] initWithSize:CGSizeMake(250, 300) rootViewController:nil];
    nav.touchSpaceHide = YES;
    nav.panPopView = YES;
    RootViewController *root = [[RootViewController alloc] init];
    nav.rootViewController = root;
    root.title = @"root";
    [nav show:YES animated:YES];
}
@end
