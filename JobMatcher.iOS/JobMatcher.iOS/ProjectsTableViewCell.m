//
//  ProjectsTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "ProjectsTableViewCell.h"

@implementation ProjectsTableViewCell

- (void)awakeFromNib {
    [self.projectDeleteButton setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"]
                                         forState:UIControlStateNormal];
    
    [self.projectAddButton setBackgroundImage:[UIImage imageNamed:@"add-icon.png"]
                                      forState:UIControlStateNormal];
    
    [self.projectEditButton setBackgroundImage:[UIImage imageNamed:@"edit-icon.png"]
                                       forState:UIControlStateNormal];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
