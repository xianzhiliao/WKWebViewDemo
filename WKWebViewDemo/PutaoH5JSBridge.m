//
//  Booker.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "PutaoH5JSBridge.h"

@implementation PutaoH5JSBridge

- (void)webViewController:(LXZWebViewController *)webViewController saveContacts:(NSDictionary *)params callBack:(NSString *)callBack{
    NSLog(@"saveContacts");
    NSString *name = [params objectForKey:@"name"];
    NSString *phone = [params objectForKey:@"phone"];
    NSString *msg = [NSString stringWithFormat:@"姓名：%@,电话：%@",name,phone];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"js call native success" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        NSDictionary *result = @{@"result_code":@(0),@"msg":@"saveContacts success",@"data":@{@"name":name,@"phone":phone}};
        [webViewController onCallBackJsId:callBack result:result];
    }];
    [alertVC addAction:sureAction];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [[nav.viewControllers lastObject] presentViewController:alertVC animated:YES completion:^{
        
    }];
}

@end
