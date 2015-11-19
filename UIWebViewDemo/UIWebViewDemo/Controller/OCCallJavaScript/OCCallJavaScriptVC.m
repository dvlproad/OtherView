//
//  OCCallJavaScriptVC.m
//  UIWebViewDemo
//
//  Created by lichq on 15/11/19.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "OCCallJavaScriptVC.h"
#pragma mark - 参考①：uiwebview与js交互（http://www.cnblogs.com/pengyingh/articles/2350304.html）

@interface OCCallJavaScriptVC ()

@end

@implementation OCCallJavaScriptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    /*
    //示例①：用百度，进行默认搜索的测试
    [self loadURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://m.baidu.com/"]]];
    */
    
    //示例②：用http://577jp9.com/a2042/，进行默认登录的测试。（如果无效，请改为用百度测试默认搜索）
    [self loadURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://577jp9.com/a2042/"]]];
    
    isFirstLoadWeb = YES;
}


/*
// 设置cookies 自动登录
- (void)setCookies {
    //NSString *uid = [[NSUserDefaults standardUserDefaults] objectForKey:kUID];
    AccountInfo *uinfo = [AccountInfo loadCustomObject];
    
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage setCookie:[self getCookieName:@"loginname" value:uinfo.name]];
    [cookieStorage setCookie:[self getCookieName:@"nickname" value:@""]];
    [cookieStorage setCookie:[self getCookieName:@"appid" value:@""]];
    [cookieStorage setCookie:[self getCookieName:@"uuid" value:uinfo.uid]];
    [cookieStorage setCookie:[self getCookieName:@"app_sid" value:@""]];
}

- (NSHTTPCookie *)getCookieName:(NSString *)name value:(NSString *)value {
    NSDictionary *cookieInfo = @{NSHTTPCookieValue  : value,
                                 NSHTTPCookieName   : name,
                                 NSHTTPCookiePath   : @"/",
                                 NSHTTPCookieDomain : @".lemonade-game.com"
                                 };
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieInfo];
    return cookie;
}
*/


- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [super webViewDidFinishLoad:webView];
    
    //程序会一直调用该方法，所以判断若是第一次加载才使用我们自己定义的js，此后不在调用JS
    if (isFirstLoadWeb == NO) {
        return;
    }
    isFirstLoadWeb = NO;
    
    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    NSLog(@"currentURL = %@, title = %@", currentURL, title);
    //登录时候：currentURL = http://577jp9.com/a2042/index.php?g=App&m=Member&a=login，title = 登录
    
    
    //给webview添加一段自定义的javascript
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
        "script.type = 'text/javascript';"
        "script.text = \"function myFunction() { "
            //注意这里的Name为搜索引擎的Name,不同的搜索引擎使用不同的Name
     
            /*
            //>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>示例①：用百度，进行默认搜索的测试>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>//
            //<input type="text" name="word" maxlength="64" size="20" id="word"/> 百度手机端代码
            "var field_word = document.getElementsByName('word')[0];"
            "field_word.value='OC调用JavaScript';"    //给变量取值，就是输入搜索内容，这里为OC调用JavaScript
             //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
            */
     
            //>>>示例②：用http://577jp9.com/a2042/，进行默认登录的测试。（如果无效，请改为用百度测试默认搜索）>>>//
            "var field_name = document.getElementsByName('login')[0];"
            "var field_pasd = document.getElementsByName('password')[0];"
            "field_name.value='test';"
            "field_pasd.value='test';"
            //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<//
     
            "document.forms[0].submit();"
        "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    //开始调用自定义的javascript
    [webView stringByEvaluatingJavaScriptFromString:@"myFunction();"];
}


/*
//附：获取webView中网页的信息(http://blog.sina.com.cn/s/blog_6d58b63101010x5v.html)
获取所有html:NSString *lJs = @"document.documentElement.innerHTML";
获取网页title:NSString *lJs2 = @"document.title";
UIWebView *lWebView = [self getCurrentWebView];
NSString *lHtml1 = [lWebView stringByEvaluatingJavaScriptFromString:lJs];
NSString *lHtml2 = [lWebView stringByEvaluatingJavaScriptFromString:lJs2];


JavaScript获取网页信息总结
JavaScript获取当前页面URL、title等，具体怎么用就看自己了～
由于本站用了伪静态，所以获取不到文档名.document.location.port;是获取URL关联的端口号码，thisHash = document.location.hash;是获取链接属性中在井号“#”后面的分段。

thisURL = document.URL;
thisHREF = document.location.href;
thisSLoc = self.location.href;
thisDLoc = document.location;
thisTLoc = top.location.href;
thisPLoc = parent.document.location;
thisTHost = top.location.hostname;
thisHost = location.hostname;
thisTitle = document.title;
thisProtocol = document.location.protocol;
thisPort = document.location.port;
thisHash = document.location.hash;
thisSearch = document.location.search;
thisPathname = document.location.pathname;
thisHtml = document.documentElement.innerHTML;
thisBodyText = document.documentElement.innerText;//获取网页内容文字
thisBodyText = document.body.innerText;//获取网页内容文字  怎么和上一个一样？有知道的请解释
*/

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
