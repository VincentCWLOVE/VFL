//
//  ViewController.m
//  VFL_2
//
//  Created by vincent on 15/8/10.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //根据屏幕的宽度，计算view的宽度和高度
    CGFloat width = ([[UIScreen mainScreen] bounds].size.width-2*10-4*15)/5;
    CGFloat height = width;
    
    //固定第一个view
    UIView *firstView = [UIView new];
    firstView.backgroundColor = [UIColor blackColor];
    // 将次属性设置为NO,表示将使用AutoLayout的方式来布局
    firstView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:firstView];
    
    //------使用VFL为第一个view添加约束------
    //在水平方向上，让firstview的左边与父视图的左边间隔10px,且自身宽度为width
    NSArray *constraints1 = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[firstView(==width)]" options:0 metrics:@{@"width":@(width)} views:NSDictionaryOfVariableBindings(firstView)];
    //在垂直方向上，让firstView的上边与父视图的上边间隔100px,且自身的高度为height
    NSArray *constraints2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[firstView(==height)]" options:0 metrics:@{@"height":@(height)} views:NSDictionaryOfVariableBindings(firstView)];
    [self.view addConstraints:constraints1];
    [self.view addConstraints:constraints2];
    
    //定义一个颜色数组
    NSArray *colors = @[[UIColor redColor],[UIColor orangeColor],[UIColor yellowColor],[UIColor blueColor]];
    //定义一个views数组
    NSMutableArray *views = [NSMutableArray array];
    [views addObject:firstView];
    for (int i = 0; i < 4; i++) {
        UIView *view = [UIView new];
        view.backgroundColor = colors[i];
         view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view addSubview:view];
        [views addObject:view];
    }
    
    //依次给views数组中的view使用vfl添加约束
    for (int i = 1; i < views.count; i++) {
        UIView *view1 = views[i-1];
        UIView *view2 = views[i];
        NSDictionary *bindings = NSDictionaryOfVariableBindings(view1,view2);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[view1]-15-[view2(==width)]" options:0 metrics:@{@"width":[NSNumber numberWithFloat:width]} views:bindings];
        [self.view addConstraints:constraints];
        
    }
    UIView *view1 = views[0];
    for (int i = 0; i < views.count; i++) {
        UIView *view2 = views[i];
        NSDictionary *bindings = NSDictionaryOfVariableBindings(view1,view2);
        NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-100-[view2(==view1)]" options:0 metrics:nil views:bindings];
        [self.view addConstraints:constraints];
        
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
