//
//  RatingControl.m
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 12/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import "RatingControl.h"

@interface RatingControl ()

#pragma mark Properties
@property (nonatomic) NSMutableArray *ratingButtons;

@end

@implementation RatingControl

#pragma mark Constants
static const int SPACING = 5.0;
static const int STAR_COUNT = 5;

#pragma mark Implementation methods

- (NSArray *)ratingButtons{
    if (!_ratingButtons) _ratingButtons = [NSMutableArray new];
    return _ratingButtons;
}

- (void)setRating:(NSUInteger) aRating {
    _rating = aRating;
    [self setNeedsLayout];
}

- (instancetype)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
    UIImage *filledStarImage = [UIImage imageNamed:@"filledStar"];
    UIImage *emptyStarImage = [UIImage imageNamed:@"emptyStar"];
    for (int i = 0; i < STAR_COUNT; i++) {
        UIButton *button = [UIButton new];
        [button setImage:emptyStarImage forState:UIControlStateNormal];
        [button setImage:filledStarImage forState:UIControlStateSelected];
        [button setImage:filledStarImage forState:UIControlStateHighlighted | UIControlStateSelected];
        [button setAdjustsImageWhenHighlighted:NO];
        [button addTarget:self  action:@selector(ratingButtonTapped:) forControlEvents:UIControlEventTouchDown];
        [self.ratingButtons addObject:button];
        [self addSubview:button];
    }
    return self;
}

- (void)layoutSubviews {
    // Set the button's width and height to a square the size of the frame's height.
    CGFloat buttonSize = self.frame.size.height;
    __block CGRect frame = CGRectMake(0.0, 0.0, buttonSize, buttonSize);
    
    // Offset each button's origin by the length of the button plus spacing.
    [self.ratingButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        frame.origin.x = idx * (buttonSize + SPACING);
        button.frame = frame;
    }];
    [self updateButtonSelectionStates];
}

- (CGSize)intrinsicContentSize {
    CGFloat buttonSize = self.frame.size.height;
    CGFloat width = (buttonSize * STAR_COUNT) + (SPACING * (STAR_COUNT - 1));
    return CGSizeMake(width, buttonSize);
}

- (void)updateButtonSelectionStates {
    [self.ratingButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        // If the index of a button is less than the rating, that button shouldn't be selected.
        button.selected = idx < self.rating;
    }];
}

#pragma mark Button Action
- (void)ratingButtonTapped:(UIButton *)button  {
    self.rating = [self.ratingButtons indexOfObject:(button)] + 1;
}



@end
