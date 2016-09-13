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
@property (nonatomic) int rating;
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

- (instancetype)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
   
    for (int i = 0; i < STAR_COUNT; i++) {
        UIButton *button = [UIButton new];
        button.backgroundColor = [UIColor redColor];
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
}

- (CGSize)intrinsicContentSize {
    CGFloat buttonSize = self.frame.size.height;
    CGFloat width = (buttonSize * STAR_COUNT) + (SPACING * (STAR_COUNT - 1));
    return CGSizeMake(width, buttonSize);
}

#pragma mark Button Action
- (void)ratingButtonTapped:(UIButton *)button  {
    NSLog(@"Button pressed 👍");
}

@end
