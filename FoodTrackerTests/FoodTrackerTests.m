//
//  FoodTrackerTests.m
//  FoodTrackerTests
//
//  Created by Tomás Garrido Sandino on 12/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "../FoodTracker/Meal.h"

@interface FoodTrackerTests : XCTestCase

@end

@implementation FoodTrackerTests

// Tests to confirm that the Meal initializer returns when no name or a negative rating is provided.
- (void)testMealInitialization {
    // Success case.
    Meal *potentialItem = [[Meal alloc] init:@"Newest meal" photo:nil rating:5];
    XCTAssertNotNil(potentialItem);
    
    // Failure cases.
    Meal *noName = [[Meal alloc] init:@""  photo: nil  rating: 0];
    XCTAssertNil(noName, "Empty name is invalid");
    
    Meal *badRating = [[Meal alloc] init:@"Really bad rating" photo: nil rating: -1];
    XCTAssertNil(badRating, "Negative ratings are invalid, be positive");
}
@end
