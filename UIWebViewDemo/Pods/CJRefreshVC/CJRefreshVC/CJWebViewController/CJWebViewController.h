//
//  CJWebViewController.h
//  CJRefreshVCDemo
//
//  Created by lichq on 15/11/2.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface CJWebViewController : UIViewController<UIWebViewDelegate,MBProgressHUDDelegate>{
    
}
@property(nonatomic, strong) IBOutlet UIWebView *webV;
@property(nonatomic, strong) MBProgressHUD *progressHUD;

- (void)loadURL:(NSURL *)URL;

@end
