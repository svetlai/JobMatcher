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
#import "InternetConnectionChecker.h"

@interface JobOfferViewController (){
    UserDataModel* userData;
    NSString* message;
    NSString* connectionType;
}

@end

@implementation JobOfferViewController
static MatchService* jobOfferMatchService;
static JobOfferService* jobOfferService;
static InternetConnectionChecker *internetCheker;
NSString* const SegueFromJobOfferToJobSeeker = @"segueFromJobOfferToJobSeeker";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    internetCheker = [[InternetConnectionChecker alloc] init];
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
        [HelperMethods addAlert:NotConnectedMessage];
        
        return;
    }
    
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"Job Offer"];
    
    userData = [[UserDataModel alloc] init];
    jobOfferMatchService = [[MatchService alloc] init];
    jobOfferService = [[JobOfferService alloc] init];
    
    [self handleVisibility];
    
    if (self.jobOfferViewModel != nil && userData.profileType == Recruiter){
        [self loadData];
    } else if (userData.profileType == JobSeeker){
        [jobOfferService getRandomOfferWithTarget:self];
        connectionType = @"GetOffer";
    }

    [self attachSwipeGesture];
    
        self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//------------- view ------------
-(void) handleVisibility{
    if (self.matched){
        self.jobOfferSwipeHintLabel.hidden = YES;
    } else if (userData.profileType == JobSeeker){
        self.jobOfferSwipeHintLabel.hidden = NO;
    } else if (userData.profileType == Recruiter){
        self.jobOfferSwipeHintLabel.hidden = YES;
    }
}

-(void) loadData{
    [HelperMethods setPageTitle:self andTitle:self.jobOfferViewModel.title];
    self.jobOfferIndustryLabel.text = [Industries objectAtIndex:self.jobOfferViewModel.industry];
    self.jobOfferLocationLabel.text = self.jobOfferViewModel.location;
    self.jobOfferWorkHoursLabel.text = [WorkHours objectAtIndex: self.jobOfferViewModel.workHours];
    self.jobOfferSalaryLabel.text = [NSString stringWithFormat:@"%.02f €", self.jobOfferViewModel.salary];
    self.jobOfferDescriptionLabel.text = self.jobOfferViewModel.jobOfferDescription;
}

// -------connection---------
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:nil];
    //NSLog(@"%@", json);
    if ([connectionType isEqualToString:@"AddLike"] || [connectionType isEqualToString:@"AddDislike"]){
        [jobOfferService getRandomOfferWithTarget:self];
         connectionType = @"GetOffer";
        
    } else if ([connectionType isEqualToString:@"GetOffer"]){
        self.jobOfferViewModel = [JobOfferViewModel fromJsonDictionary:json];
        [self loadData];
        [self viewDidLoad];

        connectionType = @"";
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    //NSLog(@"%@", httpResponse);
    
    if ([connectionType isEqualToString:@"AddLike"]){
        if (code == 200){
            message = @"Liked!";
            [HelperMethods addAlert:message];
        }

    } else if ([connectionType isEqualToString:@"AddDislike"]){
        if (code == 200){
            message = @"Disliked!";
            [HelperMethods addAlert:message];
        }
    }
    
 // TODO - improve browsing logic and end of joboffers
    if (code != 200) {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

//---------- gestures ------------

-(void) attachSwipeGesture{
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(jobOfferSwipe:)];
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(jobOfferSwipe:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    [self.view addGestureRecognizer:leftSwipeRecognizer];
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
