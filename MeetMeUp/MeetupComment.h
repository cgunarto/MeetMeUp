//
//  MeetupComment.h
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeetupComment : NSObject

@property float timestamp;
//[NSDate dateWithTimeIntervalSince1970:timestamp]
@property NSString *memberName;
@property NSString *comment;
@property NSString *memberID;
@property NSString *memberProfileURL;

- (instancetype)initWithCommentDictionary: (NSDictionary *)commentDictionary;


@end
