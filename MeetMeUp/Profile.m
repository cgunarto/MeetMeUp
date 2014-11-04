//
//  Profile.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/4/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "Profile.h"

@implementation Profile

- (instancetype)initWithProfileDictionary: (NSDictionary *)profileDictionary
{
    self = [super init];
    self.name = profileDictionary[@"name"];
    self.city = profileDictionary[@"city"];
    self.country = profileDictionary[@"country"];

    NSDictionary *photoDictionary = profileDictionary[@"photo"];
    self.thumbnailLink = photoDictionary[@"thumb_link"];
    self.photoLink = photoDictionary[@"photo_link"];

    return self;
}


@end
