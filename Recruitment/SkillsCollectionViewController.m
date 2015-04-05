#import "SkillsCollectionViewController.h"
#import "SkillsCollectionViewCell.h"

@interface SkillsCollectionViewController ()

@end

@implementation SkillsCollectionViewController {
    NSArray *SkillsArray; //Sets up my Array
}

NSArray *SkillIndexPath;

NSString *SkillResult = @"";

static NSString * const reuseIdentifier = @"Cell";


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Runs the "retrieveFromParse method
    [self performSelector:@selector(retrieveFromParse)];
    
    //Allows for selecting more than one Skill
    self.collectionView.allowsMultipleSelection = YES;
    
}

- (void) retrieveFromParse {
    //Get info from the database
    PFQuery *retrieveSkills =[PFQuery queryWithClassName:@"SkillsTable"];
    
    //Orders the Skills in ABC Order
    [retrieveSkills orderByAscending:@"Skills"];
    
    //Puts Table info into a array
    SkillsArray = [retrieveSkills findObjects];
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
    return SkillsArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SkillsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //Sets up the Array to be displayed (needed if wanting a different row in different places)
    PFObject *TempObject = [SkillsArray objectAtIndex:indexPath.row];
    
    //Displays the Skills in the labels
    cell.SkillsLabel.text = [TempObject objectForKey:@"Skills"];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell* cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor colorWithRed:(253/255.0) green:(128/255.0) blue:(35/255.0) alpha:1.0];
    
    //Gets selected Skills and puts them into a string
    PFObject *TempObject = [SkillsArray objectAtIndex:indexPath.row];
    SkillResult = [SkillResult stringByAppendingString:[TempObject objectForKey:@"Skills"]];
    SkillResult = [SkillResult stringByAppendingString:@", "];
    
    //NSLog(@"SkillResult: %@", SkillResult);
    
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
