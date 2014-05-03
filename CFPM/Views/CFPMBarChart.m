//
//  CFPMBarChart.m
//  CFPM
//
//  Created by h.sayy on 16/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMBarChart.h"

@implementation CFPMBarChart
- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMBarChart" owner:self options:nil];
    self = [nibViews objectAtIndex:0];
    [self setFrame:frame];
    [self setAutoresizesSubviews:YES];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void) setPlotDataArray:(NSArray *)plotDataArray{
    if (plotDataArray != _plotDataArray) {
        _plotDataArray = [[NSArray alloc] initWithArray:plotDataArray];
    }
    [self constructBarChart];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void) constructBarChart {
    float barHeight = self.bounds.size.height;
    float barWidth = barHeight * 6 / 20;
    self.bar1 = [[CFPMBar alloc] initWithFrame:CGRectMake(5, 0, barWidth, barHeight)];
    [self addSubview:[self bar1]];
    self.bar2 = [[CFPMBar alloc] initWithFrame:CGRectMake(120, 0, barWidth, barHeight)];
    [self addSubview:[self bar2]];
    self.bar3 = [[CFPMBar alloc] initWithFrame:CGRectMake(235, 0, barWidth, barHeight)];
    [self addSubview:[self bar3]];
    self.bar4 = [[CFPMBar alloc] initWithFrame:CGRectMake(350, 0, barWidth, barHeight)];
    [self addSubview:[self bar4]];
    self.bar5 = [[CFPMBar alloc] initWithFrame:CGRectMake(465, 0, barWidth, barHeight)];
    [self addSubview:[self bar5]];
    
    if ([[[self plotDataArray] objectAtIndex:0] count] >= 1) {
        [self plotBar1];
    }
    if ([[[self plotDataArray] objectAtIndex:0] count] >= 2) {
        [self plotBar2];
    }
    if ([[[self plotDataArray] objectAtIndex:0] count] >= 3) {
        [self plotBar3];
    }
    if ([[[self plotDataArray] objectAtIndex:0] count] >= 4) {
        [self plotBar4];
    }
    if ([[[self plotDataArray] objectAtIndex:0] count] >= 5) {
        [self plotBar5];
    }
}

- (void) plotBar1 {
    [self plotBarForIndex:0];
}

- (void) plotBar2 {
    [self plotBarForIndex:1];
}

- (void) plotBar3 {
    [self plotBarForIndex:2];
}

- (void) plotBar4 {
    [self plotBarForIndex:3];
}

- (void) plotBar5 {
    [self plotBarForIndex:4];
}

- (void) plotBarForIndex:(NSInteger)index {
    CFPMBar *bar = nil;
    switch (index) {
        case 0:
            bar = self.bar1;
            break;
        case 1:
            bar = self.bar2;
            break;
        case 2:
            bar = self.bar3;
            break;
        case 3:
            bar = self.bar4;
            break;
        case 4:
            bar = self.bar5;
            break;
        default:
            break;
    }
    if (!bar) {
        return;
    }
    NSArray *antibiotics = [[[[self plotDataArray] objectAtIndex:0]objectAtIndex:index] componentsSeparatedByString:@","];
    for (int i = 0; i < [ANTI_BIOTIC count]; i++) {
        UILabel *cell = nil;
        switch (i) {
            case 0:
                cell = bar.cell7;
                break;
            case 2:
                cell = bar.cell6;
                break;
            case 3:
                cell = bar.cell5;
                break;
            case 4:
                cell = bar.cell4;
                break;
            case 5:
                cell = bar.cell3;
                break;
            case 6:
                cell = bar.cell2;
                break;
            case 7:
                cell = bar.cell1;
                break;
            default:
                break;
        }
        for (int j = 0; j < [antibiotics count]; j++) {
            NSString *medicine = [ANTI_BIOTIC objectAtIndex:i];
            NSString *antibiotic = [antibiotics objectAtIndex:j];
            if ([self contains:medicine in:antibiotic]) {
                if ([self contains:@"int" in:antibiotic] || [self contains:@"Int" in:antibiotic] || [self contains:@"INT" in:antibiotic]) {
                    [cell setBackgroundColor:YELLOW_COLOR];
                }
                else {
                    [cell setBackgroundColor:MERUN_COLOR];
                }
            }
        }
    }
    if ([self contains:ECOLI in:[[[self plotDataArray] objectAtIndex:1]objectAtIndex:index]]) {
        [bar.dot setBackgroundColor:ORANGE_COLOR];
        bar.dot.hidden = NO;
    }
    if ([self contains:P_AERUGINOSA in:[[[self plotDataArray] objectAtIndex:1]objectAtIndex:index]]) {
        [bar.dot setBackgroundColor:[UIColor blueColor]];
        bar.dot.hidden = NO;
    }
    if ([self contains:STREPTOCOCCUS in:[[[self plotDataArray] objectAtIndex:1]objectAtIndex:index]]) {
        [bar.dot setBackgroundColor:[UIColor blackColor]];
        bar.dot.hidden = NO;
    }
}

-(BOOL) contains:(NSString *)searchTerm in:(NSString *)string
{
    string = [string lowercaseString];
    searchTerm = [searchTerm lowercaseString];
    return  [string rangeOfString:searchTerm options:NSCaseInsensitiveSearch].location==NSNotFound?NO:YES;
}

@end
