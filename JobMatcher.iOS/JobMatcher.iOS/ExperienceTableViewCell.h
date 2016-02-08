//
//  ExperienceTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExperienceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *experiencePositionLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceIndustryLevel;
@property (weak, nonatomic) IBOutlet UILabel *experienceStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *experienceDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *experienceEditButton;
@property (weak, nonatomic) IBOutlet UIButton *experienceAddButton;
@property (weak, nonatomic) IBOutlet UIButton *experienceDeleteButton;

@end
