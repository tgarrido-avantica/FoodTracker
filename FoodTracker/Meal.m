//
//  Meal.m
//  FoodTracker
//
//  Created by Tomas Garrido on 9/13/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "Meal.h"

@interface Meal()



@end

@implementation Meal

- (instancetype) init:(NSString *)name photo:(UIImage *)photo rating:(NSInteger)rating {
    
    self = [super init];
    if (!self) return nil;
    // Initialize stored properties.
    self.name = name;
    self.photo = photo;
    self.rating = rating;
    
    // Initialization should fail if there is no name or if the rating is negative.
    if ([name length] == 0 || rating < 0) return nil;
    return self;
}


@end