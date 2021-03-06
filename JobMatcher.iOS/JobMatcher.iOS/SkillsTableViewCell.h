//
//  SkillsTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SkillsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *skillNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *skillLevelLabel;
@property (weak, nonatomic) IBOutlet UIButton *skillDeleteButton;
@property (weak, nonatomic) IBOutlet UIButton *skillAddButton;
@property (weak, nonatomic) IBOutlet UIButton *skillEditButton;

@end
