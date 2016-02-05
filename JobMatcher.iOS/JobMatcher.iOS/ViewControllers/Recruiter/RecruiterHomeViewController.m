//
//  RecruiterHomeViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "RecruiterHomeViewController.h"
#import "UserDataModel.h"
#import "HelperMethods.h"
#import "RecruiterService.h"
#import "RecruiterProfileViewModel.h"
#import "CollapseClick.h"
#import "JobOfferTableViewCell.h"
#import "JobOfferViewModel.h"
#import "JobOfferViewController.h"
#import "RecruiterMatchesViewController.h"
#import "AccountService.h"
#import "InternetConnectionChecker.h"
#import "GlobalConstants.h"

@interface RecruiterHomeViewController (){
    NSString* message;
    RecruiterProfileViewModel* recruiterProfileViewModel;
    UITableView* jobOffersTableView;
    JobOfferViewModel* selectedJobOffer;
    UserDataModel* userData;
}

@end

@implementation RecruiterHomeViewController
NSString* const SegueFromRecruiterToJobSeeker = @"segueFromRecruiterToJobSeeker";
NSString* const SegueFromRecruiterToJobOffer = @"segueFromRecruiterToJobOffer";
NSString* const SegueFromRecruiterToMatches = @"segueFromRecruiterToMatches";
NSString* const SegueFromRecruiterHomeToLogin = @"segueFromRecruiterHomeToLogin";

int const NumberOfSectionsInRecruiter = 1;
int const JobOffersTableRowHeight = 65;

static RecruiterService* recruiterService;
static AccountService* accountRecruiterService;
static InternetConnectionChecker *internetCheker;

static NSString* jobOffersTableCellIdentifier = @"JobOfferTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    internetCheker = [[InternetConnectionChecker alloc] init];
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
        [HelperMethods addAlert:NotConnectedMessage];
        
        return;
    }
    
    userData = [[UserDataModel alloc] init];
    self.recruiterHelloLabel.text = [NSString stringWithFormat:@"%@", userData.username];
    self.recruiterProfileImage.image = [UIImage imageNamed:@"default_profile_img.jpg"];
    
    [self.recruiterBrowseJobSeekersButton setBackgroundImage:[UIImage imageNamed:@"job-seekers-icon.png"]
                                           forState:UIControlStateNormal];
    
    [self.recruiterLogoutButton setBackgroundImage:[UIImage imageNamed:@"logout-icon.png"]
                                           forState:UIControlStateNormal];
    
    [self.recruiterMatchesButton setBackgroundImage:[UIImage imageNamed:@"matches-icon.png"]
                                           forState:UIControlStateNormal];
    
    [HelperMethods setSackBarButtonText:self andText:@""];
    [HelperMethods setPageTitle:self andTitle:@"Profile"];
    
    recruiterService = [[RecruiterService alloc] init];
    [recruiterService getProfileWithTarget:self];
    
    accountRecruiterService = [[AccountService alloc] init];
    
    [self attachLongPressGesture];
    self.recruiterCollapseClickScrollView.CollapseClickDelegate = self;
    [self.recruiterCollapseClickScrollView reloadCollapseClick];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //self.helloLabel.text = [NSString stringWithFormat:@"Hello, %@", userData.username];
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
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    //    NSLog(@"%@", error);
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    NSLog(@"%@", json);
    if(error)
        NSLog(@"%@",error.description);
    
//    if ([connectionType isEqualToString:@"GetProfile"]){
        recruiterProfileViewModel = [RecruiterProfileViewModel fromJsonDictionary:json];
    [jobOffersTableView reloadData];
    
    [self.recruiterCollapseClickScrollView reloadCollapseClick];
    [self.recruiterCollapseClickScrollView openCollapseClickCellAtIndex:0 animated:NO];    
    
}

//- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
//    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
//    long code = [httpResponse statusCode];
//    NSLog(@"%@", httpResponse);
//    
//    // TODO browse another profile
//    if ([connectionType isEqualToString:@"AddLike"]){
//        if (code == 200){
//            message = @"Liked!";
//            [HelperMethods addAlert:message];
//        }
//        
//        connectionType = @"";
//    }
//    
//    if (code != 200) {
//        message = @"Nope. Try again!";
//        [HelperMethods addAlert:message];
//    }
//}

// collapse click
// collapse click

-(int)numberOfCellsForCollapseClick {
    return NumberOfSectionsInRecruiter;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    NSArray* sesctionTitles = [[NSArray alloc] initWithObjects:@"My Job Offers", nil];
    return [sesctionTitles objectAtIndex:index];
}

-(UITableView*)getJobOffersView{
    NSInteger tableHeight = JobOffersTableRowHeight * recruiterProfileViewModel.jobOffers.count;
    jobOffersTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, tableHeight)];
    
    [jobOffersTableView setDataSource:self];
    [jobOffersTableView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:jobOffersTableCellIdentifier bundle:nil];
    [jobOffersTableView registerNib:nib forCellReuseIdentifier:jobOffersTableCellIdentifier];
    
    jobOffersTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:jobOffersTableView];
    return jobOffersTableView;
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return [self getJobOffersView];
            break;
    }
    
    return nil;
}

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
}

-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithRed:0.208 green:0.459 blue:0.502 alpha:1] /*#357580*/;
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithRed:0.773 green:0.855 blue:0.867 alpha:1] /*#c5dadd*/;
}


// table view
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == jobOffersTableView){
        return recruiterProfileViewModel.jobOffers.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == jobOffersTableView){
        JobOfferTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:jobOffersTableCellIdentifier];
        
        if (recruiterProfileViewModel.jobOffers.count > 0) {
            JobOfferViewModel *jobOfferViewModel = recruiterProfileViewModel.jobOffers[indexPath.row];
            cell.jobOfferTitleLabel.text = jobOfferViewModel.title;
            cell.jobOfferLocationLabel.text = jobOfferViewModel.location;
            cell.jobOfferSalaryLabel.text = [NSString stringWithFormat:@"%.02f €", jobOfferViewModel.salary];
            
            return cell;
        }
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == jobOffersTableView){
        return JobOffersTableRowHeight;
    }
    
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Value Selected by user
    selectedJobOffer = [recruiterProfileViewModel.jobOffers objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:SegueFromRecruiterToJobOffer sender:tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:SegueFromRecruiterToJobOffer]){
        JobOfferViewController* toJobOfferViewController = segue.destinationViewController;
        toJobOfferViewController.jobOfferViewModel = selectedJobOffer;
    } else if([segue.identifier isEqualToString:SegueFromRecruiterToMatches]){

        NSArray* matches = recruiterProfileViewModel.matchedJobSeekers;
        
        RecruiterMatchesViewController* toMatchesViewController = segue.destinationViewController;
        toMatchesViewController.recruiterMatches = matches;
    }
}
//------

- (IBAction)browseJobSeekersButtonTap:(id)sender {
     [self performSegueWithIdentifier:SegueFromRecruiterToJobSeeker sender:self];
}
- (IBAction)toMatchesButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueFromRecruiterToMatches sender:self];
}
- (IBAction)recruiterLogoutButtonTap:(id)sender {
    [accountRecruiterService logout];
    [self performSegueWithIdentifier:SegueFromRecruiterHomeToLogin sender:self];
}

// gestures
-(void)attachLongPressGesture{
    self.recruiterLongPressRecognizer
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(recruiterLongPress:)];
    self.recruiterLongPressRecognizer.minimumPressDuration = .5; //seconds
    self.recruiterLongPressRecognizer.delegate = self;
    self.recruiterLongPressRecognizer.delaysTouchesBegan = YES;
    self.recruiterProfileImage.userInteractionEnabled = YES;
    [self.recruiterProfileImage addGestureRecognizer:self.recruiterLongPressRecognizer];
}


- (void)recruiterLongPress:(UILongPressGestureRecognizer *)sender
{
    if ([sender isEqual:self.recruiterLongPressRecognizer]) {
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            //TODO get camera
            [HelperMethods addAlert:@"Long press yay!"];
        }
    }
}
@end
