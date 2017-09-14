//
//  LXAutoScrollerView.h
//
//  Created by 杨杰 on 2017/8/15.
//  Copyright © 2017年 goldMantis. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LXDirection) {
    LXHorizontal = 1,   //水平方向轮播
    LXVertical     //竖直方向轮播
};

@interface LXAutoScrollerView : UIScrollView

@property (nonatomic,strong) NSArray * _Nullable subArray;  //需要轮播的控件集合，需要注意顺序
@property (nonatomic,strong) NSArray * _Nullable images;  //轮播的图片数组 图片名称,url或者是UIImage 类型要统一
@property (nonatomic,strong) NSArray * _Nullable titles;  //轮播的文字数组

@property (nonatomic,assign) NSInteger interval;  //轮播的时间间隔
@property (nonatomic,assign) LXDirection direction;  //轮播的方向
@property (nonnull,copy) void (^didSubViewClickBlock)(NSInteger tag); //点击子控件的回调事件

@end
