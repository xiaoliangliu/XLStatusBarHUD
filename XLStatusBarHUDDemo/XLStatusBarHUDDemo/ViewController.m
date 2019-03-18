//
//  ViewController.m
//  XLStatusBarHUD
//
//  Created by 刘晓良 on 16/1/3.
//  Copyright © 2016年 liuxiaoliang. All rights reserved.
//

#import "ViewController.h"
#import "XLStatusBarHUD.h"

@interface ViewController ()
- (IBAction)showSuccess;
- (IBAction)showError;
- (IBAction)showLoding;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showSuccess {
    [XLStatusBarHUD showMessage:@"保存成功!!!" imageName:@"XLStatusBarHUD.bundle/success"];
}

- (IBAction)showError {
    [XLStatusBarHUD showMessage:@"保存失败!!!" imageName:@"XLStatusBarHUD.bundle/error"];
}

- (IBAction)showLoding {
    
    [XLStatusBarHUD showLoading:@"正在加载..."];
    
    
}






@end
