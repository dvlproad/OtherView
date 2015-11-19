//
//  CJWebViewController.m
//  CJRefreshVCDemo
//
//  Created by lichq on 15/11/2.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import "CJWebViewController.h"

@interface CJWebViewController ()

@end

@implementation CJWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"Web的标题", nil);
}

- (void)loadURL:(NSURL *)URL{
    //URL = [NSURL URLWithString:@"http://www.baidu.com"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    [self.webV loadRequest:request];
    [self.webV setDelegate:self];
    
    if (self.webV) {
        self.progressHUD = [MBProgressHUD showHUDAddedTo:self.webV animated:YES];
        //①：不使用self.navigationController.view，因为想要使得导航栏可以点击
        //不应该放到webViewDidStartLoad中创建，这是为什么？
        self.progressHUD.delegate = self;
    }else{
        NSLog(@"未设置webV，请设置");
    }
    
}


- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.progressHUD removeFromSuperview];
	self.progressHUD = nil;
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    //NSLog(@"didFailLoadWithError:%@", error);
    [self.progressHUD hide:YES];
}

- (void)webViewDidStartLoad:(UIWebView *)webView{
    //NSLog(@"webViewDidStartLoad");
    /*
     UIWindow *window = [[UIApplication sharedApplication].delegate window];
     self.progressHUD = [[MBProgressHUD alloc] initWithView:window];
     [self.progressHUD setMode:MBProgressHUDModeCustomView];
     [self.progressHUD setCustomView:self.totalPositionView];
     [self.progressHUD setMargin:0];
     [self.progressHUD setDimBackground:YES];
     [window addSubview:self.progressHUD];
     [self.progressHUD show:YES];
     */
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    //NSLog(@"webViewDidFinishLoad");
    [self.progressHUD hide:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
