//
//  PTWebView.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/13.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "PTWebView.h"

@implementation PTWebView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [self initWithFrame:frame configuration:[[self class] messageManager].config];
    self.UIDelegate = [[self class]messageManager];
    self.navigationDelegate =  [[self class]messageManager];
    [self addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew| NSKeyValueObservingOptionOld context:nil];
    self.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    self.scrollView.clipsToBounds = NO;
    self.scrollView.minimumZoomScale = 1.0;
    self.scrollView.maximumZoomScale = 1.0;
    self.scrollView.alwaysBounceHorizontal = NO;
    self.scrollView.scrollEnabled = YES;
    return self;
}

- (void)dealloc{
    [self removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - Properties

+ (PTWebViewMessageManager *)messageManager{
    return [PTWebViewMessageManager sharedInstance];
}

+ (NSURLRequest *)defaultRequestConfigWithURL:(NSURL *)url{
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30];
    return request;
}

- (PTWebProgressView *)progressView{
    if (nil == _progressView) {
        self.progressView = [[PTWebProgressView alloc]init];
    }
    return _progressView;
}

#pragma mark - Observer

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    NSLog(@" %s,change = %@",__FUNCTION__,change);
    if ([keyPath isEqual: @"estimatedProgress"] && object == self) {
        [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [self.progressView setAlpha:1.0f];
        } completion:^(BOOL finished) {
            [self.progressView setProgress:self.estimatedProgress animated:YES];
        }];
        
        if(self.estimatedProgress >= 1.0f)
        {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
