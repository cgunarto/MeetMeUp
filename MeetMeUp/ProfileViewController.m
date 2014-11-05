//
//  ProfileViewController.m
//  MeetMeUp
//
//  Created by CHRISTINA GUNARTO on 11/4/14.
//  Copyright (c) 2014 Christina Gunarto. All rights reserved.
//

#import "ProfileViewController.h"
#import "Profile.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation ProfileViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSString *profileURLString = self.meetupComment.memberProfileURL;
    [self loadProfileForURL:profileURLString];
}


- (void)loadProfileForURL:(NSString *)urlString
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
             NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             Profile *profile = [[Profile alloc]initWithProfileDictionary:d];

             self.userNameLabel.text = profile.name;

             NSURL *imageURL = [NSURL URLWithString:profile.photoLink];
             NSData *imageData = [NSData dataWithContentsOfURL:imageURL];

            self.imageView.image = [UIImage imageWithData:imageData];

            
         }
     }];


}



@end
