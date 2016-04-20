//
//  ViewController.m
//  封装的弹框视图
//
//  Created by 施永辉 on 16/4/18.
//  Copyright © 2016年 style_施. All rights reserved.
//

#import "ViewController.h"
#import "AppearTabelView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建一个按钮
    UIButton * bt = [UIButton buttonWithType:UIButtonTypeSystem];
    bt.frame = CGRectMake(10, 200, 100, 40);
    [bt setTitle:@"弹出视图" forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [bt setTintColor:[UIColor whiteColor]];
    [bt setBackgroundColor:[UIColor lightGrayColor]];
    [self.view addSubview:bt];
}
- (void)click
{
    [AppearTabelView addAperaTabelViewWithWindowFrame:CGRectMake(self.view.bounds.size.width-100, 64, 150, 200) selectData:@[@"扫一扫",@"加好友",@"创建讨论组",@"发送到电脑",@"面对面快传",@"收钱"] images:@[@"saoyisao.png",@"jiahaoyou.png",@"taolun.png",@"diannao.png",@"diannao.png",@"shouqian.png"] action:^(NSInteger index) {
        NSLog(@"%ld",index);    } animate:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
