//
//  CFPMAntibioticResistance.m
//  CFPM
//
//  Created by h.sayy on 17/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMAntibioticResistance.h"

#import "CFPMGenous.h"

@implementation CFPMAntibioticResistance

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMAntibioticResistance" owner:self options:nil];
    self = [nibViews objectAtIndex:0];
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

- (void) setPlotDataArray:(NSArray *)plotDataArray{
    if (plotDataArray != _plotDataArray) {
        _plotDataArray = [[NSArray alloc] initWithArray:plotDataArray];
    }
    [self constructChart];
}

- (void) constructChart {
    self.OutCome_A = [[CFPMGenous alloc] initWithFrame:CGRectMake(130, 0, RestistantChartWidth, RestistantChartHeight)];
    [self addSubview:[self OutCome_A]];
    self.OutCome_B = [[CFPMGenous alloc] initWithFrame:CGRectMake(270, 0, RestistantChartWidth, RestistantChartHeight)];
    [self addSubview:[self OutCome_B]];
    self.OutCome_C = [[CFPMGenous alloc] initWithFrame:CGRectMake(410, 0, RestistantChartWidth, RestistantChartHeight)];
    [self addSubview:[self OutCome_C]];
    self.OutCome_D = [[CFPMGenous alloc] initWithFrame:CGRectMake(550, 0, RestistantChartWidth, RestistantChartHeight)];
    [self addSubview:[self OutCome_D]];
    [self constructResistancePlotForIndex:0];
    [self constructResistancePlotForIndex:1];
    [self constructResistancePlotForIndex:2];
    [self constructResistancePlotForIndex:3];
}

- (void) constructResistancePlotForIndex:(int)index{
    if (index >= [[self plotDataArray] count]) {
        return;
    }
    CFPMGenous *genous = nil;
    switch (index) {
        case 0:
            genous = (CFPMGenous *)self.OutCome_A;
            break;
        case 1:
            genous = (CFPMGenous *)self.OutCome_B;
            break;
        case 2:
            genous = (CFPMGenous *)self.OutCome_C;
            break;
        case 3:
            genous = (CFPMGenous *)self.OutCome_D;
            break;
        default:
            break;
    }
    NSDictionary *plotData = [NSDictionary dictionaryWithDictionary:[[self plotDataArray] objectAtIndex:index]];
    if ([plotData objectForKey:@"Escherichia"]) {
        if ([[[plotData objectForKey:@"Escherichia"] objectForKey:@"AminoG"] intValue] == 0) {
            genous.AminoG_Es.hidden = YES;
        }
        if ([[[plotData objectForKey:@"Escherichia"] objectForKey:@"MacroL"] intValue] == 0) {
            genous.MacroL_Es.hidden = YES;
        }
    }
    if ([plotData objectForKey:@"Streptococcus"]) {
        if ([[[plotData objectForKey:@"Streptococcus"] objectForKey:@"AminoG"] intValue] == 0) {
            genous.AminoG_St.hidden = YES;
        }
        if ([[[plotData objectForKey:@"Streptococcus"] objectForKey:@"MacroL"] intValue] == 0) {
            genous.MacroL_St.hidden = YES;
        }
    }
    if ([plotData objectForKey:@"Rothia"]) {
        if ([[[plotData objectForKey:@"Rothia"] objectForKey:@"AminoG"] intValue] == 0) {
            genous.AminoG_R.hidden = YES;
        }
        if ([[[plotData objectForKey:@"Rothia"] objectForKey:@"MacroL"] intValue] == 0) {
            genous.MacroL_R.hidden = YES;
        }
    }if ([plotData objectForKey:@"Other"]) {
        if ([[[plotData objectForKey:@"Other"] objectForKey:@"AminoG"] intValue] == 0) {
            genous.AminoG_O.hidden = YES;
        }
        if ([[[plotData objectForKey:@"Other"] objectForKey:@"MacroL"] intValue] == 0) {
            genous.MacroL_O.hidden = YES;
        }
    }
}

@end
