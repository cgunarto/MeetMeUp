//
//  MeetupDetailViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "MeetupDetailViewController.h"
#import "WebViewController.h"
#import "ProfileViewController.h"
#import "MeetupComment.h"
#import "CustomTableViewCell.h"
#import "Profile.h"

@interface MeetupDetailViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *RSVPCount;
@property (weak, nonatomic) IBOutlet UILabel *hostingGroupInfo;
@property (weak, nonatomic) IBOutlet UIWebView *eventDescriptionWebView;
@property (weak, nonatomic) IBOutlet UIButton *webLink;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSDictionary *allJSONCommentDataDictionary;
@property (strong, nonatomic) NSDictionary *resultDictionary;
@property (strong, nonatomic) NSMutableArray *allCommentDictionaryArray;
@property (strong, nonatomic) NSMutableArray *allCommentArray;



@end

@implementation MeetupDetailViewController

#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allCommentArray = [@[]mutableCopy];
    self.allCommentDictionaryArray =[@[]mutableCopy];

    self.title = self.meetupChosen.eventName;
    self.eventName.text = self.meetupChosen.eventName;
    self.hostingGroupInfo.text = self.meetupChosen.groupName;
    self.RSVPCount.text = [NSString stringWithFormat:@"%d", (int)self.meetupChosen.yesRSVPCount];


    [self.eventDescriptionWebView loadHTMLString:self.meetupChosen.eventDescription baseURL:nil];
    
    [self loadCommentsForURL: self.meetupChosen.commentRequestURL];

    //get a dictionary of user information from comment chosen
}

#pragma mark Table View Delegate Methods

- (CustomTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    MeetupComment *comment = self.allCommentArray[indexPath.row];

    cell.userName.text  = comment.memberName;
    [cell.commentWebView loadHTMLString:comment.comment baseURL:nil];

    //TODO: fix time stamp
    float timestampval =  comment.timestamp;

    NSDate *updatetimestamp = [NSDate dateWithTimeIntervalSince1970: timestampval];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];

    [dateFormat setDateFormat:@"yyyy-MM-dd"];

    NSString *dateString = [dateFormat stringFromDate: updatetimestamp];

    cell.timeLabel.text = dateString;


    NSURL *url = [NSURL URLWithString:comment.memberProfileURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (connectionError)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CONNECTION ERROR" message:connectionError.localizedDescription preferredStyle:UIAlertControllerStyleAlert];

             UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

             [alert addAction:okButton];
             [self presentViewController:alert animated:YES completion:nil]; // move this into its own method later
         }

         else
         {
             NSDictionary *JSONDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             Profile *profile = [[Profile alloc]initWithProfileDictionary:JSONDictionary];

             NSURL *imageURL = [NSURL URLWithString:profile.thumbnailLink];
             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

             cell.userImageView.image = [UIImage imageWithData:imageData];

             // was calling infite loop
//             [self.tableView reloadData]
         }
     }];


    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allCommentDictionaryArray.count;
}

#pragma mark Custom Methods

- (void)loadCommentsForURL:(NSString *)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         if (connectionError)
         {
             UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"CONNECTION ERROR" message:connectionError.localizedDescription preferredStyle:UIAlertControllerStyleAlert];

             UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];

             [alert addAction:okButton];
             [self presentViewController:alert animated:YES completion:nil]; // move this into its own method later
         }

         else
         {
             self.allJSONCommentDataDictionary= [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             self.allCommentDictionaryArray = self.allJSONCommentDataDictionary[@"results"];

             for (int i = 0; i < self.allCommentDictionaryArray.count; i++)
             {
                MeetupComment *meetupComment = [[MeetupComment alloc] initWithCommentDictionary:self.allCommentDictionaryArray[i]];
                [self.allCommentArray insertObject:meetupComment atIndex:i];
             }

             [self.tableView reloadData];
         }
     }];
}

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"segue2"]) //TODO: name it WebviewSegue
    {
        WebViewController *webVC = segue.destinationViewController;
        webVC.meetupChosen = self.meetupChosen;
    }
    else if ([segue.identifier isEqualToString:@"segue3"])
    {
        ProfileViewController *profileVC = segue.destinationViewController;
        MeetupComment *meetupCommentChosen = self.allCommentArray[[self.tableView indexPathForSelectedRow].row];
        profileVC.meetupComment = (MeetupComment *) meetupCommentChosen;
    }
}



@end
