//
//  SecondViewController.m
//  YQPresentViewController
//
//  Created by Wang on 14-9-5.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "SecondViewController.h"
#import "OtherViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

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
    LOG;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.title = @"second";
   
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    LOG;
    __weak typeof(self) my = self;
    [self.navigationBar setLeftBlock:^{
        [my.yqNavigationController popYQViewControllerAnimated:YES];
    }];
    
    self.navigationBar.rightTitle = @"other";
    [self.navigationBar setRightBlock:^{
        OtherViewController *other = [[OtherViewController alloc] init];
        [my.yqNavigationController pushYQViewController:other animated:YES];
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
