//
//  CustomTableViewCell.h
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIWebView *commentWebView;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;

@end
