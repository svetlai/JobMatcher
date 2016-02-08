//
//  AddJobOfferViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddJobOfferViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addJobOfferTitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *addJobOfferSalaryLabel;
@property (weak, nonatomic) IBOutlet UIPickerView *addJobOfferIndustryPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *addJobOfferWorkHoursPickerView;
@property (weak, nonatomic) IBOutlet UITextView *addJobOfferDescriptionTextView;
- (IBAction)addJobOfferButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *addJobOfferLatitude;
@property (weak, nonatomic) IBOutlet UILabel *addJobOfferLongitude;

@end
