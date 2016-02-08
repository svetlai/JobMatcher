//
//  JobSeekerMatchesViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/2/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobSeekerMatchesViewController.h"
#import "HelperMethods.h"
#import "JobSeekerMatchTableViewCell.h"
#import "JobOfferViewModel.h"
#import "JobOfferViewController.h"
#import "ChatViewController.h"

@interface JobSeekerMatchesViewController (){
    NSString* message;
    JobOfferViewModel* selectedJobOffer;
    NSInteger messageSender;
}

@end

@implementation JobSeekerMatchesViewController
NSString* const SegueFromMatchesToJobOffer = @"segueFromMatchesToJobOffer";
NSString* const SegueFromJobSeekerMatchesToMessage = @"segueFromJobSeekerMatchesToMessage";
int const JobSeekerMatchesMatchesTableRowHeight = 65;
static NSString* jobSeekerMatchesTableCellIdentifier = @"JobSeekerMatchTableViewCell"; 


- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"My Matches"];
    [self.jobSeekerMatchesTableView setDataSource:self];
    [self.jobSeekerMatchesTableView setDelegate:self];
    self.jobSeekerMatchesTableView.backgroundColor = [UIColor colorWithRed:0.949 green:0.929 blue:0.906 alpha:1] /*#f2ede7*/;//[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    self.jobSeekerMatchesTableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.949 green:0.929 blue:0.906 alpha:1] /*#f2ede7*/;//[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    UINib *nib = [UINib nibWithNibName:jobSeekerMatchesTableCellIdentifier bundle:nil];
    [self.jobSeekerMatchesTableView registerNib:nib forCellReuseIdentifier:jobSeekerMatchesTableCellIdentifier];
    
       // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// -------table view-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return self.jobOfferMatches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
            JobSeekerMatchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jobSeekerMatchesTableCellIdentifier];
        
        if (self.jobOfferMatches.count > 0) {
            JobOfferViewModel *jobOfferViewModel = self.jobOfferMatches[indexPath.row];
            cell.jobSeekerMatchTitleLabel.text = jobOfferViewModel.title;
            cell.jobSeekerMatchLocationLabel.text = jobOfferViewModel.location;
            cell.jobSeekerMatchSalaryLabel.text = [NSString stringWithFormat:@"%.02f €", jobOfferViewModel.salary];
            
            cell.jobSeekerMatchMessageButton.tag = indexPath.row;
            [cell.jobSeekerMatchMessageButton addTarget:self action:@selector(jobSeekerMatchMessageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
    
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return JobSeekerMatchesMatchesTableRowHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedJobOffer = [self.jobOfferMatches objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:SegueFromMatchesToJobOffer sender:tableView];
}

// --------- gestures-------------
-(void)jobSeekerMatchMessageButtonTap:(UIButton*)sender
{
    for (int i = 0; i < self.jobOfferMatches.count; i++) {
        if (sender.tag == i)
        {
            messageSender = i;
            [self performSegueWithIdentifier:SegueFromJobSeekerMatchesToMessage sender:sender];
            NSLog(@"clicked");
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:SegueFromMatchesToJobOffer]){
        JobOfferViewController* toJobOfferViewController = segue.destinationViewController;
        toJobOfferViewController.jobOfferViewModel = selectedJobOffer;
        toJobOfferViewController.matched = YES;
    } else if ([segue.identifier isEqualToString:SegueFromJobSeekerMatchesToMessage]){
        ChatViewController* toChatViewController = segue.destinationViewController;
        toChatViewController.jobSeekerId = 0; // TODO: set in backend
        
        for (int i = 0; i < self.jobOfferMatches.count; i++) {
            if (messageSender == i)
            {
                JobOfferViewModel* model =[self.jobOfferMatches objectAtIndex:i];
                toChatViewController.recruiterId = model.recruiterProfileId;
                toChatViewController.messageSubject = [NSString stringWithFormat:@"%ld. %@", model.jobOfferId, model.title];
            }
        }        
    }
}

@end
