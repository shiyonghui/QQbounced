//
//  AppearTabelView.h
//  封装的弹框视图
//
//  Created by 施永辉 on 16/4/18.
//  Copyright © 2016年 style_施. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppearTabelView : UIView

/**
 *   创建一个弹出下拉控件
 *
 *  @param   frame       尺寸
 *  @param   selectData  选择控件的数据源
 *  @param   action      点击回调的方法
 *  @param   animate     是否动画弹出
 *
 */
+ (void)addAperaTabelViewWithWindowFrame:(CGRect)frame
                              selectData:(NSArray *)selectData
                                  images:(NSArray *)images
                                  action:(void(^)(NSInteger index))action
                                 animate:(BOOL)animate;

/**
 *   手动隐藏
 */
+ (void)hiden;

@end
