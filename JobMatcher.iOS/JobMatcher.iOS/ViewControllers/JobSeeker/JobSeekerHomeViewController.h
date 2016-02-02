//
//  JobSeekerHomeViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 1/26/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollapseClick.h"

@interface JobSeekerHomeViewController : UIViewController <CollapseClickDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *helloLabel;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
- (IBAction)jobSeekerSwipe:(UISwipeGestureRecognizer *)sender;
@property (weak, nonatomic) IBOutlet CollapseClick *collapseClickScrollView;
- (IBAction)browseJobOffersButtonTap:(id)sender;

//TODO make job seeker view model a property




//- (IBAction)buttonTapToProjects:(id)sender;

@end
