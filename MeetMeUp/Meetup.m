//
//  Meetup.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "Meetup.h"

@implementation Meetup

- (instancetype)initWithMeetupDictionary:(NSDictionary *) meetupDictionary
{
    self = [super init];
    self.eventName = meetupDictionary[@"name"];

    NSDictionary *dGroupDictionary = meetupDictionary[@"group"];
    self.groupName = dGroupDictionary[@"name"];
    self.groupID = dGroupDictionary[@"id"];

    self.yesRSVPCount = meetupDictionary[@"yes_rsvp_count"];

    self.urlString = meetupDictionary[@"event_url"];

    self.eventDescription = meetupDictionary[@"description"];

    self.venueDictionary = meetupDictionary[@"venue"];
    self.streetAddress = self.venueDictionary[@"address_1"];
    self.city = self.venueDictionary[@"city"];
    self.country = self.venueDictionary[@"country"];
    self.fullAddress = [NSString stringWithFormat:@"%@, %@, %@",self.streetAddress, self.city, self.country];

    self.eventID = meetupDictionary[@"id"];

    self.commentRequestURL = [NSString stringWithFormat:@"https://api.meetup.com/2/event_comments?&sign=true&photo-host=public&group_id=%@&event_id=%@&key=3a101e334041565a185317693668407b",self.groupID, self.eventID];
    return self;
    
}


@end
