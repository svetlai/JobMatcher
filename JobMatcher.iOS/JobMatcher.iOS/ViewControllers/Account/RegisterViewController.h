//
//  RegisterViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 1/24/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *accountTypePicker;
@property (weak, nonatomic) IBOutlet UITextField *accountEmail;
@property (weak, nonatomic) IBOutlet UITextField *accountPassword;
@property (weak, nonatomic) IBOutlet UITextField *accountConfirmPassword;
- (IBAction)registerButtonTap:(id)sender;
- (IBAction)loginButtonTap:(id)sender;


@end
