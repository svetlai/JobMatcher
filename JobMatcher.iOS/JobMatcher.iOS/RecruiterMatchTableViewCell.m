//
//  RecruiterMatchTableViewCell.m
//  JobMatcher.iOS
//
//  Created by s i on 2/5/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "RecruiterMatchTableViewCell.h"

@implementation RecruiterMatchTableViewCell

- (void)awakeFromNib {
    [self.recruiterMatchMessageButton setBackgroundImage:[UIImage imageNamed:@"message-icon.png"]
                                                forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
@end
