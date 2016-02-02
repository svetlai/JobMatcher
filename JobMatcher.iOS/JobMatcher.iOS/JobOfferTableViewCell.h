//
//  JobOfferTableViewCell.h
//  JobMatcher.iOS
//
//  Created by s i on 2/1/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobOfferTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *jobOfferTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferLocationLabel;
@property (weak, nonatomic) IBOutlet UILabel *jobOfferSalaryLabel;

@end
