//
//  AddSkillViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSkillViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *addSkillNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *addSkillLevelPickerView;
- (IBAction)addSkillButtonTap:(id)sender;

@end
