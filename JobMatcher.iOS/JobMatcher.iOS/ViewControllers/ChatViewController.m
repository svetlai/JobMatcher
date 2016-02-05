//
//  ChatViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/3/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ChatViewController.h"
#import "HelperMethods.h"
#import "JobSeekerService.h"
#import "JobSeekerMessageTableViewCell.h"
#import "RecruiterMessageTableViewCell.h"
#import "MessageViewModel.h"
#import "UserDataModel.h"
#import "HelperMethods.h"
#import "RecruiterService.h"

@interface ChatViewController (){
    NSString* message;
    NSArray* messages;
    UserDataModel* userData;
}

@end

@implementation ChatViewController
static JobSeekerService* jobSeekerService;
static RecruiterService* recruiterService;

int const MessageTableRowHeight = 100;
static NSString* jobSeekerMessageTableViewCell = @"JobSeekerMessageTableViewCell";
static NSString* recruiterMessageTableViewCell = @"RecruiterMessageTableViewCell";

    //SingleMessageTableViewCell
- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"My Messages"]; // TODO get recruiter name
    
    [self.messagesTableView setDataSource:self];
    [self.messagesTableView setDelegate:self];
    self.messagesTableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    self.messagesTableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
//    self.messagesTableView.rowHeight = UITableViewAutomaticDimension;
//    self.messagesTableView.estimatedRowHeight = 122.0;
        userData = [[UserDataModel alloc] init];
    
    if (userData.profileType == JobSeeker){
        jobSeekerService = [[JobSeekerService alloc] init];
        [jobSeekerService getJobSeekerMessagesWithRecruiterId:self.recruiterId andTarget:self];
    } else if (userData.profileType == Recruiter){
        recruiterService = [[RecruiterService alloc] init];
        [recruiterService getRecruiterMessagesWithJobSeekerId:self.jobSeekerId andTarget:self];
    }

    
    UINib *nibJobSeeker = [UINib nibWithNibName:jobSeekerMessageTableViewCell bundle:nil];
    [self.messagesTableView registerNib:nibJobSeeker forCellReuseIdentifier:jobSeekerMessageTableViewCell];
    
    UINib *nibRecruiter = [UINib nibWithNibName:recruiterMessageTableViewCell bundle:nil];
    [self.messagesTableView registerNib:nibRecruiter forCellReuseIdentifier:recruiterMessageTableViewCell];

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

// connection
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //    NSLog(@"%@", error);
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSArray* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];
    NSLog(@"%@", json);
    
    messages = [MessageViewModel arrayOfMessagesFromJsonDictionary: json];
    [self.messagesTableView reloadData];
    //TODO get array with messages

//        self.jobOfferViewModel = [JobOfferViewModel fromJsonDictionary:json];
//        [self loadData];

    //    NSString* username = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"userName"]];
    
    
}

//- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//    long code = [httpResponse statusCode];
//    NSLog(@"%@", httpResponse);
//    // NSLog([NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]]);
//    
//    if ([connectionType isEqualToString:@"AddLike"]){
//        if (code == 200){
//            message = @"Liked!";
//            [HelperMethods addAlert:message];
//            [jobOfferService getRandomOfferWithTarget:self];
//        }
//        
//        connectionType = @"GetOffer";
//    } else if ([connectionType isEqualToString:@"AddDislike"]){
//        if (code == 200){
//            message = @"Disliked!";
//            [HelperMethods addAlert:message];
//            [jobOfferService getRandomOfferWithTarget:self];
//        }
//        
//        connectionType = @"GetOffer";
//    }
//    
//    
//    //    // TODO - improve browsing logic and end of joboffers
//    //    if (code == 400 ){ //&& jobSeekerViewModel.username == NULL
//    //        message = @"No more Job Offers to browse.";
//    //        [HelperMethods addAlert:message];
//    //        [self performSegueWithIdentifier:SegueFromJobOfferToJobSeeker sender:self];
//    //        return;
//    //    }
//    
//    if (code != 200) {
//        message = @"Nope. Try again!";
//        [HelperMethods addAlert:message];
//    }
//}

// table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JobSeekerMessageTableViewCell *jobSeekerCell = [tableView dequeueReusableCellWithIdentifier:jobSeekerMessageTableViewCell];
    
    RecruiterMessageTableViewCell* recruiterCell  = [tableView dequeueReusableCellWithIdentifier:recruiterMessageTableViewCell];
    
    //TODO: table cell height
    if (messages.count > 0) {
        MessageViewModel *messageViewModel = messages[indexPath.row];
        if (messageViewModel.jobSeekerProfileId == messageViewModel.senderId){
            jobSeekerCell.jobSeekerMessageSubject = [HelperMethods resizeLabel:jobSeekerCell.jobSeekerMessageSubject andText:messageViewModel.messageSubject andTarget:jobSeekerCell.contentView];
            //jobSeekerCell.jobSeekerMessageContent.text = messageViewModel.messageContent;
            
//            NSString* text = @"kjasjdlj l kalvldalknb  kjnakh kihAJ KJHSKJDH OFHwoeu rjns KJHDCO nusdho k ABkiuh kjahdfouho H"; //messageViewModel.content;
// 
            jobSeekerCell.jobSeekerMessageContent = [HelperMethods resizeLabel:jobSeekerCell.jobSeekerMessageContent andText:messageViewModel.messageContent andTarget:jobSeekerCell.contentView ];

            return jobSeekerCell;
        } else if (messageViewModel.recruiterProfileId == messageViewModel.senderId){

            recruiterCell.recruiterMessageSubject = [HelperMethods resizeLabel:recruiterCell.recruiterMessageSubject andText:messageViewModel.messageSubject andTarget:recruiterCell.contentView];
            recruiterCell.recruiterMessageContent = [HelperMethods resizeLabel:recruiterCell.recruiterMessageContent andText:messageViewModel.messageContent andTarget:recruiterCell.contentView];
            
            return recruiterCell;
        }
        
//        cell.jobSeekerMatchTitleLabel.text = jobOfferViewModel.title;
//        cell.jobSeekerMatchLocationLabel.text = jobOfferViewModel.location;
//        cell.jobSeekerMatchSalaryLabel.text = [NSString stringWithFormat:@"%.02f €", jobOfferViewModel.salary];
//        cell.jobSeekerMatchMessageButton.tag = indexPath.row;
//        [cell.jobSeekerMatchMessageButton addTarget:self action:@selector(jobSeekerMatchMessageButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        //return cell;
    }
    
    return recruiterCell;

//    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MessageTableRowHeight;
}
@end
