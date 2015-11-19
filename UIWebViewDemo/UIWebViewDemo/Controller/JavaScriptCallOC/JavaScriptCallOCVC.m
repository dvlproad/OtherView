//
//  JavaScriptCallOCVC.m
//  UIWebViewDemo
//
//  Created by lichq on 15/11/19.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "JavaScriptCallOCVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface JavaScriptCallOCVC ()

@end

@implementation JavaScriptCallOCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    [self loadURL:[[NSURL alloc]initFileURLWithPath:htmlPath]];
    
#pragma mark - 参考：http://blog.csdn.net/j_akill/article/details/44463301
    JSContext *context = [self.webV  valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"jakilllog"] = ^() {
        NSLog(@"+++++++Begin Log+++++++");
        NSArray *args = [JSContext currentArguments];
        for (JSValue *jsVal in args) {
            NSLog(@"%@", jsVal);
        }
        JSValue *this = [JSContext currentThis];
        NSLog(@"this: %@",this);
        NSLog(@"-------End Log-------");
    };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
