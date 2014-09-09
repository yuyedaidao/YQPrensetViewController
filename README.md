
YQPrensetViewController
=======================

##带导航的弹出视图控制器

###使用说明

#### 显示

      YQNavigationController *nav = [[YQNavigationController alloc] initWithSize:CGSizeMake(250, 300) rootViewController:nil];
      RootViewController *root = [[RootViewController alloc] init];
      nav.rootViewController = root;
      root.title = @"root";
      [nav show:YES animated:YES];
      
#### push&pod

     __weak typeof(self) my = self;
    [self.navigationBar setLeftBlock:^{
        [my.yqNavigationController popYQViewControllerAnimated:YES];
    }];
    
    self.navigationBar.rightTitle = @"other";
    [self.navigationBar setRightBlock:^{
        OtherViewController *other = [[OtherViewController alloc] init];
        [my.yqNavigationController pushYQViewController:other animated:YES];
    }];
    
    
  *要推出的新视图只要继承YQViewController就可以了*
  
  *导航栏左标题如果不设置自动显示上一层视图控制器标题，初始时显示“取消”*
  
### 如图
![gif](https://github.com/yuyedaidao/YQPrensetViewController/blob/master/present.gif)
