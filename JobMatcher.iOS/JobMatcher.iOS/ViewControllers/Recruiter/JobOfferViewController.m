//
//  JobOfferViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobOfferViewController.h"
#import "HelperMethods.h"
#import "GlobalConstants.h"
#import "UserDataModel.h"
#import "AddLikeViewModel.h"
#import "AddDislikeViewModel.h"
#import "MatchService.h"
#import "JobOfferService.h"

@interface JobOfferViewController (){
    UserDataModel* userData;
    NSString* message;
    NSString* connectionType;
}

@end

@implementation JobOfferViewController
static MatchService* jobOfferMatchService;
static JobOfferService* jobOfferService;
NSString* const SegueFromJobOfferToJobSeeker = @"segueFromJobOfferToJobSeeker";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"Job Offer"];
    
    userData = [[UserDataModel alloc] init];
    jobOfferMatchService = [[MatchService alloc] init];
    jobOfferService = [[JobOfferService alloc] init];
    
    if (self.jobOfferViewModel != nil && userData.profileType == Recruiter){
        [self loadData];
    } else if (userData.profileType == JobSeeker){
        [jobOfferService getRandomOfferWithTarget:self];
        connectionType = @"GetOffer";
    }

 
    
    // swipe
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(jobOfferSwipe:)];
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(jobOfferSwipe:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    [self.view addGestureRecognizer:leftSwipeRecognizer];

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
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];
    NSLog(@"%@", json);
    
    if ([connectionType isEqualToString:@"GetOffer"]){
        self.jobOfferViewModel = [JobOfferViewModel fromJsonDictionary:json];
        [self loadData];
        connectionType = @"";
    }
    
    //    NSString* username = [NSString stringWithFormat:@"%@", [(NSDictionary*)json objectForKey:@"userName"]];
    
    
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    NSLog(@"%@", httpResponse);
    // NSLog([NSHTTPURLResponse localizedStringForStatusCode:[httpResponse statusCode]]);
    
    if ([connectionType isEqualToString:@"AddLike"]){
        if (code == 200){
            message = @"Liked!";
            [HelperMethods addAlert:message];
            [jobOfferService getRandomOfferWithTarget:self];
        }
        
        connectionType = @"GetOffer";
    } else if ([connectionType isEqualToString:@"AddDislike"]){
        if (code == 200){
            message = @"Disliked!";
            [HelperMethods addAlert:message];
            [jobOfferService getRandomOfferWithTarget:self];
        }
        
        connectionType = @"GetOffer";
    }
    
    
//    // TODO - improve browsing logic and end of joboffers
//    if (code == 400 ){ //&& jobSeekerViewModel.username == NULL
//        message = @"No more Job Offers to browse.";
//        [HelperMethods addAlert:message];
//        [self performSegueWithIdentifier:SegueFromJobOfferToJobSeeker sender:self];
//        return;
//    }
    
    if (code != 200) {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}
-(void) loadData{
    [HelperMethods setPageTitle:self andTitle:self.jobOfferViewModel.title];
    self.jobOfferIndustryLabel.text = [Industries objectAtIndex:self.jobOfferViewModel.industry];
    self.jobOfferLocationLabel.text = self.jobOfferViewModel.location;
    self.jobOfferWorkHoursLabel.text = [WorkHours objectAtIndex: self.jobOfferViewModel.workHours];
    self.jobOfferSalaryLabel.text = [NSString stringWithFormat:@"%.02f €", self.jobOfferViewModel.salary];
    self.jobOfferDescriptionLabel = [self resizeLabel:self.jobOfferDescriptionLabel andText:self.jobOfferViewModel.jobOfferDescription];
}

-(UILabel *)resizeLabel:(UILabel*)label andText: (NSString*)text{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width;
    CGFloat screenHeight = screenRect.size.height;
    
    [label setText: @""];
    UILabel *newLabel = [[UILabel alloc] initWithFrame:CGRectMake(label.frame.origin.x, label.frame.origin.y, screenWidth / 2, label.frame.size.height)];
    [newLabel setTextColor: label.textColor];
    [newLabel setBackgroundColor: [UIColor clearColor]];
    [newLabel setFont: label.font];
    [newLabel setText: text];
    [newLabel setNumberOfLines:0];
    [newLabel sizeToFit];
    [self.view addSubview:newLabel];
    return newLabel;
}

- (IBAction)jobOfferSwipe:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            if (userData.profileType == JobSeeker){
                [self addLike];
            }
            
            message = @"Swiped right like";
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            if (userData.profileType == JobSeeker){
                [self addDislike];
            }
            
            message = @"Swiped left";
            break;
        default:
            message =@"Not swiped";
            break;
    }
    
    NSLog(@"%@", message);

}

-(void) addLike{
    NSString* accountType = [NSString stringWithFormat:@"%u",[UserDataModel getAccountType]];
    NSString* recruiterProfileId = [NSString stringWithFormat:@"%ld",self.jobOfferViewModel.recruiterProfileId];
    NSString* jobOfferId = [NSString stringWithFormat:@"%ld",self.jobOfferViewModel.jobOfferId];
    
    AddLikeViewModel* addLikeModel = [AddLikeViewModel likeWithLikedId:recruiterProfileId andMyAccountType:accountType andJobOfferId:jobOfferId];

    connectionType = @"AddLike";
    [jobOfferMatchService addLikeWithModel:addLikeModel andTarget:self];
}

-(void) addDislike{
    NSString* accountType = [NSString stringWithFormat:@"%u",[UserDataModel getAccountType]];
    NSString* recruiterProfileId = [NSString stringWithFormat:@"%ld",self.jobOfferViewModel.recruiterProfileId];
    NSString* jobOfferId = [NSString stringWithFormat:@"%ld",self.jobOfferViewModel.jobOfferId];
    
    AddDislikeViewModel* addDislikeModel = [AddDislikeViewModel dislikeWithDislikedId:recruiterProfileId andMyAccountType:accountType andJobOfferId:jobOfferId];
    connectionType = @"AddDislike";
    [jobOfferMatchService addDislikeWithModel:addDislikeModel andTarget:self];
}
@end
