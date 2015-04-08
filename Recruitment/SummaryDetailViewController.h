//
//  SummaryDetailViewController.h
//  Recruitment
//
//  Created by Nisha Nagarajan on 4/5/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface SummaryDetailViewController : UIViewController

@property (nonatomic, strong) NSString *recruiterName;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *lblRecruiterName;

@property (weak, nonatomic) IBOutlet UILabel *lblCandidateName;
@property (nonatomic, strong) id candidateName;

@property (weak, nonatomic) IBOutlet UILabel *lblNameSubHeader;
@property (nonatomic, strong) NSString *nameSubHeader;

@property (weak, nonatomic) IBOutlet UITextField *lblEmail;

@property (nonatomic, strong) NSString *email;

@property (weak, nonatomic) IBOutlet UITextField *lblGradDate;
@property (nonatomic, strong) NSString *gradDate;

@property (weak, nonatomic) IBOutlet UITextField *lblJobType;
@property (nonatomic, strong) NSString *jobType;

@property (weak, nonatomic) IBOutlet UITextField *lblArea;
@property (nonatomic, strong) NSString *areaOfInterest;

@property (weak, nonatomic) IBOutlet UITextField *lblSkills;
@property (nonatomic, strong) NSString *skills;

@property (weak, nonatomic) IBOutlet UITextField *lblNotes;

@property (nonatomic, strong) NSString *notes;

@property (weak, nonatomic) IBOutlet UITextField *lblCulture;
@property (nonatomic, strong) NSString *cultureFit;


@property (weak, nonatomic) IBOutlet UITextField *lblAptitude;

@property (nonatomic, strong) NSString *aptitude;

@property (weak, nonatomic) IBOutlet UITextField *lblTechSkill;

@property (nonatomic, strong) NSString *techSkills;

@property (weak, nonatomic) IBOutlet UITextField *lblFavorite;
@property (nonatomic, strong) NSString *favorite;

@property (weak, nonatomic) IBOutlet UITextField *lblDecision;

@property (nonatomic, strong) NSString *decision;

@property (nonatomic, strong) NSString *tempVar;

@end
