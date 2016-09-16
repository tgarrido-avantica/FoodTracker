//
//  NSString+NSStringUtilities.h
//  FoodTracker
//
//  Created by Tomás Garrido Sandino on 16/9/16.
//  Copyright © 2016 Avantica Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (NSStringUtilities)

-(BOOL)isBlank;
-(BOOL)contains:(NSString *)string;
-(NSArray *)splitOnChar:(char)ch;
-(NSString *)substringFrom:(NSInteger)from to:(NSInteger)to;
-(NSString *)stringByStrippingWhitespace;
+(NSString *)stringByNilCoalesce:(NSString *)string;

@end