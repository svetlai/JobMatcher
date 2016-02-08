//
//  JobSeekerMessageTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 2/4/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobSeekerMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerMessageSubject;
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerMessageContent;
@property (weak, nonatomic) IBOutlet UILabel *jobSeekerProfileLabel;

@end
