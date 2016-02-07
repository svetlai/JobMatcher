//
//  JobSeekerHomeViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"
#import "JobSeekerProfileViewModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface JobSeekerHomeViewController : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) JobSeekerProfileViewModel* jobSeekerProfileViewModel;
- (IBAction)jobSeekerSwipe:(UISwipeGestureRecognizer *)sender;

@property (weak, nonatomic) IBOutlet CollapseClick *collapseClickScrollView;
- (IBAction)browseJobOffersButtonTap:(id)sender;
- (IBAction)matchesButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *jobSeekerMatchesButton;
@property (weak, nonatomic) IBOutlet UIButton *jobSeekerBrowseOffersButton;
@property (weak, nonatomic) IBOutlet UIButton *jobSeekerLogoutButton;
- (IBAction)jobSeekerLogoutButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerPhoneLabel;

@property (nonatomic,strong) UILongPressGestureRecognizer *jobSeekerLongPressRecognizer;
@property (nonatomic,strong) UILongPressGestureRecognizer *jobSeekerLabelLongPressRecognizer;
//TODO make job seeker view model a property

@end
