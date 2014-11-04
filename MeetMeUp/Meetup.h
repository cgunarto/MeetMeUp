//
//  Meetup.h
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Meetup : NSObject

@property (strong, nonatomic) NSDictionary *meetupDictionary;

@property (strong, nonatomic) NSString *eventName;
@property (strong, nonatomic) NSString *groupName;
@property (strong, nonatomic) NSNumber* yesRSVPCount;
@property (strong, nonatomic) NSString *urlString;
@property (strong, nonatomic) NSString *eventDescription;

@property (strong, nonatomic) NSDictionary *venueDictionary;
@property (strong, nonatomic) NSString *streetAddress;
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *fullAddress;

@property (strong, nonatomic) NSString *groupID;
@property (strong, nonatomic) NSString *eventID;
@property (strong, nonatomic) NSString *commentRequestURL;

- (instancetype)initWithMeetupDictionary:(NSDictionary *) meetupDictionary;

@end
