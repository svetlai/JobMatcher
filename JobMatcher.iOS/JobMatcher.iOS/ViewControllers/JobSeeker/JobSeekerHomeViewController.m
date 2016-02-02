//
//  JobSeekerHomeViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

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

@interface JobSeekerHomeViewController (){
    NSString* message;
    JobSeekerProfileViewModel* jobSeekerViewModel;
    UITableView* projectsTableView;
    UITableView* skillsTableView;
    UITableView* experienceTableView;
    UITableView* educationTableView;
    NSString* connectionType;
    UserDataModel* userData;
}

@end

@implementation JobSeekerHomeViewController
int const NumberOfSections = 5;

int const ProjectsTableRowHeight = 140;
int const SkillsTableRowHeight = 50;

// TODO: fix dynamic height + inner scroll
int ExperienceTableRowHeight = 150;
int EducationTableRowHeight = 150;

//NSString* const CellProjectsIdentifier = @"projectsCell";
//NSString* const SegueFromProfileToProjects = @"segueFromProfileToProjects";
NSString* const SegueFromJobSeekerToRecruiter = @"segueFromJobSeekerToRecruiter";
NSString* const SegueFromJobSeekerToJobOffer = @"segueFromJobSeekerToJobOffer";
static NSString* projectsTableCellIdentifier = @"ProjectsTableViewCell";
static NSString* skillsTableCellIdentifier = @"SkillsTableViewCell";
static NSString* experienceTableCellIdentifier = @"ExperienceTableViewCell";
static NSString* educationTableCellIdentifier = @"EducationTableViewCell";
static JobSeekerService* service;
static MatchService* matchService;
//SummaryViewController* myViewObject;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    service = [[JobSeekerService alloc] init];
    matchService = [[MatchService alloc] init];
    
    userData = [[UserDataModel alloc] init];

    self.profileImage.image = [UIImage imageNamed:@"default_profile_img.jpg"];
////    self.tableViewProjects.layer.borderWidth = 1;
////    self.tableViewProjects.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    projectsTableView = [[UITableView alloc] initWithFrame:CGRectMake(101, 45, 100, 416)];
//    [projectsTableView setDataSource:self];
//    [projectsTableView setDelegate:self];
//
//    UINib *nib = [UINib nibWithNibName:cellIdentifier bundle:nil];
//    [projectsTableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
//    projectsTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//
//    [self.view addSubview:projectsTableView];
    
//    myViewObject = [[[NSBundle mainBundle] loadNibNamed:@"SummaryViewController" owner:self options:nil] objectAtIndex:0];
    
 
    [HelperMethods setSackBarButtonText:self andText:@""];
    
    connectionType = @"GetProfile";
    
    if (userData.profileType == JobSeeker){
        [service getProfileWithTarget:self];
        [HelperMethods setPageTitle:self andTitle:@"Profile"];
           } else if (userData.profileType == Recruiter){
        [service getRandomProfileWithTarget:self];
        [HelperMethods setPageTitle:self andTitle:jobSeekerViewModel.username];
    }
    
    self.collapseClickScrollView.CollapseClickDelegate = self;
    [self.collapseClickScrollView reloadCollapseClick];
    
    // swipe
    UISwipeGestureRecognizer *rightSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                   action:@selector(jobSeekerSwipe:)];
    UISwipeGestureRecognizer *leftSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                                  action:@selector(jobSeekerSwipe:)];
        leftSwipeRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:rightSwipeRecognizer];
    [self.view addGestureRecognizer:leftSwipeRecognizer];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// collapse click

-(int)numberOfCellsForCollapseClick {
    return NumberOfSections;
}

-(NSString *)titleForCollapseClickAtIndex:(int)index {
    NSArray* sesctionTitles = [[NSArray alloc] initWithObjects:@"Summary", @"Skills", @"Projects", @"Experience", @"Education", nil];
    return [sesctionTitles objectAtIndex:index];
}

-(UIView *)getSummaryView{
    UILabel *summaryLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 300, 20)];

    [summaryLabel setTextColor: [UIColor colorWithRed:0.263 green:0.522 blue:0.588 alpha:1]] /*#438596*/;//[UIColor colorWithRed:0.482 green:0.722 blue:0.765 alpha:1]] /*#7bb8c3*/;//[UIColor colorWithRed:0.106 green:0.255 blue:0.282 alpha:1]]; /*#1b4148*/
    [summaryLabel setBackgroundColor:[UIColor clearColor]];
    [summaryLabel setFont:[UIFont fontWithName: @"Trebuchet MS" size: 14.0f]];
    [summaryLabel setText: jobSeekerViewModel.summary]; //@"some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text "]; //jobSeekerViewModel.summary
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
    return [UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1] /*#e6e6e6*/;
}

-(UIColor *)colorForTitleLabelAtIndex:(int)index {
    return [UIColor colorWithRed:0.208 green:0.459 blue:0.502 alpha:1] /*#357580*/;
}

-(UIColor *)colorForTitleArrowAtIndex:(int)index {
    return [UIColor colorWithRed:0.773 green:0.855 blue:0.867 alpha:1] /*#c5dadd*/;
}

//-(void)openCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated;
//
//-(void)closeCollapseClickCellsWithIndexes:(NSArray *)indexArray animated:(BOOL)animated;

//---------------

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
    
    if ([connectionType isEqualToString:@"GetProfile"]){
        jobSeekerViewModel = [JobSeekerProfileViewModel fromJsonDictionary:json];
        
        self.helloLabel.text = [NSString stringWithFormat:@"%@", jobSeekerViewModel.username];
        
        [self reloadData];

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

// table view
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
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projectsTableCellIdentifier];
    
    if (tableView == projectsTableView){
        ProjectsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:projectsTableCellIdentifier];

         if (jobSeekerViewModel.projects.count > 0) {
             ProjectViewModel *projectViewModel = jobSeekerViewModel.projects[indexPath.row];
             cell.projectTitleLabel.text = projectViewModel.title;
             cell.projectDescriptionLabel.text = projectViewModel.projectDescription;
             cell.projectUrlLabel.text = projectViewModel.url;
        
             return cell;
         }
    } else if (tableView == skillsTableView){
        
        SkillsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:skillsTableCellIdentifier];
        
        if (jobSeekerViewModel.skills.count > 0) {
            SkillViewModel *skillViewModel = jobSeekerViewModel.skills[indexPath.row];
            cell.skillNameLabel.text = skillViewModel.name;
            cell.skillLevelLabel.text = [NSString stringWithFormat:@"%ld", skillViewModel.level];
        }
        
        return cell;
    } else if (tableView == experienceTableView){
        
        ExperienceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:experienceTableCellIdentifier];
        if (jobSeekerViewModel.experience.count > 0) {
            ExperienceViewModel *experienceViewModel = jobSeekerViewModel.experience[indexPath.row];
            cell.experiencePositionLabel.text = experienceViewModel.position;
            cell.experienceOrganizationLabel.text = experienceViewModel.organization;
        
            cell.experienceDescriptionLabel.text = experienceViewModel.experienceDescription; //@"some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text some long text ";//
        
            float expectedHeight = [cell.experienceDescriptionLabel expectedHeight];
            ExperienceTableRowHeight += expectedHeight;
            [self setDynamicLabel:cell.experienceDescriptionLabel andHeight:expectedHeight andWidth:tableView.frame.size.width andView:cell];
            //        cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, cell.frame.size.width, 200);
            //         [tableView addSubview:cell];
            //        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 200);
            //        [self.view addSubview:tableView];
        
            // TODO: get enumeration!
            cell.experienceIndustryLevel.text = [Industries objectAtIndex: experienceViewModel.industry];
            cell.experienceStartDateLabel.text = [HelperMethods getShortDateString:experienceViewModel.startDate];
        
            if (experienceViewModel.endDate == nil){
                cell.experienceEndDateLabel.text = @"Present";
            } else {
                cell.experienceEndDateLabel.text = [HelperMethods getShortDateString:experienceViewModel.endDate];
            }
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
        }
        
        return cell;
    }
////
////    cell.tag = indexPath.row;
////
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    
//    // Draw top border only on first cell
//    if (indexPath.row == 0) {
//        UIView *topLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
//        topLineView.backgroundColor = [UIColor grayColor];
//        [cell.contentView addSubview:topLineView];
//    }
//    
//    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height, self.view.bounds.size.width, 1)];
//    bottomLineView.backgroundColor = [UIColor grayColor];
//    [cell.contentView addSubview:bottomLineView];
//    
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


-(void) setDynamicLabel:(UILabel*) label andHeight: (float) expetedHeight andWidth: (int) width andView: (UIView*) view{
    [label setNumberOfLines:0];
    [label sizeToFit];
    label.frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, width, expetedHeight);
    [view addSubview:label];
}


//- (IBAction)buttonTapToProjects:(id)sender {
//    [self performSegueWithIdentifier:SegueFromProfileToProjects sender:self];
//}

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
- (IBAction)browseJobOffersButtonTap:(id)sender {
      [self performSegueWithIdentifier:SegueFromJobSeekerToJobOffer sender:self];
}
@end
