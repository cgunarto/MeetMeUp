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
#define kURL @"https://api.meetup.com/2/open_events.json?zip=60604&text=mobile&time=,1w&key=477d1928246a4e162252547b766d3c6d"

@interface RootViewController () <UITabBarDelegate, UITableViewDataSource, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *resultDictionary;
@property (strong, nonatomic) NSMutableArray *allMeetupArray;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation RootViewController

#pragma mark View Controller Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.allMeetupArray = [@[]mutableCopy]; // check this later if it crashes
    [self loadJSONData:kURL];
}

#pragma mark Table View Delegate Method

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Meetup *meetup = self.allMeetupArray[indexPath.row];

    cell.textLabel.text = meetup.eventName;
    cell.detailTextLabel.text = meetup.fullAddress;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allMeetupArray.count;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue1 sender:(id)sender
{
    MeetupDetailViewController *meetupDetailVC = segue1.destinationViewController;
    Meetup *meetupChosen = self.allMeetupArray[[self.tableView indexPathForSelectedRow].row];
    meetupDetailVC.meetupChosen = meetupChosen;

}

#pragma mark TextField Delegate Method

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""])
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"EMPTY TEXT"
                                                                       message:@"Please enter a search term"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okButton = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }

    else
    {
        NSString *enteredTopic = textField.text;
        NSString *lowercaseTopic = [enteredTopic lowercaseString];
        NSString *formattedURLString = [NSString stringWithFormat:@"https://api.meetup.com/2/open_events.json?zip=60604&text=%@&time=,1w&key=3a101e334041565a185317693668407b", lowercaseTopic];
        [self loadJSONData:formattedURLString];
    }

    [textField resignFirstResponder];
    return YES;
}

#pragma mark Custom Method

- (void)loadJSONData:(NSString *)urlString
{
    [self.allMeetupArray removeAllObjects]; //start with a clean slate everytime with this refresh
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
             NSDictionary *allJSONDataDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSArray *allMeetupDictionaryArray = allJSONDataDictionary[@"results"]; // now allMeetupArray becomes an array of dictionary

             for (NSDictionary *d in allMeetupDictionaryArray)
             {
                 Meetup *meetup = [[Meetup alloc] initWithMeetupDictionary:d];
                 [self.allMeetupArray addObject:meetup];
             }
//             for (int i = 0; i < allMeetupDictionaryArray.count; i++)
//             {
//                 Meetup *meetup = [[Meetup alloc] initWithMeetupDictionary:self.allMeetupDictionaryArray[i]];
//                 [self.allMeetupArray insertObject:meetup atIndex:i];
//             }

             [self.tableView reloadData];
         }
     }];
}




@end
