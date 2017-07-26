//
//  ViewController.m
//  PixzlWebViewCache
//
//  Created by Pixzl on 26.07.17.
//  Copyright © 2017 Pixzl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webView.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadURL {
    NSString *urlString = @"https://www.apple.com";
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:urlRequest];
    
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:urlRequest];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        
        if([[cookie domain] isEqualToString:urlString]) {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [self loadURL];
    self.webView.delegate = self;
    [self.webView setOpaque:NO];
    [self.webView setBackgroundColor:[UIColor clearColor]];
}

- (void)webViewDidStartLoad:(UIWebView *)myWebView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)myWebView {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (IBAction)refreshWebView:(id)sender {
        [self.webView reload];
}

@end
