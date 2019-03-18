//
//  XLStatusBarHUD.m
//  XLStatusBarHUD
//
//  Created by 刘晓良 on 16/1/3.
//  Copyright © 2016年 liuxiaoliang. All rights reserved.
//

#import "XLStatusBarHUD.h"


UIWindow *_window;
UIActivityIndicatorView *_indicatorView;

// 设备和相关尺寸
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height

#define isIphoneX_XS            (SCREEN_W == 375.f && SCREEN_H == 812.f ? YES : NO)
#define isIphoneXR_XSMax        (SCREEN_W == 414.f && SCREEN_H == 896.f ? YES : NO)
#define isiPhoneXSeries         (isIphoneX_XS || isIphoneXR_XSMax)

#define SafeAreaStatusBarHeight  (isiPhoneXSeries == YES ? 44 : 20)
#define SafeAreaTopHeight        (isiPhoneXSeries == YES ? 88 : 64)
#define SafeAreaTabHeight        (isiPhoneXSeries == YES ? 49 + 34 : 49)
#define SafeAreaBottomMargin     (isiPhoneXSeries == YES ? 34 : 0)

// 窗口的高度
#define XLWindowHeight 44
// 动画的执行时间
#define XLDuration 0.5
// 窗口的停留时间
#define XLDelay 1.5
// 字体大小
#define XLFont [UIFont systemFontOfSize:16]



@implementation XLStatusBarHUD
/**
 *  显示信息
 *  @param msg   文字内容
 *  @param image 图片对象
 */
+ (void)showMessage:(NSString *)msg image:(UIImage *)image
{
    
    if (_window) return;
    
    // 创建按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, SafeAreaStatusBarHeight, SCREEN_W, 44)];
    [btn setBackgroundColor:[UIColor clearColor]];
    // 设置按钮文字大小
    btn.titleLabel.font = XLFont;
    
    // 切掉文字左边的 10
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    // 设置数据
    [btn setTitle:msg forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

    [btn setImage:image forState:UIControlStateNormal];
    
    // 创建窗口
    _window = [[UIWindow alloc] init];
    // 窗口背景
    _window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = CGRectMake(0, -SafeAreaTopHeight, SCREEN_W, SafeAreaTopHeight);
    _window.layer.cornerRadius = 5;
    _window.layer.masksToBounds = YES;
    [_window addSubview:btn];
    _window.hidden = NO;
    
    // 状态栏 也是一个window
    // UIWindowLevelAlert > UIWindowLevelStatusBar > UIWindowLevelNormal
    
    // 动画
    [UIView animateWithDuration:XLDuration animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    }completion:^(BOOL finished) {
        
        [self hideLoading];
    }];
}
/**
 *  显示信息
 *
 *  @param msg       文字内容
 *  @param imageName 图片名称
 */
+ (void)showMessage:(NSString *)msg imageName:(NSString *)imageName
{
    [self showMessage:msg image:[UIImage imageNamed:imageName]];
}
/**
 *  显示成功信息
 *
 *  @param msg 文字信息
 */
+ (void)showSuccess:(NSString *)msg
{
    [self showMessage:msg imageName:@"XLStatusBarHUD.bundle/success"];
}

/**
 *  显示失败信息
 *
 *  @param msg 文字信息
 */
+ (void)showError:(NSString *)msg
{
    [self showMessage:msg imageName:@"XLStatusBarHUD.bundle/error"];
}

/**
 *  隐藏窗口
 */
+ (void)hideLoading
{
    // 动画
    [UIView animateWithDuration:XLDuration delay:XLDelay options:kNilOptions animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = -SafeAreaTopHeight;
        _window.frame = frame;
    } completion:^(BOOL finished) {
        _window = nil;
    }];

}

/**
 *  显示登录
 *
 *  @param msg 文字信息
 */
+ (void)showLoading:(NSString *)msg
{
    
    if (_window) return;
    
    // 创建窗口
    _window = [[UIWindow alloc] init];
    // 窗口背景
    _window.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    _window.windowLevel = UIWindowLevelAlert;
    _window.frame = CGRectMake(0, -SafeAreaTopHeight, SCREEN_W, SafeAreaTopHeight);
    _window.hidden = NO;
    _window.layer.cornerRadius = 5;
    _window.layer.masksToBounds = YES;
    
   
    
    // 圈圈
    _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [_indicatorView startAnimating];
    _indicatorView.frame = CGRectMake(SCREEN_W * 0.3, SafeAreaStatusBarHeight, XLWindowHeight, XLWindowHeight);
    [_window addSubview:_indicatorView];
    
    // 文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(_indicatorView.frame), SafeAreaStatusBarHeight, 200, XLWindowHeight)];
    label.backgroundColor = [UIColor clearColor];
    label.font = XLFont;
    label.text = msg;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentLeft;
    [_window addSubview:label];
    
    // 动画
    [UIView animateWithDuration:XLDuration animations:^{
        CGRect frame = _window.frame;
        frame.origin.y = 0;
        _window.frame = frame;
    }completion:^(BOOL finished) {
        [self hideLoading];
    }];
}
@end
