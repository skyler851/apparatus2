//
//  EventsCollectionViewCotroller.m
//  Recruitment
//
//  Created by Stephanie Kyler on 4/3/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import "EventsCollectionViewController.h"
#import "EventsCollectionViewCell.h"

@interface EventsCollectionViewController ()

@end

@implementation EventsCollectionViewController {
    NSArray *EventsArray; //Sets up my Array
}

static NSString * const reuseIdentifier = @"Cell";



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Runs the "retrieveFromParse method
    [self performSelector:@selector(retrieveFromParse)];
    
    //Allows for selecting more than one Skill
    self.collectionView.allowsMultipleSelection = YES;
    
    //////////////////////////////////////////////////////////////////////////////////////////
    //ADDED THIS BECAUSE THE APP WOULD CRASH AND SAY THE COLLECTION VIEW WASN'T REGISTERED////
    //IT NOW WORKS WITH THIS, JUST CANT GET THE LABEL TO DISPLAY THE UNIVERSITY///////////////
    //////////////////////////////////////////////////////////////////////////////////////////
    //register class: fixed SIGBART error
    [self.collectionView registerClass:[EventsCollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    
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
    EventsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //Sets up the Array to be displayed (needed if wanting a different row in different places)
    PFObject *TempObject = [EventsArray objectAtIndex:indexPath.row];
    
    //Displays the Skills in the labels
    //////////////////////////////////////////////////////////////////////////////////////////////
    /////CHANGE cell.EventsLabel.text = TO NSString * test = AND IT WILL PRINT TO THE CONSOLE/////
    //////////////////////////////////////////////////////////////////////////////////////////////
    //NSString * test = [TempObject objectForKey:@"university"];
    //NSLog(@"Array = %@", test);
    //////////////////////////////////////////////////////////////////////////////////////////////
    cell.EventsLabel.text = [TempObject objectForKey:@"university"];
    NSLog(@"Array = %@", TempObject);
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:(253/255.0) green:(128/255.0) blue:(35/255.0) alpha:1.0];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:(84/255.0) green:(118/255.0) blue:(140/255.0) alpha:1.0];
}

//#################################################################

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

