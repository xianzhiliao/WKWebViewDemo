//
//  PTWebProgressView.h
//  GrapeLife
//
//  Created by xianzhiliao on 2017/2/13.
//  Copyright © 2017年 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTWebProgressView : UIView

- (void)setProgressTintColor:(UIColor *)tintColor;
- (void)setProgress:(float)progress animated:(BOOL)animated;

@end
