//
//  Meal.m
//  FoodTracker
//
//  Created by Tomas Garrido on 9/13/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "Meal.h"
static NSDictionary  *_propertyKey = nil;

#pragma mark Archiving Paths
static NSURL *_documentsDirectory = nil;
static NSURL *_archiveURL = nil;

@interface Meal()


@end

@implementation Meal

+ (void)initialize {
    if (self == [Meal class]) {
        _documentsDirectory = [[[NSFileManager new] URLsForDirectory:NSDocumentDirectory
                                                          inDomains:NSUserDomainMask] firstObject];
        _archiveURL = [_documentsDirectory URLByAppendingPathComponent:@"meals"];
    }
}

+(NSURL *)archiveURL {
    return _archiveURL;
}

+(NSDictionary *)propertyKey {
    if (!_propertyKey) _propertyKey = @{@"nameKey" : @"name", @"photoKey" : @"photo", @"ratingKey" : @"rating" };
    return _propertyKey;
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
    [aCoder encodeObject:self.name  forKey:[self.class propertyKey][@"nameKey"]];
    [aCoder encodeObject:self.photo forKey:[self.class propertyKey][@"photoKey"]];
    [aCoder encodeInteger:self.rating forKey:[self.class propertyKey][@"ratingKey"]];
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {
    NSString *name = (NSString *)[aCoder decodeObjectForKey:[self.class propertyKey][@"nameKey"]];
    // Because photo is an optional property of Meal, use conditional cast.
    NSObject *object = [aCoder decodeObjectForKey:[self.class propertyKey][@"photoKey"]];
    UIImage *photo;
    if (object)   photo = (UIImage *)object;
    NSInteger rating = [aCoder decodeIntegerForKey:[self.class propertyKey][@"ratingKey"]];
    return [self init:name photo:photo rating:rating];
}

@end