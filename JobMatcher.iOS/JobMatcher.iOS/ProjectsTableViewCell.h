//
//  ProjectsTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 1/30/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *projectTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *projectUrlLabel;

@end
