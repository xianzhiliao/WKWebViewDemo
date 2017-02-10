//
//  PutaoJSExecutor.m
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import "PutaoJSExecutor.h"

@implementation PutaoJSExecutor



#pragma mark -- Call js

+ (void)callJSFunction:(NSString*)aFunction withJSONObject:(NSDictionary*)aJsonObj inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
{
    NSString *json = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:aJsonObj options:0 error:nil] encoding:NSUTF8StringEncoding];
    if (!json)
    {
        NSError* err = [[NSError alloc] initWithDomain:@"CallJSFunction Json Error" code:-1 userInfo:nil];
        aCompletionHandler(nil, err);
        return ;
    }
    
    NSString *js = [[NSString alloc] initWithFormat:@"%@(%@)", aFunction, json];
    
    if (js)
    {
         [self callJS:js inWebView:aWebView completionHandler:aCompletionHandler];
    }
}
+ (void)callJSFunctionOnMainThread:(NSString*)aFunction withJSONObject:(NSDictionary*)aJsonObj inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self callJSFunction:aFunction withJSONObject:aJsonObj inWebView:aWebView completionHandler:aCompletionHandler];
    });
}
//
//+ (void)callJSFunctionOnMainThread:(NSString*)aFunction withJSONString:(NSString*)aJsonString inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"%@(%@)", aFunction, aJsonString];
//    if (js)
//    {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            [aWebView evaluateJavaScript:js completionHandler:aCompletionHandler];
//        });
//    }
//}
//
//+ (void)callJSFunction:(NSString*)aFunction withArg:(NSString *)aArg inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"%@(%@)", aFunction, aArg];
//    [aWebView evaluateJavaScript:js completionHandler:aCompletionHandler];
//}
//
//+ (void)callJSFunction:(NSString*)aFunction withJSONString:(NSString *)aJsonString inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"%@(%@)", aFunction, aJsonString];
//    [self callJS:js inWebView:aWebView completionHandler:aCompletionHandler];
//}
//
//+ (void)callJSFunction:(NSString*)aFunction  inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"%@()", aFunction];
//    [aWebView evaluateJavaScript:js completionHandler:aCompletionHandler];
//}

+ (void)callJS:(NSString*)aJS inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
{
    [aWebView evaluateJavaScript:aJS completionHandler:aCompletionHandler];
}

+ (void)callJSOnMainThread:(NSString*)aJS inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aWebView evaluateJavaScript:aJS completionHandler:aCompletionHandler];
    });
}


#pragma mark - Native callBack

+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId withJSONObject:(NSDictionary *)aJsonObj{
    NSString *js = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:aJsonObj options:0 error:nil] encoding:NSUTF8StringEncoding];
    [self callbackJS:aWebview callbackId:aCallbackId jsonString:js];
}
+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId withJSONObject:(NSString *)aJsonObj{
    NSString *js = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:aJsonObj options:0 error:nil] encoding:NSUTF8StringEncoding];
    [self callbackJSOnMainThread:aWebview callbackId:aCallbackId jsonString:js];
}

//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@)", aCallbackId];
//    [self callJS:js inWebView:aWebview completionHandler:nil];
//}

//+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@)", aCallbackId];
//    [self callJSOnMainThread:js inWebView:aWebview completionHandler:nil];
//}

+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId jsonString:(NSString *)aJsonString
{
    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@, %@)", aCallbackId, aJsonString];
    [self callJS:js inWebView:aWebview completionHandler:nil];
}

+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId jsonString:(NSString *)aJsonString
{
    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@, %@)", aCallbackId, aJsonString];
    [self callJSOnMainThread:js inWebView:aWebview completionHandler:nil];
}

//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId string:(NSString *)aString
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@, \"%@\")", aCallbackId, aString];
//    [self callJS:js inWebView:aWebview completionHandler:nil];
//}

//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId unquotedString:(NSString *)aUnquotedString;
//{
//    NSString *js = [[NSString alloc] initWithFormat:@"onCallBack(%@, %@)", aCallbackId, aUnquotedString];
//    [self callJS:js inWebView:aWebview completionHandler:nil];
//}

@end
