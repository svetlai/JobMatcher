//
//  JobSeekerHomeViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"

@import AddressBook;
#import "JobSeekerHomeViewController.h"
#import "UserDataModel.h"
#import "HelperMethods.h"
#import "JobSeekerService.h"
#import "JobSeekerProfileViewModel.h"
#import "ProjectViewModel.h"
#import "ExperienceViewModel.h"
#import "EducationViewModel.h"
#import "SkillViewModel.h"
#import "ProjectsTableViewCell.h"
#import "SkillsTableViewCell.h"
#import "ExperienceTableViewCell.h"
#import "EducationTableViewCell.h"
#import "QuartzCore/QuartzCore.h"
#import "CollapseClick.h"
#import "UILabel+dynamicSizeMe.h"
#import "HelperMethods.h"
#import "MatchService.h"
#import "AddLikeViewModel.h"
#import "AddDislikeViewModel.h"
#import "GlobalConstants.h"
#import "JobSeekerMatchesViewController.h"
#import "AccountService.h"
#import "InternetConnectionChecker.h"
#import "JobMatcherDatabase.h"
#import "JobMatcher_iOS-Swift.h"


@interface JobSeekerHomeViewController (){
    NSString* message;
    JobSeekerProfileViewModel* jobSeekerViewModel;
    UITableView* projectsTableView;
    UITableView* skillsTableView;
    UITableView* experienceTableView;
    UITableView* educationTableView;
    NSString* connectionType;
    UserDataModel* userData;
    UIImagePickerController *jobSeekerImagePicker;
    JobMatcherDatabase* db;
    NSInteger deleteProjectSender;
    NSInteger deleteSkillSender;
    UILabel *summaryLabel;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end

@implementation JobSeekerHomeViewController

int const NumberOfSections = 5;

int const ProjectsTableRowHeight = 140;
int const SkillsTableRowHeight = 50;
int const ExperienceTableRowHeight = 150;
int const EducationTableRowHeight = 150;

NSString* const SegueFromJobSeekerToRecruiter = @"segueFromJobSeekerToRecruiter";
NSString* const SegueFromJobSeekerToJobOffer = @"segueFromJobSeekerToJobOffer";
NSString* const SegueFromJobSeekerToMatches = @"segueFromJobSeekerToMatches";
NSString* const SegueFromJobSeekerHomeToLogin = @"segueFromJobSeekerHomeToLogin";
NSString* const SegueFromJobSeekerToAddProject = @"segueFromJobSeekerToAddProject";
NSString* const SegueFromJobSeekerToAddSkill = @"segueFromJobSeekerToAddSkill";
NSString* const SegueFromJobSeekerToAddSummary = @"segueFromJobSeekerToAddSummary";

static NSString* projectsTableCellIdentifier = @"ProjectsTableViewCell";
static NSString* skillsTableCellIdentifier = @"SkillsTableViewCell";
static NSString* experienceTableCellIdentifier = @"ExperienceTableViewCell";
static NSString* educationTableCellIdentifier = @"EducationTableViewCell";

static JobSeekerService* service;
static MatchService* matchService;
static AccountService* accountService;
static InternetConnectionChecker *internetCheker;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    internetCheker = [[InternetConnectionChecker alloc] init];
    NSString *status = [internetCheker getConnectionSatus];
    
    if ([status isEqualToString:NotConnectedStatus]) {
        [HelperMethods addAlert:NotConnectedMessage];
        
        return;
    }
    
    service = [[JobSeekerService alloc] init];
    matchService = [[MatchService alloc] init];
    accountService = [[AccountService alloc] init];
    userData = [[UserDataModel alloc] init];
    db = [JobMatcherDatabase database];

    connectionType = @"GetProfile";

    [HelperMethods setSackBarButtonText:self andText:@""];

    [self setCollapseClick];
    [self handleButtons];
    [self handleLabelVisibility];
    
    if (userData.profileType == JobSeeker){
        [service getProfileWithTarget:self];
        [HelperMethods setPageTitle:self andTitle:@"Profile"];
    } else if (userData.profileType == Recruiter){
        if (self.jobSeekerProfileViewModel == nil){
            [service getRandomProfileWithTarget:self];
            [HelperMethods setPageTitle:self andTitle:jobSeekerViewModel.username];
        } else {
            jobSeekerViewModel = self.jobSeekerProfileViewModel;
            [HelperMethods setPageTitle:self andTitle:self.jobSeekerProfileViewModel.username];
            self.helloLabel.text = [NSString stringWithFormat:@"%@",jobSeekerViewModel.username];
            [self reloadData];
        }
    }
    
    [self setProfileImage];
    
    [self attachSwipeGesture];
    [self attachLongPressGesture];
    
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    self.jobSeekerProfileViewModel = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

// --------- view -----------

-(void) getScreenSize{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
}

-(void) handleButtons{
    [self.jobSeekerMatchesButton setBackgroundImage:[UIImage imageNamed:@"matches-icon.png"]
                                           forState:UIControlStateNormal];
    [self.jobSeekerBrowseOffersButton setBackgroundImage:[UIImage imageNamed:@"job-icon.png"]
                                                forState:UIControlStateNormal];
    [self.jobSeekerLogoutButton setBackgroundImage:[UIImage imageNamed:@"logout-icon.png"]
                                          forState:UIControlStateNormal];
    
    [self.jobSeekerEditProfileButton setBackgroundImage:[UIImage imageNamed:@"edit-icon.png"]
                                          forState:UIControlStateNormal];
    
    if (userData.profileType == JobSeeker){
        self.jobSeekerMatchesButton.hidden = NO;
        self.jobSeekerBrowseOffersButton.hidden = NO;
        self.jobSeekerLogoutButton.hidden = NO;
        self.jobSeekerEditProfileButton.hidden = NO;
    } else if (userData.profileType == Recruiter){
        self.jobSeekerMatchesButton.hidden = YES;
        self.jobSeekerBrowseOffersButton.hidden = YES;
        self.jobSeekerLogoutButton.hidden = YES;
        self.jobSeekerEditProfileButton.hidden = YES;
        self.addProjectBlueButton.hidden = YES;
        self.addSkillBlueButton.hidden = YES;
    }
}
-(void) handleLabelVisibility{
    if (self.matched){
        self.jobSeekerSwipeHintNo.hidden = YES;
        self.jobSeekerSwipeHintYes.hidden = YES;
    } else if (userData.profileType == JobSeeker){
        self.jobSeekerSwipeHintNo.hidden = YES;
        self.jobSeekerSwipeHintYes.hidden = YES;
    } else if (userData.profileType == Recruiter){
        self.jobSeekerSwipeHintNo.hidden = NO;
        self.jobSeekerSwipeHintYes.hidden = NO;
    }
}

-(void) handleButtonVisibility: (UIButton*) button{
    if (userData.profileType == JobSeeker){
        button.hidden = NO;
    } else if (userData.profileType == Recruiter){
        button.hidden = YES;
    }
}

- (void) setProfileImage{
    NSString* imagePath;
    if (userData.profileType == JobSeeker){
        imagePath = [db getImagePathWithEmail:userData.username];
    } else{
        imagePath = [db getImagePathWithEmail:jobSeekerViewModel.username];
    }
    NSURL* assetURL = [NSURL URLWithString:imagePath];
    if (assetURL == nil){
        self.profileImage.image = [UIImage imageNamed:@"default_profile_img.jpg"];
    }else{
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        [library assetForURL:assetURL resultBlock:^(ALAsset *asset)
         {
             UIImage  *copyOfOriginalImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullResolutionImage]];
             NSLog(@"imageeeeee");
             self.profileImage.image = copyOfOriginalImage;
         }
                failureBlock:^(NSError *error)
         {
             NSLog(@"%@", error.description);
         }];
    }
}

// ----------collapse click------------

-(void) setCollapseClick{
    self.collapseClickScrollView.minimumZoomScale=0.5;
    self.collapseClickScrollView.maximumZoomScale=1.5;
    self.collapseClickScrollView.contentSize=CGSizeMake(1280, 960);
    [self.collapseClickScrollView setClipsToBounds:YES];
    self.collapseClickScrollView.delegate=self;
    
    self.collapseClickScrollView.CollapseClickDelegate = self;
    [self.collapseClickScrollView reloadCollapseClick];
}

-(int)numberOfCellsForCollapseClick {
    return NumberOfSections;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    NSArray* sesctionTitles = [[NSArray alloc] initWithObjects:@"Summary", @"Skills", @"Projects", @"Experience", @"Education", nil];
    return [sesctionTitles objectAtIndex:index];
}

-(UIView *)getSummaryView{
    summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, screenWidth, 20)];
    [summaryLabel setTextColor: [UIColor colorWithRed:0.263 green:0.522 blue:0.588 alpha:1]];
    [summaryLabel setBackgroundColor:[UIColor clearColor]];
    [summaryLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];

    if (![jobSeekerViewModel.summary isEqual:[NSNull null]]){
        [summaryLabel setText: jobSeekerViewModel.summary];
    }
    
    [summaryLabel setNumberOfLines:0];
    [summaryLabel sizeToFit];
    [self.view addSubview:summaryLabel];

    return (UIView *)summaryLabel;
}

-(UITableView*)getProjectsView{
    NSInteger tableHeight = ProjectsTableRowHeight * jobSeekerViewModel.projects.count;
    projectsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, tableHeight)];
    [projectsTableView setDataSource:self];
    [projectsTableView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:projectsTableCellIdentifier bundle:nil];
    [projectsTableView registerNib:nib forCellReuseIdentifier:projectsTableCellIdentifier];
    
    projectsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:projectsTableView];
    return projectsTableView;
}

-(UITableView*)getSkillsView{
    NSInteger tableHeight = SkillsTableRowHeight * jobSeekerViewModel.skills.count;
    skillsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, tableHeight)];
    
    [skillsTableView setDataSource:self];
    [skillsTableView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:skillsTableCellIdentifier bundle:nil];
    [skillsTableView registerNib:nib forCellReuseIdentifier:skillsTableCellIdentifier];
    
    skillsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:skillsTableView];
    return skillsTableView;
}

-(UITableView*)getExperienceView{
    NSInteger tableHeight = ExperienceTableRowHeight * jobSeekerViewModel.experience.count;
    experienceTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, tableHeight)];
    
    [experienceTableView setDataSource:self];
    [experienceTableView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:experienceTableCellIdentifier bundle:nil];
    [experienceTableView registerNib:nib forCellReuseIdentifier:experienceTableCellIdentifier];
    
    experienceTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:experienceTableView];
    return experienceTableView;
}

-(UITableView*)getEducationView{
    NSInteger tableHeight = EducationTableRowHeight * jobSeekerViewModel.education.count;
    educationTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, tableHeight)];
    
    [educationTableView setDataSource:self];
    [educationTableView setDelegate:self];
    
    UINib *nib = [UINib nibWithNibName:educationTableCellIdentifier bundle:nil];
    [educationTableView registerNib:nib forCellReuseIdentifier:educationTableCellIdentifier];
    
    educationTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:educationTableView];
    return educationTableView;
}

-(UIView *)viewForCollapseClickContentViewAtIndex:(int)index {
    switch (index) {
        case 0:
            return [self getSummaryView];
            break;
        case 1:
            return [self getSkillsView];
            break;
        case 2:
            return [self getProjectsView];
            break;
        case 3:
            return [self getExperienceView];
            break;
        case 4:
            return [self getEducationView];
            break;
        default:
             return nil;
            break;
    }
}

-(UIColor *)colorForCollapseClickTitleViewAtIndex:(int)index {
    return [UIColor colorWithRed:0.949 green:0.929 blue:0.906 alpha:1] /*#f2ede7*/; //[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
}

-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithRed:0.208 green:0.459 blue:0.502 alpha:1] /*#357580*/;
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithRed:0.773 green:0.855 blue:0.867 alpha:1] /*#c5dadd*/;
}

// ---------table view-----------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == projectsTableView){
        return jobSeekerViewModel.projects.count;
    } else if (tableView == skillsTableView){
        return jobSeekerViewModel.skills.count;
    } else if (tableView == experienceTableView){
        return jobSeekerViewModel.experience.count;
    } else if (tableView == educationTableView){
        return jobSeekerViewModel.education.count;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projectsTableCellIdentifier];
    
    if (tableView == projectsTableView){
        ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projectsTableCellIdentifier];

         if (jobSeekerViewModel.projects.count > 0) {
             ProjectViewModel *projectViewModel = jobSeekerViewModel.projects[indexPath.row];
             cell.projectTitleLabel.text = projectViewModel.title;
             cell.projectDescriptionLabel.text = projectViewModel.projectDescription;
             cell.projectUrlLabel.text = projectViewModel.url;
             
             cell.projectDeleteButton.tag = indexPath.row;
             [cell.projectDeleteButton addTarget:self action:@selector(deleteProjectButtonTap:) forControlEvents:UIControlEventTouchUpInside];
               [cell.projectAddButton addTarget:self action:@selector(addProjectButtonTap:) forControlEvents:UIControlEventTouchUpInside];
             
            [self handleButtonVisibility:cell.projectAddButton];
            [self handleButtonVisibility:cell.projectEditButton];
            [self handleButtonVisibility:cell.projectDeleteButton];
             
             return cell;
         }
    } else if (tableView == skillsTableView){
        
        SkillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:skillsTableCellIdentifier];
        
        if (jobSeekerViewModel.skills.count > 0) {
            SkillViewModel *skillViewModel = jobSeekerViewModel.skills[indexPath.row];
            cell.skillNameLabel.text = skillViewModel.name;
            cell.skillLevelLabel.text = [NSString stringWithFormat:@"%ld", skillViewModel.level];
            
            cell.skillDeleteButton.tag = indexPath.row;
            [cell.skillDeleteButton addTarget:self action:@selector(deleteSkillButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            [cell.skillAddButton addTarget:self action:@selector(addSkillButtonTap:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self handleButtonVisibility:cell.skillAddButton];
            [self handleButtonVisibility:cell.skillEditButton];
            [self handleButtonVisibility:cell.skillDeleteButton];
        }
        
        return cell;
    } else if (tableView == experienceTableView){
        
        ExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:experienceTableCellIdentifier];
        if (jobSeekerViewModel.experience.count > 0) {
            ExperienceViewModel *experienceViewModel = jobSeekerViewModel.experience[indexPath.row];
            cell.experiencePositionLabel.text = experienceViewModel.position;
            cell.experienceOrganizationLabel.text = experienceViewModel.organization;
        
            cell.experienceDescriptionLabel.text = experienceViewModel.experienceDescription;
            cell.experienceIndustryLevel.text = [Industries objectAtIndex: experienceViewModel.industry];
            cell.experienceStartDateLabel.text = [HelperMethods getShortDateString:experienceViewModel.startDate];
        
            if (experienceViewModel.endDate == nil){
                cell.experienceEndDateLabel.text = @"Present";
            } else {
                cell.experienceEndDateLabel.text = [HelperMethods getShortDateString:experienceViewModel.endDate];
            }
            
            
            [self handleButtonVisibility:cell.experienceAddButton];
            [self handleButtonVisibility:cell.experienceEditButton];
            [self handleButtonVisibility:cell.experienceDeleteButton];
        }
    
        return cell;
    }  else if (tableView == educationTableView){
        EducationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:educationTableCellIdentifier];
        
        if (jobSeekerViewModel.education.count > 0) {
            EducationViewModel *educationViewModel = jobSeekerViewModel.education[indexPath.row];
            cell.educationOrganizationLabel.text = educationViewModel.organization;
            cell.educationSpecialtyLabel.text = educationViewModel.specialty;
        
            // TODO: get enumeration!
            cell.educationDegreeLabel.text = [Degree objectAtIndex: educationViewModel.degree];
            cell.educationIndustryLabel.text = [Industries objectAtIndex: educationViewModel.industry];
            cell.educationStartDateLabel.text = [HelperMethods getShortDateString:educationViewModel.startDate];
            cell.educationDescriptionLabel.text = educationViewModel.educationDescription;
            //        float expectedHeight = [cell.educationDescriptionLabel expectedHeight];
            //        EducationTableRowHeight += expectedHeight;
            //        [self setDynamicLabel:cell.educationDescriptionLabel andHeight:expectedHeight andWidth:tableView.frame.size.width andView:cell];
        
            if (educationViewModel.endDate == nil){
                cell.educationEndDateLabel.text = @"Present";
            } else {
                cell.educationEndDateLabel.text = [HelperMethods getShortDateString:educationViewModel.endDate];
            }
            
            [self handleButtonVisibility:cell.educationAddButton];
            [self handleButtonVisibility:cell.educationEditButton];
            [self handleButtonVisibility:cell.educationDeleteButton];
        }
        
        return cell;
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == projectsTableView){
         return ProjectsTableRowHeight;
    } else if (tableView == skillsTableView){
        return SkillsTableRowHeight;
    } else if (tableView == experienceTableView){
        return ExperienceTableRowHeight;
    } else if (tableView == educationTableView){
        return EducationTableRowHeight;
    }
    
    return 20;
}

// ----------- connection ------------
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
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
    // NSLog(@"%@", json);
    if(error){
        NSLog(@"%@",error.description);
    }
    
    
    if ([connectionType isEqualToString:@"DeleteProject"] || [connectionType isEqualToString:@"DeleteSkill"]){
        connectionType = @"GetProfile";
        return;
    }else if ([connectionType isEqualToString:@"GetProfile"]){
        jobSeekerViewModel = [JobSeekerProfileViewModel fromJsonDictionary:json];
        
        self.helloLabel.text = [NSString stringWithFormat:@"%@", jobSeekerViewModel.username];
        [self setProfileImage];
        if ([jobSeekerViewModel.firstName isEqual:[NSNull null]]) {
            jobSeekerViewModel.firstName = @"";
        }
        
        if ([jobSeekerViewModel.lastName isEqual:[NSNull null]]) {
            jobSeekerViewModel.lastName = @"";
        }
        
        NSString* name = [NSString stringWithFormat:@"%@ %@",jobSeekerViewModel.firstName, jobSeekerViewModel.lastName];
        
        self.jobSeekerProfileName.text = name;
        
        if (![jobSeekerViewModel.phoneNumber isEqual:[NSNull null]]) {
            self.jobSeekerPhoneLabel.text = jobSeekerViewModel.phoneNumber;
        }
        
        if (![jobSeekerViewModel.currentPosition isEqual:[NSNull null]]) {
            self.jobSeekerProfilePosition.text = jobSeekerViewModel.currentPosition;
        }
        
        if (userData.profileType == JobSeeker){
            if (jobSeekerViewModel.projects.count > 0){
                self.addProjectBlueButton.hidden = YES;
            }else{
                self.addProjectBlueButton.hidden = NO;
            }
            
            if (jobSeekerViewModel.skills.count > 0){
                self.addSkillBlueButton.hidden = YES;
            }else{
                self.addSkillBlueButton.hidden = NO;
            }
        }
        
        [self reloadData];
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    // NSLog(@"%@", httpResponse);
    
    if ([connectionType isEqualToString:@"AddLike"]){
        if (code == 200){
            message = @"Liked!";
            [HelperMethods addAlert:message];
            [service getRandomProfileWithTarget:self];
        }
        
        connectionType = @"GetProfile";
    } else if ([connectionType isEqualToString:@"AddDislike"]){
        if (code == 200){
            message = @"Disliked!";
            [HelperMethods addAlert:message];
            [service getRandomProfileWithTarget:self];
        }
        
        connectionType = @"GetProfile";
    }  else if ([connectionType isEqualToString:@"DeleteProject"]){
        if (code == 200){
            message = @"Project deleted successfully!";
            [service getProfileWithTarget:self];
            [HelperMethods addAlert:message];
        }
    } else if ([connectionType isEqualToString:@"DeleteSkill"]){
        if (code == 200){
            message = @"Skill deleted successfully!";
            [service getProfileWithTarget:self];
            [HelperMethods addAlert:message];
        }
    }
    
    // TODO - improve browsing logic and end of jobseekers
    if (code == 400 && jobSeekerViewModel.username == NULL){
        message = @"No more Job Seekers to browse.";
        [HelperMethods addAlert:message];
        [self performSegueWithIdentifier:SegueFromJobSeekerToRecruiter sender:self];
        return;
    }
    
    if (code != 200) {
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void) reloadData{
    [projectsTableView reloadData];
    [experienceTableView reloadData];
    [skillsTableView reloadData];
    [educationTableView reloadData];
    
    [self.collapseClickScrollView reloadCollapseClick];
    [self.collapseClickScrollView openCollapseClickCellAtIndex:0 animated:NO];
    //    for (int i = 0; i< NumberOfSections; i++) {
    //        [self.collapseClickScrollView openCollapseClickCellAtIndex:i animated:NO];
    //    }
}

// ----------- contacts --------------
- (void)jobSeekerLongPress:(UILongPressGestureRecognizer *)sender
{
    if ([sender isEqual:self.jobSeekerLongPressRecognizer]) {
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            [self captureImage];
        }
    }else if ([sender isEqual:self.jobSeekerLabelLongPressRecognizer]){
        if (sender.state == UIGestureRecognizerStateBegan)
        {
            if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
                ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted){
                NSLog(@"Denied");
                [HelperMethods addAlert:@"Cannot add contact. Permission required."];
            } else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized){
                NSLog(@"Authorized");
                  [self addContact];
            } else{ //ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined
                NSLog(@"Not determined");
                ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         if (!granted){
                             NSLog(@"Just denied");
                             [HelperMethods addAlert:@"Cannot add contact. Permission required."];
                             return;
                         }
                         NSLog(@"Just authorized");
                         [  self addContact];
                     });
                });
            }
        }
    }
}

-(void)addContact{
    NSString *firstName = userData.username;
    NSString *phoneNumber = self.jobSeekerPhoneLabel.text;
    NSData *image = UIImageJPEGRepresentation(self.profileImage.image, 0.7f);
    
    ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, nil);
    ABRecordRef record = ABPersonCreate();
    ABRecordSetValue(record, kABPersonFirstNameProperty, (__bridge CFStringRef)firstName, nil);
    
    ABMutableMultiValueRef phoneNumbers = ABMultiValueCreateMutable(kABMultiStringPropertyType);
    
    ABMultiValueAddValueAndLabel(phoneNumbers, (__bridge CFStringRef)phoneNumber, kABPersonPhoneMainLabel, NULL);
    ABRecordSetValue(record, kABPersonPhoneProperty, phoneNumbers, nil);
    
    ABPersonSetImageData(record, (__bridge CFDataRef)image, nil);
    
    // check for duplicates
    NSArray *allContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBookRef);
    for (id contact in allContacts){
        ABRecordRef thisContact = (__bridge ABRecordRef)contact;
        if (CFStringCompare(ABRecordCopyCompositeName(thisContact),
                            ABRecordCopyCompositeName(record), 0) == kCFCompareEqualTo){
            //The contact already exists!
            [HelperMethods addAlert:@"Contact already exists."];
            return;
        }
    }
    
    // save
    ABAddressBookAddRecord(addressBookRef, record, nil);
    ABAddressBookSave(addressBookRef, nil);
    [HelperMethods addAlert:@"Contact added successfully."];
}

// --------------- camera ---------------

-(void)captureImage{
    jobSeekerImagePicker = [[UIImagePickerController alloc] init];
    jobSeekerImagePicker.delegate = self;
    jobSeekerImagePicker.allowsEditing = NO; //YES
    
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
    {
        jobSeekerImagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        jobSeekerImagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [self presentModalViewController:jobSeekerImagePicker animated:YES];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.profileImage.image = image;
    
     __block NSURL *imagePath;
    if(jobSeekerImagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        imagePath = [self saveImageToCameraRoll:image];
    }else{
        imagePath = (NSURL *)[info valueForKey:UIImagePickerControllerReferenceURL];
    }
    
    NSString* imagePathAsString = imagePath.absoluteString;
    [db addImagePath:imagePathAsString withEmail:userData.username];
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissModalViewControllerAnimated:YES];
}

-(NSURL *)saveImageToCameraRoll: (UIImage*)image{
    __block NSURL *imagePath;
    if(jobSeekerImagePicker.sourceType == UIImagePickerControllerSourceTypeCamera){
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
        // Request to save the image to camera roll
        [library writeImageToSavedPhotosAlbum:[image CGImage] orientation:(ALAssetOrientation)[image imageOrientation] completionBlock:^(NSURL *assetURL, NSError *error){
            if (error) {
                [HelperMethods addAlert:@"Sorry, we couldn't save your photo."];
            } else {
                imagePath = assetURL;
            }
        }];
    }
    
    return imagePath;
}

// ---------- gestures ------------

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:SegueFromJobSeekerToMatches]){
        JobSeekerMatchesViewController* toJobOfferViewController = segue.destinationViewController;
        toJobOfferViewController.jobOfferMatches = jobSeekerViewModel.selectedJobOffers;
    }
}

-(void)attachSwipeGesture{
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(jobSeekerSwipe:)];
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                              action:@selector(jobSeekerSwipe:)];
    leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    [self.view addGestureRecognizer:leftSwipeRecognizer];
}


- (IBAction)jobSeekerSwipe:(UISwipeGestureRecognizer *)sender {
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
            if (userData.profileType == Recruiter){
                [self addLike];
            }
            
            message = @"Swiped right like";
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            if (userData.profileType == Recruiter){
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
    NSString* jobSeekerProfileId = [NSString stringWithFormat:@"%ld",jobSeekerViewModel.profileId];
    
    AddLikeViewModel* addLikeModel = [AddLikeViewModel likeWithLikedId:jobSeekerProfileId andMyAccountType:accountType];
    connectionType = @"AddLike";
    [matchService addLikeWithModel:addLikeModel andTarget:self];
}

-(void) addDislike{
    NSString* accountType = [NSString stringWithFormat:@"%u",[UserDataModel getAccountType]];
    NSString* jobSeekerProfileId = [NSString stringWithFormat:@"%ld",jobSeekerViewModel.profileId];
    
    AddDislikeViewModel* addDislikeModel = [AddDislikeViewModel dislikeWithDislikedId:jobSeekerProfileId andMyAccountType:accountType];
    connectionType = @"AddDislike";
    [matchService addDislikeWithModel:addDislikeModel andTarget:self];
}

-(void)attachLongPressGesture{
    if (userData.profileType == JobSeeker){
        self.jobSeekerLongPressRecognizer
        = [[UILongPressGestureRecognizer alloc]
           initWithTarget:self action:@selector(jobSeekerLongPress:)];
        self.jobSeekerLongPressRecognizer.minimumPressDuration = .5; //seconds
        self.jobSeekerLongPressRecognizer.delegate = self;
        self.jobSeekerLongPressRecognizer.delaysTouchesBegan = YES;
        self.profileImage.userInteractionEnabled = YES;
        [self.profileImage addGestureRecognizer:self.jobSeekerLongPressRecognizer];
    }
    
    self.jobSeekerLabelLongPressRecognizer
    = [[UILongPressGestureRecognizer alloc]
       initWithTarget:self action:@selector(jobSeekerLongPress:)];
    self.jobSeekerLabelLongPressRecognizer.minimumPressDuration = .5; //seconds
    self.jobSeekerLabelLongPressRecognizer.delegate = self;
    self.jobSeekerLabelLongPressRecognizer.delaysTouchesBegan = YES;
    self.jobSeekerPhoneLabel.userInteractionEnabled = YES;
    [self.jobSeekerPhoneLabel addGestureRecognizer:self.jobSeekerLabelLongPressRecognizer];
}

- (IBAction)browseJobOffersButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueFromJobSeekerToJobOffer sender:self];
}

- (IBAction)matchesButtonTap:(id)sender {
    [self performSegueWithIdentifier:SegueFromJobSeekerToMatches sender:self];
}
- (IBAction)jobSeekerLogoutButtonTap:(id)sender {
    [accountService logout];
    [self performSegueWithIdentifier:SegueFromJobSeekerHomeToLogin sender:self];
}

-(void)deleteProjectButtonTap:(UIButton*)sender
{
    for (int i = 0; i < jobSeekerViewModel.projects.count; i++) {
        if (sender.tag == i)
        {
            deleteProjectSender = i;
            ProjectViewModel* currentProject =[jobSeekerViewModel.projects objectAtIndex:i];
            NSInteger currentId = currentProject.projectId;
            [service deleteProjectWithId:currentId andTarget:self];
            connectionType = @"DeleteProject";
            NSLog(@"clicked");
            break;
        }
    }
}

-(void)addProjectButtonTap:(UIButton*)sender
{
    [self performSegueWithIdentifier:SegueFromJobSeekerToAddProject sender:self];
}

-(void)deleteSkillButtonTap:(UIButton*)sender
{
    for (int i = 0; i < jobSeekerViewModel.skills.count; i++) {
        if (sender.tag == i)
        {
            deleteSkillSender = i;
            SkillViewModel* currentSkill =[jobSeekerViewModel.skills objectAtIndex:i];
            NSInteger currentId = currentSkill.skillId;
            [service deleteSkillWithId:currentId andTarget:self];
            connectionType = @"DeleteSkill";
            NSLog(@"clicked");
            break;
        }
    }
}

-(void)addSkillButtonTap:(UIButton*)sender
{
    [self performSegueWithIdentifier:SegueFromJobSeekerToAddSkill sender:self];
}

-(void)addSummaryButtonTap:(UIButton*)sender
{
    [self performSegueWithIdentifier:SegueFromJobSeekerToAddSummary sender:self];
}

- (IBAction)jobSeekerEditProfileButtonTap:(id)sender {
       [self performSegueWithIdentifier:SegueFromJobSeekerToAddSummary sender:self];
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.profileImage;
}

- (IBAction)addSkillBlueButtonTap:(id)sender {
        [self performSegueWithIdentifier:SegueFromJobSeekerToAddSkill sender:self];
}

- (IBAction)addProjectBlueButtonTap:(id)sender {
        [self performSegueWithIdentifier:SegueFromJobSeekerToAddProject sender:self];
}
@end
