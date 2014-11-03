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
@property (weak, nonatomic) IBOutlet UITextView *hostingGroupInfo;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;



@end

@implementation MeetupDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSDictionary *dGroupDictionary = self.meetupDictionary[@"group"];
    self.eventName.text = dGroupDictionary[@"name"];

    int RSVPYesCount = (int)self.meetupDictionary[@"yes_rsvp_count"];
    self.RSVPCount.text = [NSString stringWithFormat:@"RSVP Count is %d",RSVPYesCount];

}

//
//self.resultDictionary = self.allMeetupArray[indexPath.row];
//
//NSDictionary *dGroupDictionary = self.resultDictionary[@"group"];
//cell.textLabel.text = dGroupDictionary[@"name"];
//
//NSDictionary *dVenueDictionary = self.resultDictionary[@"venue"];
//cell.detailTextLabel.text = dVenueDictionary[@"address_1"];
//



@end
