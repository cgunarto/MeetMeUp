//
//  MeetupDetailViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MeetupDetailViewController.h"
#import "WebViewController.h"

@interface MeetupDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *RSVPCount;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroupInfo;
@property (weak, nonatomic) IBOutlet UIWebView *eventDescriptionWebView;
@property (weak, nonatomic) IBOutlet UIButton *webLink;



@end

@implementation MeetupDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.eventName.text = self.meetupChosen.eventName;

    self.hostingGroupInfo.text = [NSString stringWithFormat:@"Group: %@", self.meetupChosen.groupName];

    self.RSVPCount.text = [NSString stringWithFormat:@"RSVP: %d", (int)self.meetupChosen.yesRSVPCount];

    [self.eventDescriptionWebView loadHTMLString:self.meetupChosen.eventDescription baseURL:nil];

    NSString *urlString = self.meetupChosen.urlString;
    [self.webLink setTitle:urlString forState:UIControlStateNormal];

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue2 sender:(id)sender
{
    WebViewController *webVC = segue2.destinationViewController;
    webVC.meetupChosen = self.meetupChosen;
}




@end
