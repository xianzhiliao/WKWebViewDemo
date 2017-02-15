//
//  PTWebProgressView.m
//  GrapeLife
//
//  Created by xianzhiliao on 2017/2/13.
//  Copyright © 2017年 Putao. All rights reserved.
//

#import "PTWebProgressView.h"

@interface PTWebProgressView()

@property (nonatomic, strong) UIProgressView *progressView;

@end

@implementation PTWebProgressView

#pragma mark - Life cycle

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.progressView];
//        [self.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.edges.equalTo(self);
//        }];
        self.progressView.frame = frame;
//        self.progressView.trackImage = [UIImage imageNamed:@"loading_webView"];
//        self.progressView.trackImage = [ui imageWithColor:[UIColor clearColor]];
    }
    return self;
}

- (void)dealloc{
    
}

#pragma mark - Properties

- (UIProgressView *)progressView{
    if (nil == _progressView) {
        UIProgressView *progressView = [[UIProgressView alloc]init];
        [progressView setProgressTintColor:[UIColor redColor]];
        self.progressView = progressView;
    }
    return _progressView;
}

#pragma mark - Public method

- (void)setProgressTintColor:(UIColor *)tintColor{
    [self.progressView setTintColor:tintColor];
}
- (void)setProgress:(float)progress animated:(BOOL)animated{
    [self.progressView setProgress:progress animated:animated];
}

@end
