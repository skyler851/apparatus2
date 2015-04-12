//
//  EditSummaryViewController.m
//  Recruitment
//
//  Created by Stephanie Kyler on 4/8/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "EditSummaryViewController.h"
#import "Recruitment-Swift.h"

@interface EditSummaryViewController ()
@end

@implementation EditSummaryViewController

@synthesize lblCandidateName;
@synthesize candidateName;

@synthesize lblRecruiterName;
@synthesize recruiterName;

@synthesize lblCandidateInfo;
@synthesize candidateInfo;

@synthesize txtEmail;
@synthesize email;

@synthesize txtGradDate;
@synthesize gradDate;

@synthesize txtJobType;
@synthesize jobType;

@synthesize txtArea;
@synthesize area;

@synthesize txtSkills;
@synthesize skills;

@synthesize txtCultureFit;
@synthesize cultureFit;

@synthesize txtAptitude;
@synthesize aptitude;

@synthesize txtTechSkill;
@synthesize techSkill;

@synthesize txtFavorite;
@synthesize favorite;

@synthesize txtNotes;
@synthesize notes;

@synthesize txtDecision;
@synthesize decision;

@synthesize btnSave;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtNotes.layer.borderWidth = 0.5;
    self.txtNotes.layer.borderColor = [UIColor colorWithRed:(200/255.0) green:(200/255.0) blue:(200/255.0) alpha:1.0].CGColor;
    self.txtNotes.layer.cornerRadius = 8;
    
    recruiterName = [NameConstant recName];
    lblRecruiterName.title = recruiterName;
    
    candidateName = [NSString stringWithFormat:@"%@",candidateName];
    lblCandidateName.text = candidateName;
    
    
    lblCandidateInfo.text = [NSString stringWithFormat:@"%@ %@ %@",jobType, @" | ", gradDate];
    
    txtEmail.text = [NSString stringWithFormat:@"%@",email];
    txtGradDate.text = [NSString stringWithFormat:@"%@", gradDate];
    txtJobType.text = [NSString stringWithFormat:@"%@",jobType];
    txtArea.text = [NSString stringWithFormat:@"%@",area];
    txtSkills.text = [NSString stringWithFormat:@"%@",skills];
    txtCultureFit.text = [NSString stringWithFormat:@"%@",cultureFit];
    txtAptitude.text = [NSString stringWithFormat:@"%@",aptitude];
    txtTechSkill.text = [NSString stringWithFormat:@"%@",techSkill];
    txtFavorite.text = [NSString stringWithFormat:@"%@",favorite];
    txtNotes.text = [NSString stringWithFormat:@"%@",notes];
    txtDecision.text = [NSString stringWithFormat:@"%@",decision];
    if ([txtDecision.text  isEqual: @"Yes"]) {
        txtDecision.textColor = [UIColor colorWithRed:(0/255.0) green:(139/255.0) blue:(3/255.0) alpha:1.0];
    } else {
        txtDecision.textColor = [UIColor colorWithRed:(212/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
    }
    
    
    
    
}

- (IBAction)btnSave:(id)sender {
    PFQuery *query = [PFQuery queryWithClassName:@"Candidates"];
    
    // Retrieve the object by id
    [query whereKey:@"email" equalTo: email];
 
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if(!error){
            for (PFObject *object in objects){
           
            //redefine variables to match changes
                email  = txtEmail.text;
                jobType = txtJobType.text;
                gradDate = txtGradDate.text;
                skills = txtSkills.text;
                cultureFit = txtCultureFit.text;
                aptitude = txtAptitude.text;
                techSkill = txtTechSkill.text;
                favorite = txtFavorite.text;
                decision = txtDecision.text;
                area = txtArea.text;
                notes = txtNotes.text;
                
                NSLog(@"New Date: %@", gradDate);

                
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"MMMM yyyy"];
                NSDate *date = [dateFormat dateFromString:gradDate];
                

                
            //update Parse object
                [object setObject: email forKey:@"email"];
                [object setObject: jobType forKey:@"jobType"];
                [object setObject: date forKey:@"gradDate"];
                [object setObject: skills forKey:@"skills"];
                [object setObject: @([cultureFit intValue]) forKey:@"culture"];
                [object setObject: @([aptitude intValue]) forKey:@"aptitude"];
                [object setObject: @([techSkill intValue]) forKey:@"tech"];
                [object setObject: area forKey:@"area"];
                [object setObject: favorite forKey:@"favorite"];
                [object setObject: decision forKey:@"decision"];
                [object setObject: notes forKey:@"notes"];
                
            // save
            [object saveInBackground];
       
            }
        } else {
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }

    }];
    
  

    [self.navigationController popToRootViewControllerAnimated:YES];
    

    
    }
     
     - (void)didReceiveMemoryWarning {
         [super didReceiveMemoryWarning];
         // Dispose of any resources that can be recreated.
     }
     
     
     
     @end
