//
//  JobSeekerMatchTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 2/3/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobSeekerMatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerMatchTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerMatchLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerMatchSalaryLabel;
@property (weak, nonatomic) IBOutlet UIButton *jobSeekerMatchMessageButton;


@end
