//
//  Booker.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "Booker.h"

@implementation Booker

- (void)saveContacts:(LXZWebViewController *)webViewConrtroller arguments:(id)object{
    NSLog(@"saveContacts");
    NSString *name = [object objectForKey:@"name"];
    NSString *phone = [object objectForKey:@"phone"];
    NSNumber *callbackValue = [object objectForKey:@"callbackId"];
    NSString *callBackId = [callbackValue stringValue];
    NSString *msg = [NSString stringWithFormat:@"姓名：%@,电话：%@",name,phone];
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"js call native success" message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"点击确定");
        [webViewConrtroller onCallBackJsId:callBackId jsonStr:@"{message:成功}"];
    }];
    [alertVC addAction:sureAction];
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [[nav.viewControllers lastObject] presentViewController:alertVC animated:YES completion:^{
        
    }];
}

@end
