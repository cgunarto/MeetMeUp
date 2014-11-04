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
//    self.date = [NSDate dateWithTimeIntervalSinceNow: *(NSTimeInterval *)commentDictionary[@"time"]];
    return self;
}

@end

