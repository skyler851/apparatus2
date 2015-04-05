//
//  CandidateListTableViewController.m
//  Recruitment
//
//  Created by Sean VanPelt on 4/1/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "CandidateListTableViewController.h"
#import "CandidateListTableViewCell.h"

@interface CandidateListTableViewController ()

@end

@implementation CandidateListTableViewController {
    NSArray *CandidateListArray; //Sets up my Array
    NSArray *CandidateDecisionArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Runs the "retrieveFromParse method
    [self performSelector:@selector(retrieveFromParse)];
    
}

- (void) retrieveFromParse {
    //Get info from the database
    PFQuery *retrieveCandidates =[PFQuery queryWithClassName:@"Candidates"];
    
    [retrieveCandidates whereKey:@"university" equalTo:UniversitySelected];
    
    [retrieveCandidates orderByDescending:@"decision"];
    
    CandidateDecisionArray = [retrieveCandidates findObjects];
    
    //Puts Table info into a array
    CandidateListArray = [retrieveCandidates findObjects];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete method implementation.
    // Return the number of rows in the section.
    return CandidateListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CandidateListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CandidateCell" forIndexPath:indexPath];
    
    //Sets up the Array to be displayed (needed if wanting a different row in different places)
    PFObject *TempObjectCandidates = [CandidateListArray objectAtIndex:indexPath.row];
    
    //PFObject *TempObject2 = [TempObject objectForKey:@"name"];
    
    //Displays the Skills in the labels
    cell.CandidateLabel.text = [TempObjectCandidates objectForKey:@"name"];
    
    PFObject *TempObjectDecision = [CandidateDecisionArray objectAtIndex:indexPath.row];
    
    cell.CandidateDecisionLabel.text = [TempObjectDecision objectForKey:@"decision"];
    
    if ([cell.CandidateDecisionLabel.text  isEqual: @"Yes"]) {
        cell.CandidateDecisionLabel.textColor = [UIColor colorWithRed:(0/255.0) green:(139/255.0) blue:(3/255.0) alpha:1.0];
    } else {
        cell.CandidateDecisionLabel.textColor = [UIColor colorWithRed:(212/255.0) green:(0/255.0) blue:(0/255.0) alpha:1.0];
    }
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
