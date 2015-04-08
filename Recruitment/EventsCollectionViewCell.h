//
//  EventsCollectionViewCell.h
//  Recruitment
//
//  Created by Sean VanPelt on 4/6/15.
//  Copyright (c) 2015 AppAtUs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *EventsLabel;

@property (weak, nonatomic) IBOutlet UILabel *UniversityEventLabel;
@property (weak, nonatomic) IBOutlet UILabel *EventDateLabel;


@end
