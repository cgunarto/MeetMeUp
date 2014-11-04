//
//  Profile.h
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/4/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Profile : NSObject
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *country;
@property (nonatomic, strong) NSString *thumbnailLink;
@property (nonatomic, strong) NSString *photoLink;

- (instancetype)initWithProfileDictionary: (NSDictionary *)profileDictionary;


@end
