//
//  AddSummaryViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSummaryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *addSummaryTextView;
- (IBAction)addSummaryButtonTap:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *addSummaryFirstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addSummaryLastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *addSummaryPhoneNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *addSummaryCurrentPositionTextField;

@end
