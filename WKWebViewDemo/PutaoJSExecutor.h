//
//  PutaoJSExecutor.h
//  WKWebViewDemo
//
//  Created by xianzhiliao on 2017/2/8.
//  Copyright © 2017年 edu.self. All rights reserved.
//

#import <Foundation/Foundation.h>
@import WebKit;

NS_ASSUME_NONNULL_BEGIN

@interface PutaoJSExecutor : NSObject


+ (void)callJSFunction:(NSString *)aFunction withJSONObject:(NSDictionary *)aJsonObj inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;
//
+ (void)callJSFunctionOnMainThread:(NSString *)aFunction withJSONObject:(NSDictionary *)aJsonObj inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;
//
//+ (void)callJSFunctionOnMainThread:(NSString *)aFunction withJSONString:(NSString *)aJsonString inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;
//
//
//+ (void)callJSFunction:(NSString *)aFunction withArg:(NSString *)aArg inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;
//
//+ (void)callJSFunction:(NSString *)aFunction withJSONString:(NSString *)aJsonString inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;
//
//+ (void)callJSFunction:(NSString *)aFunction  inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;

+ (void)callJS:(NSString *)aJS inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;

+ (void)callJSOnMainThread:(NSString*)aJS inWebView:(WKWebView*)aWebView completionHandler:(void (^ _Nullable)(_Nullable id, NSError * _Nullable error))aCompletionHandler;


#pragma mark -
#pragma mark callbackJS

+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId withJSONObject:(NSDictionary *)aJsonObj;
+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId withJSONObject:(NSString *)aJsonObj;
//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId;
//+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId;


//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId jsonString:(NSString *)aJsonString;
//+ (void)callbackJSOnMainThread:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId jsonString:(NSString *)aJsonString;

//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId string:(NSString *)aString;
//+ (void)callbackJS:(WKWebView*)aWebview callbackId:(NSString *)aCallbackId unquotedString:(NSString *)aUnquotedString;

@end

NS_ASSUME_NONNULL_END
