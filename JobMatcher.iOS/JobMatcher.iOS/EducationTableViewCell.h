//
//  EducationTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EducationTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *educationOrganizationLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationSpecialtyLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationDegreeLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationIndustryLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationStartDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationEndDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *educationDescriptionLabel;

@end
