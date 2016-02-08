//
//  AddSkillViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddSkillViewController.h"
#import "UserDataModel.h"
#import "Validator.h"
#import "HelperMethods.h"
#import "GlobalConstants.h"
#import "AddSkillViewModel.h"
#import "JobSeekerService.h"

@interface AddSkillViewController (){
    long selectedLevel;
    UserDataModel* userData;
    Validator* validator;
    JobSeekerService* jobSeekerService;
    NSString* message;
}

@end

@implementation AddSkillViewController
   NSString* const SegueFromAddSkillToJobSeeker = @"segueFromAddSkillToJobSeeker";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:@"Skill"];
    [HelperMethods setSackBarButtonText:self andText:@""];
    
    userData = [[UserDataModel alloc] init];
    validator = [[Validator alloc] init];
     jobSeekerService = [[JobSeekerService alloc] init];
    
       //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return Level.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [Level objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    selectedLevel = row;
}


- (IBAction)addSkillButtonTap:(id)sender {
    NSString* name = self.addSkillNameTextField.text;

    if (![validator isValidLength:3 andParam:name]){
        [HelperMethods addAlert:@"Name must be at least 3 symbols."];
        return;
    }

    
    AddSkillViewModel* skillViewModel = [AddSkillViewModel skillWithName:name andLevel:selectedLevel];
    
    [jobSeekerService addSkillWithModel:skillViewModel andTarget:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    if (code == 200){
        message = @"Skill added successfully!";
        [HelperMethods addAlert:message];
        [self performSegueWithIdentifier:SegueFromAddSkillToJobSeeker sender:self];
    }else{
        message = @"Nope. Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

@end
