//
//  Booker.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "Booker.h"

@implementation Booker

- (void)LXZWebViewController:(LXZWebViewController *)webViewController callSelector:(SEL)selector object:(id)object{
    [self performSelectorSafetyWithArgs:selector,object];
}

- (void)saveBooker:(id)object{
    NSLog(@"saveBooker");
}

@end
