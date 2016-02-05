//
//  RecruiterMatchesViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/5/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "RecruiterMatchesViewController.h"
#import "HelperMethods.h"
#import "JobSeekerProfileViewModel.h"
#import "RecruiterMatchTableViewCell.h"
#import "JobSeekerHomeViewController.h"
#import "ChatViewController.h"

@interface RecruiterMatchesViewController (){
    NSInteger messageSender;
    JobSeekerProfileViewModel* selectedJobSeekerMatch;
}

@end

@implementation RecruiterMatchesViewController
int const RecruiterMatchesMatchesTableRowHeight = 100;
static NSString* recruiterMatchTableViewCellIdentifier = @"RecruiterMatchTableViewCell";
NSString* const SegueFromRecruiterMatchesToMessages = @"segueFromRecruiterMatchesToMessages";
NSString* const SegueFromRecruiterMatchesToJobSeekerProfile = @"segueFromRecruiterMatchesToJobSeekerProfile";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"My Matches"];
    [self.recruiterMatchesTableView setDataSource:self];
    [self.recruiterMatchesTableView setDelegate:self];
    self.recruiterMatchesTableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    self.recruiterMatchesTableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    UINib *nib = [UINib nibWithNibName:recruiterMatchTableViewCellIdentifier bundle:nil];
    [self.recruiterMatchesTableView registerNib:nib forCellReuseIdentifier:recruiterMatchTableViewCellIdentifier];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.recruiterMatches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecruiterMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:recruiterMatchTableViewCellIdentifier];
    
    if (self.recruiterMatches.count > 0) {
        JobSeekerProfileViewModel *jobSeekerProfileViewModel = self.recruiterMatches[indexPath.row];
        cell.recruiterMatchEmail.text = jobSeekerProfileViewModel.email;
        cell.recruiterMatchSummary.text = jobSeekerProfileViewModel.summary;
        //TODO: resize summary

        [cell.recruiterMatchMessageButton addTarget:self action:@selector(recruiterMatchMessageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Value Selected by user
    //TODO: edit
    selectedJobSeekerMatch = [self.recruiterMatches objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:SegueFromRecruiterMatchesToJobSeekerProfile sender:tableView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return RecruiterMatchesMatchesTableRowHeight;
}

-(void)recruiterMatchMessageButtonTap:(UIButton*)sender
{
    for (int i = 0; i < self.recruiterMatches.count; i++) {
        if (sender.tag == i)
        {
            messageSender = i;
            [self performSegueWithIdentifier:SegueFromRecruiterMatchesToMessages sender:sender];
            NSLog(@"clicked");
        }
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:SegueFromRecruiterMatchesToJobSeekerProfile]){
        JobSeekerHomeViewController* toJobSeekerHomeViewController = segue.destinationViewController;
        toJobSeekerHomeViewController.jobSeekerProfileViewModel = selectedJobSeekerMatch;
    } else if ([segue.identifier isEqualToString:SegueFromRecruiterMatchesToMessages]){
        ChatViewController* toChatViewController = segue.destinationViewController;
        toChatViewController.recruiterId = 0; // TODO: set in backend
        
        for (int i = 0; i < self.recruiterMatches.count; i++) {
            if (messageSender == i)
            {
                JobSeekerProfileViewModel* model =[self.recruiterMatches objectAtIndex:i];
                toChatViewController.jobSeekerId = model.profileId;
            }
        }
    }
}

@end
