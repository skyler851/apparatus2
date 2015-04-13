//
//  SummaryDetailViewController.m
//  Recruitment
//
//  Created by Nisha Nagarajan on 4/5/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "SummaryDetailViewController.h"
#import "Recruitment-Swift.h"
#import "EditSummaryViewController.h"

@interface SummaryDetailViewController ()

@end

@implementation SummaryDetailViewController

@synthesize lblCandidateName;
@synthesize candidateName;

@synthesize lblRecruiterName;
@synthesize recruiterName;

@synthesize lblNameSubHeader;
@synthesize nameSubHeader;

@synthesize lblEmail;
@synthesize email;

@synthesize lblGradDate;
@synthesize gradDate;

@synthesize lblJobType;
@synthesize jobType;

@synthesize lblNotes;
@synthesize notes;

@synthesize lblArea;
@synthesize areaOfInterest;

@synthesize lblSkills;
@synthesize skills;

@synthesize lblCulture;
@synthesize cultureFit;

@synthesize lblAptitude;
@synthesize aptitude;

@synthesize lblTechSkill;
@synthesize techSkills;

@synthesize lblFavorite;
@synthesize favorite;

@synthesize lblDecision;
@synthesize decision;

@synthesize lblEvent;
@synthesize event;

@synthesize lblUniversity;
@synthesize university;

@synthesize candRecruiter;
@synthesize cRecruiter;


@synthesize tempVar;


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"editSummary"]) {
        EditSummaryViewController *destViewController = segue.destinationViewController;
        
        //pushes all data from summary detail page to variables on edit summary page
        
        destViewController.candidateName = candidateName;
        destViewController.email = email;
        destViewController.jobType = jobType;
        NSLog(@"Error: %@", jobType);

        //convert from date to string to display
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MMMM YYYY"];
        NSString *outDate = [formatter stringFromDate:gradDate];
        destViewController.gradDate = outDate;
        
        destViewController.jobType = jobType;
        destViewController.area = areaOfInterest;
        destViewController.skills = skills;
        destViewController.cultureFit = cultureFit;
        destViewController.aptitude = aptitude;
        destViewController.techSkill = techSkills;
        destViewController.favorite = favorite;
        destViewController.decision = decision;
        destViewController.notes = notes;
        destViewController.university = university;
        destViewController.event = event;
        destViewController.candRecruiter = cRecruiter;
        

     
        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    candidateName = [NSString stringWithFormat:@"%@",candidateName];
    lblCandidateName.text = candidateName;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM YYYY"];
    
    NSString *outDate = [formatter stringFromDate:gradDate];
    
    lblNameSubHeader.text = [NSString stringWithFormat:@"%@ %@ %@",jobType, @" | ", outDate];

    lblEmail.text = [NSString stringWithFormat:@"%@",email];
    lblGradDate.text = [NSString stringWithFormat:@"%@", outDate];
    lblJobType.text = [NSString stringWithFormat:@"%@",jobType];
    lblArea.text = [NSString stringWithFormat:@"%@",areaOfInterest];
    lblSkills.text = [NSString stringWithFormat:@"%@",skills];
    lblCulture.text = [NSString stringWithFormat:@"%@",cultureFit];
    lblAptitude.text = [NSString stringWithFormat:@"%@",aptitude];
    lblTechSkill.text = [NSString stringWithFormat:@"%@",techSkills];
    lblFavorite.text = [NSString stringWithFormat:@"%@",favorite];
    lblDecision.text = [NSString stringWithFormat:@"%@",decision];
    
    lblUniversity.text = [NSString stringWithFormat:@"%@",university];
    lblEvent.text = [NSString stringWithFormat:@"%@",event];
    candRecruiter.text = [NSString stringWithFormat:@"%@",cRecruiter];
    
    if ([lblDecision.text  isEqual: @"Yes"]) {
        lblDecision.textColor = [UIColor colorWithRed:(0/255.0) green:(139/255.0) blue:(3/255.0) alpha:1.0];
    } else {
        lblDecision.textColor = [UIColor colorWithRed:(212/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
    }
    recruiterName = [NameConstant recName];
    lblRecruiterName.title = recruiterName;
    
    
    
    
    

    lblNotes.text = [NSString stringWithFormat:@"%@",notes];
}
- (IBAction)btnSave:(UIBarButtonItem *)sender {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Candidates"];
    [query whereKey:@"email" equalTo: email];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
           
            for (PFObject *object in objects) {
                object[@"email"] = email;
                object[@"gradDate"] = gradDate;
                object[@"jobType"] = jobType;
                object[@"area"] = areaOfInterest;
                object[@"skills"] = skills;
                object[@"culture"] = cultureFit;
                object[@"aptitude"] = aptitude;
                object[@"tech"] = techSkills;
                object[@"favorite"] = favorite;
                object[@"decision"] = decision;
                object[@"notes"] = notes;
                
                [object saveInBackground];
                [self.navigationController popViewControllerAnimated:TRUE];

            }
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
