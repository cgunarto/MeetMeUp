//
//  WebViewController.h
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Meetup.h"

@interface WebViewController : UIViewController

@property (strong, nonatomic) Meetup *meetupChosen;

//@property (strong, nonatomic) NSDictionary* meetupDictionary;//TODO: delete this later
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end
