//
//  CFPMGenous.m
//  CFPM
//
//  Created by h.sayy on 17/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMGenous.h"

@implementation CFPMGenous

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMAntibioticResistance" owner:self options:nil];
    self = [nibViews objectAtIndex:1];
    [self setFrame:frame];
    [self setAutoresizesSubviews:YES];
    if (self) {
            // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
