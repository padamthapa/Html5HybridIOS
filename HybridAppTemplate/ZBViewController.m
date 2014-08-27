//
//  ZBViewController.m
//  HybridAppTemplate
//
//  Created by Paddy on 26/08/14.
//  Copyright (c) 2014 zabingo. All rights reserved.
//

#import "ZBViewController.h"
#import "ZBDetailViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ZBViewController ()
{
    WebViewJavascriptBridge* bridge;
}

@property (weak, nonatomic) IBOutlet UIWebView *mWebView;

@end

@implementation ZBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self setTitle:@"Web ListView"];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSError *error;
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"listview" ofType:@"html"];
    
    NSString *htmlContent = [[NSString alloc] initWithContentsOfFile:htmlFile encoding:NSUTF8StringEncoding error:&error];

    self.mWebView.scrollView.bounces = NO;
    [self.mWebView loadHTMLString:htmlContent
                         baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    
    bridge = [WebViewJavascriptBridge bridgeForWebView:self.mWebView handler:^(id data, WVJBResponseCallback responseCallback) {
        NSDictionary *responseData = [NSDictionary dictionaryWithDictionary:data];
        if ([[responseData objectForKey:@"action"] isEqualToString:@"push"]) {
            [self pushViewControllerFromJSCall];
        }
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    return NO;
}

-(void)pushViewControllerFromJSCall
{
    ZBDetailViewController *controller = [[ZBDetailViewController alloc] initWithNibName:@"ZBDetailViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
