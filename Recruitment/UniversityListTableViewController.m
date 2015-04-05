//
//  UniversityListTableViewController.m
//  Recruitment
//
//  Created by Sean VanPelt on 4/4/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "UniversityListTableViewController.h"
#import "UniversityListTableViewCell.h"

@interface UniversityListTableViewController ()

@end

@implementation UniversityListTableViewController {
    NSArray *UniversityListArray; //Sets up my Array
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Runs the "retrieveFromParse method
    [self performSelector:@selector(retrieveFromParse)];
}

- (void) retrieveFromParse {
    //Get info from the database
    PFQuery *retrieveUniversity =[PFQuery queryWithClassName:@"EventsTable"];
    
    //Orders the Skills in ABC Order
    [retrieveUniversity orderByAscending:@"university"];
    
    //Puts Table info into a array
    UniversityListArray = [retrieveUniversity findObjects];
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
    return UniversityListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UniversityListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UniversityCell" forIndexPath:indexPath];
    
    //Sets up the Array to be displayed (needed if wanting a different row in different places)
    PFObject *TempObject = [UniversityListArray objectAtIndex:indexPath.row];
    
    //Displays the Skills in the labels
    cell.UniversityLabel.text = [TempObject objectForKey:@"university"];
    
    return cell;
}

//User selects a University
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *TempObjectUniversity = [UniversityListArray objectAtIndex:indexPath.row];
    
    UniversitySelected = [TempObjectUniversity objectForKey:@"university"];
    
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
