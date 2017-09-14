//
//  ViewController.m
//  example
//
//  Created by 杨杰 on 2017/9/14.
//  Copyright © 2017年 goldMantis. All rights reserved.
//

#import "ViewController.h"
#import "LXAutoScrollerView.h"
#import <Masonry.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //通过文字创建轮播
    LXAutoScrollerView *scrollerView = [[LXAutoScrollerView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, 50)];
    [self.view addSubview:scrollerView];
    scrollerView.direction = LXVertical;
    scrollerView.interval = 2;
    scrollerView.titles = @[@"干啥呢",@"你好",@"hello"];
    
    
//    //通过图片名称创建轮播
//    LXAutoScrollerView *scrollerView1 = [[LXAutoScrollerView alloc] initWithFrame:CGRectMake(0, 150, self.view.bounds.size.width, 250)];
//    [self.view addSubview:scrollerView1];
//    scrollerView1.direction = LXHorizontal;
//    scrollerView1.interval = 2;
//    scrollerView1.images = @[@"1",@"2",@"3",@"4",@"5"];
    
//    //通过图片创建
//    LXAutoScrollerView *scrollerView2 = [[LXAutoScrollerView alloc] initWithFrame:CGRectMake(0, 400, self.view.bounds.size.width, 250)];
//    [self.view addSubview:scrollerView2];
//    scrollerView2.direction = LXHorizontal;
//    
//    NSMutableArray *array_m = [NSMutableArray array];
//    for (int i = 0; i < 5; i++) {
//        UIImageView *imageView = [[UIImageView alloc] init];
//        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]];
//        [array_m addObject:imageView];
//    }
//    
//    scrollerView2.subArray = array_m.copy;
//    scrollerView2.interval = 2;
    
    
    
    //通过URL创建
     //1. 创建图片链接数组
//        NSMutableArray *photoArr = [NSMutableArray array];
//        // 添加图片链接
//        for (int i = 0; i < 9; i++) {
//            // 图片链接
//            NSString *imageUrl = [NSString stringWithFormat:@"https://raw.githubusercontent.com/xxlololo/xxlololoImage/master/image/image0%d.jpg", i + 1];
//            // 添加图片链接到数组中
//            [photoArr addObject:imageUrl];
//        }
//    
//    //通过图URL称创建轮播
//    LXAutoScrollerView *scrollerView2 = [[LXAutoScrollerView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250)];
//    [self.view addSubview:scrollerView2];
//    scrollerView2.direction = LXHorizontal;
//    scrollerView2.interval = 2;
//    scrollerView2.images = photoArr.copy;
    
    
    //通过子控件数组创建
    
    LXAutoScrollerView *scrollerView2 = [[LXAutoScrollerView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 250)];
    [self.view addSubview:scrollerView2];
    scrollerView2.direction = LXHorizontal;
    scrollerView2.interval = 2;

    NSMutableArray *array_m = [NSMutableArray array];
    for (int i = 1 ; i< 6 ; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
        [array_m addObject:imageView];
    }
    
    scrollerView2.subArray = array_m.copy;
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
