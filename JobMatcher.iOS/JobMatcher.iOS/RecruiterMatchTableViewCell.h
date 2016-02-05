//
//  RecruiterMatchTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 2/5/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterMatchTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recruiterMatchEmail;
@property (weak, nonatomic) IBOutlet UILabel *recruiterMatchSummary;
@property (weak, nonatomic) IBOutlet UIButton *recruiterMatchMessageButton;


@end
