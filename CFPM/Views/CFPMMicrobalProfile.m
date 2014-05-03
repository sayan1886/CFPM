//
//  CFPMMicrobalProfile.m
//  CFPM
//
//  Created by h.sayy on 18/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMMicrobalProfile.h"

#import "CFPMPieChart.h"

@implementation CFPMMicrobalProfile

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMMicrobalProfile" owner:self options:nil];
    self = [nibViews objectAtIndex:0];
    [self setFrame:frame];
    [self setAutoresizesSubviews:YES];
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

- (void) setPlotDataArray:(NSArray *)plotDataArray{
    if (plotDataArray != _plotDataArray) {
        _plotDataArray = [[NSArray alloc] initWithArray:plotDataArray];
    }
    [self constructPieChart];
}

- (void) constructPieChart{
    CFPMPieChart *pie1 = [[CFPMPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [pie1 setPlotData:[[self plotDataArray] objectAtIndex:0]];
    [[self pieChart1] addSubview:pie1];
    
    CFPMPieChart *pie2 = [[CFPMPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [pie2 setPlotData:[[self plotDataArray] objectAtIndex:1]];
    [[self pieChart2] addSubview:pie2];
    
    CFPMPieChart *pie3 = [[CFPMPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [pie3 setPlotData:[[self plotDataArray] objectAtIndex:2]];
    [[self pieChart3] addSubview:pie3];
    
    CFPMPieChart *pie4 = [[CFPMPieChart alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [pie4 setPlotData:[[self plotDataArray] objectAtIndex:3]];
    [[self pieChart4] addSubview:pie4];
}

@end
