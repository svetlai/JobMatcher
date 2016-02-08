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
#import "MessageService.h"
#import "AddMessageViewModel.h"
#import "Validator.h"

@interface ChatViewController (){
    NSString* message;
    NSArray* messages;
    UserDataModel* userData;
    NSString* connectionType;
}

@end

@implementation ChatViewController
static JobSeekerService* jobSeekerService;
static RecruiterService* recruiterService;
static MessageService* messageService;
static Validator* validator;

int const MessageTableRowHeight = 100;
static NSString* jobSeekerMessageTableViewCell = @"JobSeekerMessageTableViewCell";
static NSString* recruiterMessageTableViewCell = @"RecruiterMessageTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"My Messages"]; // TODO get recruiter name
    
    [self.messagesTableView setDataSource:self];
    [self.messagesTableView setDelegate:self];
    self.messagesTableView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
    self.messagesTableView.backgroundView.backgroundColor = [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;

        userData = [[UserDataModel alloc] init];
    
    if (userData.profileType == JobSeeker){
        jobSeekerService = [[JobSeekerService alloc] init];
        [jobSeekerService getJobSeekerMessagesWithRecruiterId:self.recruiterId andTarget:self];
    } else if (userData.profileType == Recruiter){
        recruiterService = [[RecruiterService alloc] init];
        [recruiterService getRecruiterMessagesWithJobSeekerId:self.jobSeekerId andTarget:self];
    }
    
    validator = [[Validator alloc] init];
    messageService = [[MessageService alloc] init];
    connectionType = @"GetMessages";
    [self getMessages];
    
    UINib *nibJobSeeker = [UINib nibWithNibName:jobSeekerMessageTableViewCell bundle:nil];
    [self.messagesTableView registerNib:nibJobSeeker forCellReuseIdentifier:jobSeekerMessageTableViewCell];
    
    UINib *nibRecruiter = [UINib nibWithNibName:recruiterMessageTableViewCell bundle:nil];
    [self.messagesTableView registerNib:nibRecruiter forCellReuseIdentifier:recruiterMessageTableViewCell];
    
       // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)getMessages{
    if (userData.profileType == JobSeeker){
        jobSeekerService = [[JobSeekerService alloc] init];
        [jobSeekerService getJobSeekerMessagesWithRecruiterId:self.recruiterId andTarget:self];
    } else if (userData.profileType == Recruiter){
        recruiterService = [[RecruiterService alloc] init];
        [recruiterService getRecruiterMessagesWithJobSeekerId:self.jobSeekerId andTarget:self];
    }
}

#pragma mark - TableView

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
    if ([connectionType isEqualToString:@"GetMessages"]){
        messages = [MessageViewModel arrayOfMessagesFromJsonDictionary: json];
        [self.messagesTableView reloadData];
        if (messages.count > 1){
            NSIndexPath* ipath = [NSIndexPath indexPathForRow: messages.count-1 inSection: 0];
            [self.messagesTableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
        }
         connectionType = @"";
    }else if ([connectionType isEqualToString:@"AddMessage"]){
        
        connectionType = @"GetMessages";
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"%@", httpResponse);

    if ([connectionType isEqualToString:@"AddMessage"]){
        if (code == 200){
            [self.addMessageTextView setText:@""];
            [self getMessages];
        }
    }

    if (code != 200) {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JobSeekerMessageTableViewCell *jobSeekerCell = [tableView dequeueReusableCellWithIdentifier:jobSeekerMessageTableViewCell];
    
    RecruiterMessageTableViewCell* recruiterCell  = [tableView dequeueReusableCellWithIdentifier:recruiterMessageTableViewCell];
    
    //TODO: table cell height + resizable labels
    if (messages.count > 0) {
        MessageViewModel *messageViewModel = messages[indexPath.row];
        if (messageViewModel.jobSeekerProfileId == messageViewModel.senderId){
            jobSeekerCell.jobSeekerMessageSubject.text = messageViewModel.messageSubject ;
            jobSeekerCell.jobSeekerMessageContent.text = messageViewModel.messageContent ;

            return jobSeekerCell;
        } else if (messageViewModel.recruiterProfileId == messageViewModel.senderId){
            recruiterCell.recruiterMessageSubject.text = messageViewModel.messageSubject;
            recruiterCell.recruiterMessageContent.text = messageViewModel.messageContent ;
            
            return recruiterCell;
        }
    }
    
    return recruiterCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return MessageTableRowHeight;
}

- (IBAction)addMessageButtonTap:(id)sender {
    
    NSString* messageSubject;
    if (self.messageSubject == nil){
        messageSubject = @"Offer";
    }else{
        messageSubject = self.messageSubject;
    }
    
    BOOL isValidContent = [validator isValidLength:3 andParam:self.addMessageTextView.text];
    
    NSString* messageContent;
    if (isValidContent){
        messageContent = self.addMessageTextView.text;
    }else{
        [HelperMethods addAlert:@"Message content must be at least 3 symbols long."];
        return;
    }

        NSString* messageSenderAccountType = [NSString stringWithFormat:@"%u",[UserDataModel getAccountType]];
    
        AddMessageViewModel* addMessageModel = [AddMessageViewModel messageWithSubject:messageSubject andContent:messageContent andJobSeekerProfileId:self.jobSeekerId andRecruiterProfileId:self.recruiterId andSenderAccountType:messageSenderAccountType];
    
    
                                            connectionType = @"AddMessage";
        [messageService addMessageWithModel:addMessageModel andTarget:self];
}
@end
