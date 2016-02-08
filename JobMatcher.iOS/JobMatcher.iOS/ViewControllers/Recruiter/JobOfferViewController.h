//
//  JobOfferViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JobOfferViewModel.h"

@interface JobOfferViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *jobOfferIndustryLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferWorkHoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferSalaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferSwipeHintLabel;
@property (strong, nonatomic) JobOfferViewModel* jobOfferViewModel;
@property BOOL matched;

- (IBAction)jobOfferSwipe:(UISwipeGestureRecognizer *)sender;
@end
