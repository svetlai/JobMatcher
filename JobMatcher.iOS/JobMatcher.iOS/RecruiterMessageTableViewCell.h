//
//  RecruiterMessageTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 2/4/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecruiterMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *recruiterMessageSubject;
@property (weak, nonatomic) IBOutlet UILabel *recruiterMessageContent;
@property (weak, nonatomic) IBOutlet UILabel *recruiterProfileLabel;

@end
