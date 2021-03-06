//
//  RecruiterHomeViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface RecruiterHomeViewController : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UIScrollViewDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *recruiterHelloLabel;
- (IBAction)browseJobSeekersButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *recruiterProfileImage;
@property (weak, nonatomic) IBOutlet UIButton *recruiterAddOfferButton;
- (IBAction)recruiterAddOfferButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet CollapseClick *recruiterCollapseClickScrollView;
- (IBAction)toMatchesButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recruiterLogoutButton;
- (IBAction)recruiterLogoutButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *recruiterEditProfileButton;
@property (weak, nonatomic) IBOutlet UIButton *recruiterBrowseJobSeekersButton;
@property (weak, nonatomic) IBOutlet UIButton *recruiterMatchesButton;
@property (nonatomic,strong) UILongPressGestureRecognizer *recruiterLongPressRecognizer;
@end
