//
//  LXAutoScrollerView.m
//
//  Created by 杨杰 on 2017/8/15.
//  Copyright © 2017年 goldMantis. All rights reserved.
//

#import "LXAutoScrollerView.h"
#import "UIImageView+WebCache.h"
@interface LXAutoScrollerView ()<UIScrollViewDelegate>
@property (nonatomic,assign) BOOL isNext;
@property (nonatomic,assign) CGFloat lastOffset;
@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSInteger maxTAG; //当子控件数量少于3的时候
@end

@implementation LXAutoScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.delegate = self;
        self.index = 1;
        self.pagingEnabled = YES;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (void)setImages:(NSArray *)images{
    _images = images;
    
    NSMutableArray *array_M = [NSMutableArray array];
    if ([images.lastObject isKindOfClass:[UIImage class]]) {
        for (UIImage *image in images) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = image;
            [array_M addObject:imageView];
        }
        self.subArray = array_M.copy;
    }else{

        for (int i = 0; i < images.count; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            if ([self isUrlString:images[i]]) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:images[i]]];
            }else {
                imageView.image = [UIImage imageNamed:images[i]];
            }
             [array_M addObject:imageView];
        }
        self.subArray = array_M.copy;
    }
    
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    
     NSMutableArray *array_M = [NSMutableArray array];
    for (NSString *string in titles) {
        UILabel *label = [[UILabel alloc] init];
        //TODO  设置label的文字颜色字体大小
        label.text = string;
        [array_M addObject:label];
    }
    
    self.subArray = array_M.copy;
}

- (void)setInterval:(NSInteger)interval{
    
    if (interval == 0) {
        return;
    }
    
    NSAssert(self.direction > 0, @"设置时间间隔前务必要先设置滚动方向");
    
        _interval = interval;
    
    if (self.direction == LXHorizontal) {
        
        self.timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(didHorizontalAnimation) userInfo:nil repeats:YES];
        
    }else{
        
        self.timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(didVerticalAnimation) userInfo:nil repeats:YES];
        
    }
    
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)didHorizontalAnimation {
    [self setContentOffset:CGPointMake(2 * self.bounds.size.width, 0) animated:YES];
}

- (void)didVerticalAnimation {
    [self setContentOffset:CGPointMake(0, 2 * self.bounds.size.height) animated:YES];
}



- (void)setSubArray:(NSArray *)subArray{
    _subArray = subArray;

    [self layoutIfNeeded];
    NSAssert(self.bounds.size.width > 0 && self.bounds.size.height > 0, @"在设置内容视图前需要先布局或者是设置frame");
    
    self.maxTAG = subArray.count;
    
    if (self.direction == LXHorizontal) {
        
        if (subArray.count > 2) {
            
            for (int i = 0; i < subArray.count; i++) {
                UIView *view = subArray[i];
                view.frame = CGRectMake(((i + 1) % subArray.count) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            
            self.contentSize = CGSizeMake(subArray.count * self.bounds.size.width,0);
            self.contentOffset = CGPointMake(self.bounds.size.width,0);
            
        }else if(subArray.count == 2){
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:subArray];
            [array addObject:[self copyView:self.subArray[0]]];
            [array addObject:[self copyView:self.subArray[1]]];
            self.subArray = array.copy;
            for (int i = 0; i < array.count; i++) {
                UIView *view = array[i];
                view.frame = CGRectMake(((i + 1) % array.count) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            
            self.contentSize = CGSizeMake(3 * self.bounds.size.width,0);
            self.contentOffset = CGPointMake(self.bounds.size.width,0);
            
        }else if(subArray.count == 1){
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:subArray];
            [array addObject:[self copyView:self.subArray[0]]];
            [array addObject:[self copyView:self.subArray[0]]];
            self.subArray = array.copy;
            
            for (int i = 0; i < array.count; i++) {
                UIView *view = array[i];
                view.frame = CGRectMake(((i + 1) % array.count) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            
            self.contentSize = CGSizeMake(4 * self.bounds.size.width,0);
            self.contentOffset = CGPointMake(self.bounds.size.width,0);
            
        }
    }else{
        
        if (subArray.count > 2) {
            
            for (int i = 0; i < subArray.count; i++) {
                UIView *view = subArray[i];
                view.frame = CGRectMake(0, ((i + 1) % subArray.count) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            
            self.contentSize = CGSizeMake(0, subArray.count * self.bounds.size.height);
            self.contentOffset = CGPointMake(0, self.bounds.size.height);
            
            
        }else if(subArray.count == 2){
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:subArray];
            [array addObject:[self copyView:self.subArray[0]]];
            [array addObject:[self copyView:self.subArray[1]]];
            _subArray = array.copy;
            
            for (int i = 0; i < array.count; i++) {
                UIView *view = array[i];
                view.frame = CGRectMake(0, ((i + 1) % array.count) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            
            self.contentSize = CGSizeMake(0, 4 * self.bounds.size.height);
            self.contentOffset = CGPointMake(0, self.bounds.size.height);
            
            
        }else if(subArray.count == 1){
            
            NSMutableArray *array = [NSMutableArray arrayWithArray:subArray];
            [array addObject:[self copyView:self.subArray[0]]];
            [array addObject:[self copyView:self.subArray[0]]];
            _subArray = array.copy;
            for (int i = 0; i < array.count; i++) {
                UIView *view = array[i];
                view.frame = CGRectMake(0, ((i + 1) % array.count) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
                [self addSubview:view];
            }
            self.contentSize = CGSizeMake(0, 3 * self.bounds.size.height);
            self.contentOffset = CGPointMake(0, self.bounds.size.height);
            
        }
    }
    
    for (int i = 0; i < _subArray.count; i++) {
        UIView *view = _subArray[i];
        view.tag = i;
        view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didtapSubView:)];
        [view addGestureRecognizer:tap];
    }
    
}

- (void)didtapSubView:(UITapGestureRecognizer *)recognizer {
    
    if (self.didSubViewClickBlock) {
        self.didSubViewClickBlock(recognizer.view.tag % self.maxTAG);
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if(self.direction == 1){
        
        if (scrollView.contentOffset.x - self.lastOffset > 0) {
            self.isNext = YES;
        }else if(scrollView.contentOffset.x - self.lastOffset < 0){
            self.isNext = NO;
        }
        
    }else{
        
        if (scrollView.contentOffset.y - self.lastOffset > 0) {
            self.isNext = YES;
        }else if(scrollView.contentOffset.y - self.lastOffset < 0){
            self.isNext = NO;
        }
    }
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if(self.direction == 1){
        
        NSInteger num = scrollView.contentOffset.x / self.bounds.size.width - 1;
        
        if (scrollView.contentOffset.x == scrollView.bounds.size.width) {
            return;
        }
        
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width,0)];
        self.lastOffset = (CGFloat)scrollView.bounds.size.width;
        
        NSInteger index;
        if (!self.isNext) {
            index = (self.index + 1) % self.subArray.count;
        }else{
            index = (self.index + self.subArray.count - num) % self.subArray.count;
        }
        
        for (int i = 0 ; i< self.subArray.count; i++) {
            ((UIView *)self.subArray[i]).frame = CGRectMake(((i+ index) % self.subArray.count) * self.bounds.size.width, 0, self.bounds.size.width, self.bounds.size.height);
        }
        
        self.index = index;
        
    }else{
        
        NSInteger num = scrollView.contentOffset.y / self.bounds.size.height - 1;
        
        if (scrollView.contentOffset.y == scrollView.bounds.size.height) {
            return;
        }
        
        [scrollView setContentOffset:CGPointMake(0, scrollView.bounds.size.height)];
        self.lastOffset = (CGFloat)scrollView.bounds.size.height;
        
        NSInteger index;
        if (!self.isNext) {
            index = (self.index + 1) % self.subArray.count;
        }else{
            index = (self.index + self.subArray.count - num) % self.subArray.count;
        }
        
        for (int i = 0 ; i< self.subArray.count; i++) {
            ((UIView *)self.subArray[i]).frame = CGRectMake(0, ((i+ index) % self.subArray.count) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        }
        
        self.index = index;
        
    }
    
    
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if(self.direction == 1){
        
        if (scrollView.contentOffset.x == scrollView.bounds.size.width) {
            return;
        }
        
        [scrollView setContentOffset:CGPointMake(scrollView.bounds.size.width,0)];
        self.lastOffset = (CGFloat)scrollView.bounds.size.width;
        
        NSInteger index;
        if (!self.isNext) {
            index = (self.index + 1) % self.subArray.count;
        }else{
            index = (self.index + self.subArray.count - 1) % self.subArray.count;
        }
        
        for (int i = 0 ; i< self.subArray.count; i++) {
            ((UIView *)self.subArray[i]).frame = CGRectMake( ((i + index) % self.subArray.count) * self.bounds.size.width, 0 , self.bounds.size.width, self.bounds.size.height);
        }
        
        self.index = index;
        
    }else{
        
        if (scrollView.contentOffset.y == scrollView.bounds.size.height) {
            return;
        }
        
        [scrollView setContentOffset:CGPointMake(0, scrollView.bounds.size.height)];
        self.lastOffset = (CGFloat)scrollView.bounds.size.height;
        
        NSInteger index;
        if (!self.isNext) {
            index = (self.index + 1) % self.subArray.count;
        }else{
            index = (self.index + self.subArray.count - 1) % self.subArray.count;
        }
        
        for (int i = 0 ; i< self.subArray.count; i++) {
            ((UIView *)self.subArray[i]).frame = CGRectMake(0, ((i + index) % self.subArray.count) * self.bounds.size.height, self.bounds.size.width, self.bounds.size.height);
        }
        
        self.index = index;
        
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    self.interval = self.interval;
}


//归档与反归档复制View
- (UIView *)copyView:(UIView *)view{
    NSData * tempArchive = [NSKeyedArchiver archivedDataWithRootObject:view];
    return [NSKeyedUnarchiver unarchiveObjectWithData:tempArchive];
}


- (BOOL)isUrlString:(NSString *)string {

    NSString *emailRegex = @"[a-zA-z]+://.*";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:string];
    
}




@end
