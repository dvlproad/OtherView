//
//  ViewController.m
//  UIWebViewDemo
//
//  Created by lichq on 15/11/19.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "ViewController.h"

//小型的网页浏览器，具有前进、后退、刷新、分享等功能，并且具有加载进度条。
#import <TOWebViewController/TOWebViewController.h>

//OC调用JavaScript
#import "OCCallJavaScriptVC.h"

//JavaScript调用OC
#import "JavaScriptCallOCVC.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = NSLocalizedString(@"首页", nil);
}

//小型的网页浏览器，具有前进、后退、刷新、分享等功能，并且具有加载进度条。
- (IBAction)goTOWebViewController:(id)sender{
    NSURL *URL = [NSURL URLWithString:@"http://www.baidu.com/"];
    TOWebViewController *vc = [[TOWebViewController alloc]initWithURL:URL];
    [self.navigationController pushViewController:vc animated:YES];
}

//OC调用JavaScript
- (IBAction)goOCCallJavaScriptVC:(id)sender{
    OCCallJavaScriptVC *vc = [[OCCallJavaScriptVC alloc]initWithNibName:@"OCCallJavaScriptVC" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

//JavaScript调用OC
- (IBAction)goJavaScriptCallOCVC:(id)sender{
    JavaScriptCallOCVC *vc = [[JavaScriptCallOCVC alloc]initWithNibName:@"JavaScriptCallOCVC" bundle:nil];
    vc.title = [sender titleForState:UIControlStateNormal];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
