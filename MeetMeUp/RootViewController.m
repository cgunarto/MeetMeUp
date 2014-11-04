//
//  ViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#import "MeetupDetailViewController.h"
#import "Meetup.h"
#define kURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3a101e334041565a185317693668407b"

@interface RootViewController () <UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *allJSONDataDictionary;
@property (strong, nonatomic) NSDictionary *resultDictionary;
@property (strong, nonatomic) NSMutableArray *allMeetupDictionaryArray;
@property (strong, nonatomic) NSMutableArray *allMeetupArray;
@property (strong, nonatomic) Meetup *meetupChosen;

@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allMeetupArray = [@[]mutableCopy]; // check this later if it crashes

    NSURL *url = [NSURL URLWithString:kURL];
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
            self.allJSONDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            self.allMeetupDictionaryArray = self.allJSONDataDictionary[@"results"]; // now allMeetupArray becomes an array of dictionary

            for (int i = 0; i < self.allMeetupDictionaryArray.count; i++)
            {
                Meetup *meetup = [[Meetup alloc] initWithMeetupDictionary:self.allMeetupDictionaryArray[i]];
                [self.allMeetupArray insertObject:meetup atIndex:i];
            }

            [self.tableView reloadData];
        }
    }];

}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.meetupChosen = self.allMeetupArray[indexPath.row];

    cell.textLabel.text = self.meetupChosen.eventName;
    cell.detailTextLabel.text = self.meetupChosen.fullAddress;

    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMeetupDictionaryArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue1 sender:(id)sender
{
    MeetupDetailViewController *meetupDetailVC = segue1.destinationViewController;
//    meetupDetailVC.meetupDictionary = self.resultDictionary;
    meetupDetailVC.meetupChosen = self.meetupChosen;
}




@end
