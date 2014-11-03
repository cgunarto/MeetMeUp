//
//  ViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/3/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "RootViewController.h"
#import "MeetupDetailViewController.h"
#define kURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=3a101e334041565a185317693668407b"

@interface RootViewController () <UITabBarDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *allJSONDataDictionary;
@property (strong, nonatomic) NSDictionary *resultDictionary;
@property (strong, nonatomic) NSMutableArray *allMeetupArray;


@end

@implementation RootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
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
            self.allMeetupArray = self.allJSONDataDictionary[@"results"]; // now allMeetupArray becomes an array of dictionary

            [self.tableView reloadData];
        }
    }];

}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    self.resultDictionary = self.allMeetupArray[indexPath.row];

//    NSDictionary *dGroupDictionary = self.resultDictionary[@"group"];
    cell.textLabel.text = self.resultDictionary[@"name"];

    NSDictionary *dVenueDictionary = self.resultDictionary[@"venue"];
    cell.detailTextLabel.text = dVenueDictionary[@"address_1"];

    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMeetupArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MeetupDetailViewController *meetupDetailVC = segue.destinationViewController;
    meetupDetailVC.meetupDictionary = self.resultDictionary;
}


@end
