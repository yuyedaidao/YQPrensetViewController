//
//  YQViewController.m
//  YQPresentViewController
//
//  Created by Wang on 14-9-4.
//  Copyright (c) 2014年 Leaf. All rights reserved.
//

#import "YQViewController.h"
#import "YQNavigationController.h"

@interface YQViewController ()

@end

@implementation YQViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self prepareNavigationBar];
    }
    return self;
}
-(id)init{
    if(self = [super init]){

        [self prepareNavigationBar];
    }
    return self;
}
-(void)prepareNavigationBar{
    self.navigationBar = [[YQNavigationBar alloc] initWithFrame:CGRectZero];
    self.navigationBar.hidden = YES;
}
-(void)awakeFromNib{
//    [self addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSLog(@"vc viewDidLoad");
    // Do any additional setup after loading the view.
    __weak YQViewController *mySelf = self;
    self.navigationBar.leftBlock = ^{
        [mySelf.yqNavigationController popYQViewControllerAnimated:YES];
    };
    
}

-(YQNavigationController *)yqNavigationController{
    return [YQNavigationController shareInstance];
}
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
//    LOG;
//    if([keyPath isEqualToString:@"title"]){
//        self.navigationBar.title = change[@"new"];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{

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
