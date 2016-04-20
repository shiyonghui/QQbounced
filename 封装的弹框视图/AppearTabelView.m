//
//  AppearTabelView.m
//  封装的弹框视图
//
//  Created by 施永辉 on 16/4/18.
//  Copyright © 2016年 style_施. All rights reserved.
//

#import "AppearTabelView.h"
#define  LeftView 10.0f
#define  TopToView 10.0f
@interface AppearTabelView ()<UITableViewDataSource,UITableViewDelegate>
/**
 存放数据数组
 */
@property (nonatomic,strong)NSArray * selectData;
/**
 存放图片数组
 */
@property (nonatomic,strong)NSArray * imageData;
/**
 点击的位置
 */
@property (nonatomic,strong)void(^action)(NSInteger indext);

@end
AppearTabelView * backgroundView;
UITableView * tableView;

@implementation AppearTabelView



+ (void)addAperaTabelViewWithWindowFrame:(CGRect)frame selectData:(NSArray *)selectData images:(NSArray *)images action:(void (^)(NSInteger indext))action animate:(BOOL)animate
{
    if (backgroundView != nil) {
        [AppearTabelView hiden];
    }
    //创建Window的视图 并把弹框视图添加到Window上去
    UIWindow * win = [[[UIApplication sharedApplication]windows]firstObject];
    backgroundView = [[AppearTabelView alloc]initWithFrame:win.bounds];
    backgroundView.action = action;
    backgroundView.selectData = selectData;
    backgroundView.imageData = images;
    backgroundView.backgroundColor =  [UIColor lightGrayColor];
    [win addSubview:backgroundView];
    //创建tableView
    tableView = [[UITableView alloc]initWithFrame:CGRectMake(  [UIScreen mainScreen].bounds.size.width - 80 , 70.0 -  20.0 * selectData.count , frame.size.width, 40 * selectData.count) style:0];
    tableView.delegate = backgroundView;
    tableView.dataSource = backgroundView;
    tableView.rowHeight = 40;//设置cell高度
    //定点
    tableView.layer.cornerRadius = 10.0f;
    tableView.layer.anchorPoint = CGPointMake(1.0, 0);
    tableView.transform = CGAffineTransformMakeScale( 0.0001, 0.0001);
    [win addSubview:tableView];
    
    //添加手势
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBakgroundClick)];
    [backgroundView addGestureRecognizer:tap];
    
    if (animate == YES) {
        backgroundView.alpha = 0;
        [UIView animateWithDuration:0.3 animations:^{
            backgroundView.alpha = 0.5;
            tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        }];
    }

}

//手势action
+ (void)tapBakgroundClick
{
    [AppearTabelView hiden];
    
}
//隐藏
+ (void)hiden
{
    if (backgroundView != nil) {
        
        [UIView animateWithDuration:0.3 animations:^{
            tableView.transform = CGAffineTransformMakeScale(0.000001, 0.0001);
        }completion:^(BOOL finished) {
            [backgroundView removeFromSuperview];
            [tableView removeFromSuperview];
            tableView = nil;
            backgroundView = nil;
        }
         ];
    }
}
#pragma      UITableViewDataSource,UITableViewDelegate
//设置行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _selectData.count;
}
//自定义cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * indentifier = @"id";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:indentifier];
    }
    cell.imageView.image = [UIImage imageNamed:self.imageData[indexPath.row]];
    cell.textLabel.text = _selectData[indexPath.row];
    return cell;
}
//点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.action) {
        self.action(indexPath.row);
    }
    [AppearTabelView hiden];
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect
{
    //设置背景色
    [[UIColor whiteColor]set];
    //拿到当前视图准备好的画板
    CGContextRef context = UIGraphicsGetCurrentContext();
    //利用path进行绘制三角形
    CGContextBeginPath(context);//标记
    CGFloat location = [UIScreen mainScreen].bounds.size.width;
    CGContextMoveToPoint(context,
                         location -  LeftView - 10, 70);//设置起点
    
    CGContextAddLineToPoint(context,
                            location - 2*LeftView - 10 ,  60);
    
    CGContextAddLineToPoint(context,
                            location - TopToView * 3 - 10, 70);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
}





@end
