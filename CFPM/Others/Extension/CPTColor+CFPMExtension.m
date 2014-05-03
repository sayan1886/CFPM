//
//  CPTColor+CFPMExtension.m
//  CFPM
//
//  Created by h.sayy on 04/05/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CPTColor+CFPMExtension.h"

@implementation CPTColor (CFPMExtension)
+ (instancetype) orangeColor{
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(174.0f/255.0f) green:CPTFloat(114.0f/255.0f) blue:CPTFloat(60.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
+ (instancetype) merunColor {
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(165.0f/255.0f) green:CPTFloat(65.0f/255.0f) blue:CPTFloat(43.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
+ (instancetype) yellowColor{
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(210.0f/255.0f) green:CPTFloat(180.0f/255.0f) blue:CPTFloat(80.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
+ (instancetype) greenColor{
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(40.0f/255.0f) green:CPTFloat(70.0f/255.0f) blue:CPTFloat(34.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
+ (instancetype) violetColor{
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(118.0f/255.0f) green:CPTFloat(57.0f/255.0f) blue:CPTFloat(255.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
@end
