//
//  AddSummaryViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/8/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddSummaryViewController.h"
#import "UserDataModel.h"
#import "Validator.h"
#import "HelperMethods.h"
#import "JobSeekerService.h"
#import "EditJobSeekerProfileViewModel.h"
#import "HelperMethods.h"

@interface AddSummaryViewController (){
    UserDataModel* userData;
    Validator* validator;
    JobSeekerService* jobSeekerService;
    NSString* message;
    NSString* connectionType;
    EditJobSeekerProfileViewModel* editJobSeekerProfileModel;
}

@end

@implementation AddSummaryViewController
   NSString* const SegueFromAddSummaryToJobSeeker = @"segueFromAddSummaryToJobSeeker";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:@"Summary"];
    [HelperMethods setSackBarButtonText:self andText:@""];
    
    userData = [[UserDataModel alloc] init];
    validator = [[Validator alloc] init];
    jobSeekerService = [[JobSeekerService alloc] init];
    [jobSeekerService getEditProfileWithId:userData.profileId andTarget:self];
    
       // self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"pattern-w.jpg"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addSummaryButtonTap:(id)sender {
    NSString* summary = self.addSummaryTextView.text;
    NSString* phoneNumber = self.addSummaryPhoneNumberTextField.text;
    NSString* firstName = self.addSummaryFirstNameTextField.text;
    NSString* lastName =  self.addSummaryLastNameTextField.text;
    NSString* currentPosition =  self.addSummaryCurrentPositionTextField.text;

    EditJobSeekerProfileViewModel* editProfileModel = [EditJobSeekerProfileViewModel profileWithFirstName:firstName andLastName:lastName andPhoneNumber:phoneNumber andCurrentPosition:currentPosition andSummary:summary andProfileId:userData.profileId];
    
    connectionType = @"EditProfile";
    [jobSeekerService editProfileWithModel:editProfileModel andTarget:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    if (error){
        message = @"Uh oh, something went wrong! Try again!";
        [HelperMethods addAlert:message];
    }
}

-(void)connection:(NSURLRequest*) request didReceiveData:(NSData *)data{
    NSError *error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:kNilOptions
                                                           error:&error];
    NSLog(@"%@", json);
    if(error){
        NSLog(@"%@",error.description);
    }

    if (![connectionType isEqualToString:@"EditProfile"]){
        editJobSeekerProfileModel = [EditJobSeekerProfileViewModel fromJsonDictionary:json];
        
        if (
            ![editJobSeekerProfileModel.summary isEqual:[NSNull null]]) {
            self.addSummaryTextView.text = editJobSeekerProfileModel.summary;
        }
        if (![editJobSeekerProfileModel.phoneNumber isEqual:[NSNull null]]) {
            self.addSummaryPhoneNumberTextField.text = editJobSeekerProfileModel.phoneNumber;
        }
        if (![editJobSeekerProfileModel.firstName isEqual:[NSNull null]]) {
            self.addSummaryFirstNameTextField.text = editJobSeekerProfileModel.firstName;
        }
        if (![editJobSeekerProfileModel.lastName isEqual:[NSNull null]]) {
            self.addSummaryLastNameTextField.text = editJobSeekerProfileModel.lastName;
        }
        if (![editJobSeekerProfileModel.currentPosition isEqual:[NSNull null]]) {
            self.addSummaryCurrentPositionTextField.text = editJobSeekerProfileModel.currentPosition;
        }
    }
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    
    if ([connectionType isEqualToString:@"EditProfile"]){
        if (code == 200){
            message = @"Profile updated successfully!";
            [HelperMethods addAlert:message];
            connectionType = @"";
            [self performSegueWithIdentifier:SegueFromAddSummaryToJobSeeker sender:self];
        }else{
            message = @"Nope. Try again!";
            [HelperMethods addAlert:message];
        }
    }
}

@end
