//
//  WebViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIButton *webBackButton;
@property (weak, nonatomic) IBOutlet UIButton *webForwardButton;

@end

@implementation WebViewController

#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setButtonState];

    NSString *urlString = self.meetupChosen.urlString;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *requestURL = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:requestURL];


}

#pragma mark Web View Load Cycle

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];

}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
    [self setButtonState];
}

#pragma mark Button Presses and State

- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onWebBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
}

- (IBAction)onWebForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}

- (void) setButtonState
{
    if ([self.webView canGoBack])
    {
        self.webBackButton.enabled = YES;
    }

    else if ([self.webView canGoForward])
    {
        self.webForwardButton.enabled = YES;
    }

    else
    {
        self.webBackButton.enabled = NO;
        self.webForwardButton.enabled = NO;
    }
}


@end
