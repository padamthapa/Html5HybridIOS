//
//  ZBViewController.m
//  HybridAppTemplate
//
//  Created by Paddy on 26/08/14.
//  Copyright (c) 2014 zabingo. All rights reserved.
//

#import "ZBViewController.h"

@interface ZBViewController ()

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
    //[self.mWebView setBackgroundColor:[UIColor redColor]];
    self.mWebView.scrollView.bounces = NO;
    [self.mWebView loadHTMLString:htmlContent
                         baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *requestURLString = [[request URL] absoluteString];
    
    if ([requestURLString hasPrefix:@"js-call:"]) {
        
        NSArray *components = [requestURLString componentsSeparatedByString:@":"];
        
        NSString *commandName = (NSString*)[components objectAtIndex:1];
        NSString *argsAsString = [(NSString*)[components objectAtIndex:2]
                                  stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        NSData *argsData = [argsAsString dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *args = (NSDictionary*)[NSJSONSerialization JSONObjectWithData:argsData options:kNilOptions error:&error];
        
        NSLog(@"Command: %@ - %@", commandName, [args description]);
        
        if ([commandName isEqualToString:@"updateNames"]) {
            
        }
        
        return NO;
        
    } else {
        
        return YES;
    }
}

@end
