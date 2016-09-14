//
//  MealTableViewCell.h
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 14/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RatingControl.h"


@interface MealTableViewCell : UITableViewCell

#pragma mark Properties
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet RatingControl *ratingControl;

@end
