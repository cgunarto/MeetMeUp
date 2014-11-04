//
//  MeetupComment.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MeetupComment.h"

@implementation MeetupComment

- (instancetype)initWithCommentDictionary: (NSDictionary *)commentDictionary
{
    self = [super init];
    self.memberName = commentDictionary[@"member_name"];
    self.comment = commentDictionary[@"comment"];

    //Break out calculations into multiple lines
    NSNumber *valueOfDateFromJSON = commentDictionary[@"time"];
    float dateValue = [valueOfDateFromJSON floatValue]; // take the NSNumber and make a float from it
    self.timestamp = dateValue / 1000;

//    self.timestamp = (int)commentDictionary[@"time"]/1000;
    self.memberID = commentDictionary[@"member_id"];
    self.memberProfileURL = [NSString stringWithFormat:@"https://api.meetup.com/2/member/%@?&sign=true&photo-host=public&key=477d1928246a4e162252547b766d3c6d" ,self.memberID];

    return self;
}

@end
