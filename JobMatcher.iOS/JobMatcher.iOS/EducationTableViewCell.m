//
//  EducationTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 1/31/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "EducationTableViewCell.h"

@implementation EducationTableViewCell

- (void)awakeFromNib {
    [self.educationDeleteButton setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"]
                                           forState:UIControlStateNormal];
    
    [self.educationAddButton setBackgroundImage:[UIImage imageNamed:@"add-icon.png"]
                                        forState:UIControlStateNormal];
    
    [self.educationEditButton setBackgroundImage:[UIImage imageNamed:@"edit-icon.png"]
                                         forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
