//
//  Meal.m
//  FoodTracker
//
//  Created by Tomas Garrido on 9/13/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "Meal.h"
static NSDictionary  *propertyKey;

@interface Meal()


@end

@implementation Meal

+(NSDictionary *)propertyKey {
    if (!propertyKey) propertyKey = @{@"nameKey" : @"name", @"photoKey" : @"photo", @"ratingKey" : @"rating" };
    return propertyKey;
}


- (instancetype)init:(NSString *)name photo:(UIImage *)photo rating:(NSInteger)rating {
    
    
    // Initialize stored properties.
    self.name = name;
    self.photo = photo;
    self.rating = rating;

    self = [super init];
    if (!self) return nil;
    
    // Initialization should fail if there is no name or if the rating is negative.
    if ([name length] == 0 || rating < 0) return nil;
    return self;
}

#pragma mark NSCoding
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name  forKey:propertyKey[@"nameKey"]];
    [aCoder encodeObject:self.photo forKey:propertyKey[@"photoKey"]];
    [aCoder encodeInteger:self.rating forKey:propertyKey[@"rating"]];
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {
    NSString *name = (NSString *)[aCoder decodeObjectForKey:propertyKey[@"nameKey"]];
    NSObject *object = [aCoder decodeObjectForKey:propertyKey[@"photoKey"]];
    UIImage *photo;
    if (object)   photo = (UIImage *)object;
    NSInteger rating = [aCoder decodeIntegerForKey:propertyKey[@"rating"]];
    return [self init:name photo:photo rating:rating];
}
@end