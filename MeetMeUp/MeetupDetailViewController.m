//
//  MeetupDetailViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MeetupDetailViewController.h"

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

    self.eventName.text = self.meetupDictionary[@"name"];

    NSDictionary *dGroupDictionary = self.meetupDictionary[@"group"];
    self.hostingGroupInfo.text = [NSString stringWithFormat:@"Hosting group info is %@", dGroupDictionary[@"name"]];

    int RSVPYesCount = (int)self.meetupDictionary[@"yes_rsvp_count"];
    self.RSVPCount.text = [NSString stringWithFormat:@"RSVP Count is %d",RSVPYesCount];

    [self.eventDescriptionWebView loadHTMLString:self.meetupDictionary[@"description"] baseURL:nil];

    NSString *urlString = self.meetupDictionary[@"event_url"];
    [self.webLink setTitle:urlString forState:UIControlStateNormal];

}




@end
