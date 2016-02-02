//
//  SkillsTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "SkillsTableViewCell.h"

@implementation SkillsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [self.skillLevelLabel setBackgroundColor: [UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:1] /*#cccccc*/];
    self.skillLevelLabel.layer.masksToBounds = YES;
    self.skillLevelLabel.layer.cornerRadius = 25.0;
    }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
