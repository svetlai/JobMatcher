//
//  ExperienceTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ExperienceTableViewCell.h"

@implementation ExperienceTableViewCell

- (void)awakeFromNib {
    [self.experienceDeleteButton setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"]
                                      forState:UIControlStateNormal];
    
    [self.experienceAddButton setBackgroundImage:[UIImage imageNamed:@"add-icon.png"]
                                   forState:UIControlStateNormal];
    
    [self.experienceEditButton setBackgroundImage:[UIImage imageNamed:@"edit-icon.png"]
                                    forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
