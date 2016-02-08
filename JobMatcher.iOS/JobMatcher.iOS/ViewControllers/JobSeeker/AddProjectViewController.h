//
//  AddProjectViewController.h
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddProjectViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *addProjectTitleTextView;
@property (weak, nonatomic) IBOutlet UITextView *addProjectDescriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *addProjectUrlTextField;
- (IBAction)addProjectButtonTap:(id)sender;


@end
