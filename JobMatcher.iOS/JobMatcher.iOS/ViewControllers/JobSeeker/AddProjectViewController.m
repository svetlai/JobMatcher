//
//  AddProjectViewController.m
//  JobMatcher.iOS
//
//  Created by s i on 2/7/16.
//  Copyright © 2016 svetlai. All rights reserved.
//

#import "AddProjectViewController.h"
#import "UserDataModel.h"
#import "Validator.h"
#import "HelperMethods.h"
#import "AddProjectViewModel.h"
#import "JobSeekerService.h"

@interface AddProjectViewController (){
    UserDataModel* userData;
    Validator* validator;
    JobSeekerService* jobSeekerService;
    NSString* message;
}

@end

@implementation AddProjectViewController
   NSString* const SegueFromAddProjectToJobSeeker = @"segueFromAddProjectToJobSeeker";

- (void)viewDidLoad {
    [super viewDidLoad];
    [HelperMethods setPageTitle:self andTitle:@"Add Project"];
    [HelperMethods setSackBarButtonText:self andText:@""];
    
    userData = [[UserDataModel alloc] init];
    validator = [[Validator alloc] init];
    jobSeekerService = [[JobSeekerService alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addProjectButtonTap:(id)sender {
    NSString* title = self.addProjectTitleTextView.text;
    NSString* description = self.addProjectDescriptionTextView.text;
    NSString* url = self.addProjectUrlTextField.text;

    if (![validator isValidLength:3 andParam:title]){
        [HelperMethods addAlert:@"Title must be at least 3 symbols."];
        return;
    }
    
    if (![validator isValidLength:3 andParam:description]){
        [HelperMethods addAlert:@"Description must be at least 3 symbols."];
        return;
    }
    
    if (![validator isValidLength:10 andParam:url]){
        [HelperMethods addAlert:@"Description must be at least 3 symbols."];
        return;
    }
    
    
    AddProjectViewModel* addProjectViewModel = [AddProjectViewModel projectWithTitle:title andDescription:description andUrl:url];
    
    [jobSeekerService addProjectWithModel:addProjectViewModel andTarget:self];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    long code = [httpResponse statusCode];
    if (code == 200){
        message = @"Project added successfully!";
        [HelperMethods addAlert:message];
        [self performSegueWithIdentifier:SegueFromAddProjectToJobSeeker sender:self];
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
