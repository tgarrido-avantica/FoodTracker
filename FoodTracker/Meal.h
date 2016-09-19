//
//  Meal.h
//  FoodTracker
//
//  Created by Tomas Garrido on 9/13/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Meal : NSObject <NSCoding>;

+(nonnull NSURL *)archiveURL;

#pragma mark Properties
@property(nonatomic, nonnull) NSString *name;
@property(nonatomic, nullable) UIImage *photo;
@property(nonatomic) NSInteger rating;


#pragma mark Initialization
- (nullable instancetype) init:(nonnull NSString *)name photo:(nullable UIImage *)photo rating:(NSInteger)rating;

@end