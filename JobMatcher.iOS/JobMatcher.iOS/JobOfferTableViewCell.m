//
//  JobOfferTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "JobOfferTableViewCell.h"

@implementation JobOfferTableViewCell

- (void)awakeFromNib {
    
    [self.jobOfferDeleteButton setBackgroundImage:[UIImage imageNamed:@"delete-icon.png"]
                                           forState:UIControlStateNormal];
    
    [self.jobOfferAddButton setBackgroundImage:[UIImage imageNamed:@"add-icon.png"]
                                         forState:UIControlStateNormal];
    
    [self.jobOfferEditButton setBackgroundImage:[UIImage imageNamed:@"edit-icon.png"]
                                         forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
