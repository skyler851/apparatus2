//
//  EventsCollectionViewController.m
//  Recruitment
//
//  Created by Sean VanPelt on 4/6/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "EventsCollectionViewController.h"
#import "EventsCollectionViewCell.h"

@interface EventsCollectionViewController ()

@end

@implementation EventsCollectionViewController {
    NSArray *EventsArray; //Sets up my Array
}

NSArray *UniversitiesSelected;
NSArray *EventSelected;
NSArray *EventTimeSelected;
NSString *SchoolSelected;
NSString *Event;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Runs the "retrieveFromParse method
    [self performSelector:@selector(retrieveFromParse)];
}

- (void) retrieveFromParse {
    //Get info from the database
    PFQuery *retrieveEvents =[PFQuery queryWithClassName:@"EventsTable"];
    
    //Orders the Skills in ABC Order
    [retrieveEvents orderByAscending:@"university"];
    
    //Puts Table info into a array
    EventsArray = [retrieveEvents findObjects];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//warning Incomplete method implementation -- Return the number of items in the section
    return EventsArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EventsCell" forIndexPath:indexPath];
    
    //Sets up the Array to be displayed (needed if wanting a different row in different places)
    PFObject *TempObject = [EventsArray objectAtIndex:indexPath.row];
    
    //Date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    //Displays the Skills in the labels
    cell.EventsLabel.text = [TempObject objectForKey:@"eventName"];
    cell.UniversityEventLabel.text = [TempObject objectForKey:@"university"];
    cell.EventDateLabel.text = [formatter stringFromDate:[TempObject objectForKey:@"date"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PFObject *TempObject = [EventsArray objectAtIndex:indexPath.row];
    
    EventSelected = [TempObject objectForKey:@"eventName"];
    
    SchoolSelected = [TempObject objectForKey:@"university"];
    Event = [TempObject objectForKey:@"eventName"];
    
    //Getting the University of Event selected
    PFQuery *retrieveEventUniversity =[PFQuery queryWithClassName:@"EventsTable"];
    [retrieveEventUniversity whereKey:@"university" equalTo:EventSelected];
    UniversitiesSelected = [retrieveEventUniversity findObjects];
    
    
    
    //Date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd, yyyy"];
    
    //Getting the Date/Time of Event selected
    PFQuery *retrieveEventTime =[PFQuery queryWithClassName:@"EventsTable"];
    [retrieveEventTime whereKey:@"date" equalTo:EventSelected];
    EventTimeSelected = [retrieveEventTime findObjects];
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
