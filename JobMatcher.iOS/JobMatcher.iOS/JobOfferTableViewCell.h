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
@property (weak, nonatomic) IBOutlet UIButton *jobOfferDeleteButton;
@property (weak, nonatomic) IBOutlet UIButton *jobOfferEditButton;
@property (weak, nonatomic) IBOutlet UIButton *jobOfferAddButton;

@end
