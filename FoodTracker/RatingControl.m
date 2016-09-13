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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSArray *)ratingButtons{
    if (!_ratingButtons) _ratingButtons = [NSMutableArray new];
    return _ratingButtons;
}

- (instancetype)initWithCoder:(NSCoder *) aDecoder {
    self = [super initWithCoder:aDecoder];
   
    for (int i = 0; i < 5; i++) {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, 44.0, 44.0)];
        button.backgroundColor = [UIColor redColor];
        [self addSubview:button];
        [self.ratingButtons addObject:button];
        [button addTarget:self  action:@selector(ratingButtonTapped:) forControlEvents:UIControlEventTouchDown];
    }
    return self;
}

- (void)layoutSubviews {
    // Offset each button's origin by the length of the button plus spacing.
    [self.ratingButtons enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        button.frame = CGRectMake(idx * (44.0 + 5.0), button.frame.origin.y,
                                  button.frame.size.height, button.frame.size.width);
    }];
     
    
}

- (CGSize)intrinsicContentSize {
    return CGSizeMake(240.0, 44.0);
}

#pragma mark Button Action
- (void)ratingButtonTapped:(UIButton *)button  {
    NSLog(@"Button pressed 👍");
}

@end
