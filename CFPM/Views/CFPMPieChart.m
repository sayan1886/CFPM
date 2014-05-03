//
//  CFPMPieChart.m
//  CFPM
//
//  Created by h.sayy on 18/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMPieChart.h"

@interface CFPMPieChart () <CPTPlotDataSource>
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@end

@implementation CFPMPieChart

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMPieChart" owner:self options:nil];
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

- (void) setPlotData:(NSDictionary *)plotData {
    if (plotData != _plotData) {
        _plotData = [[NSDictionary alloc] initWithDictionary:plotData copyItems:YES];
        if (self) {
            [self configureGraph];
            [self configurePlots];
            [self configureAxes];
            [[self numberOfReads] setText:[NSString stringWithFormat:@"%.2f",[[plotData objectForKey:@"read"] doubleValue]]];
            [self bringSubviewToFront:[self numberOfReads]];
        }
    }
}

-(void)configureGraph {
        // 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:_hostView.bounds];
	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
        // 2 - Set graph title
        // 3 - Create and set text style
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor blackColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, 10.0f);
        // 4 - Set padding for plot area
	[graph.plotAreaFrame setPaddingLeft:0.0f];
	[graph.plotAreaFrame setPaddingBottom:0.0f];
    // don't draw a border
    CPTMutableLineStyle *borderStyle=[CPTMutableLineStyle lineStyle];
    borderStyle.lineWidth = 0.0f;
    graph.plotAreaFrame.borderLineStyle = borderStyle;
    graph.plotAreaFrame.backgroundColor = [UIColor clearColor].CGColor;
    self.hostView.hostedGraph = graph;
}

-(void)configurePlots {
        // 1 - Get graph and Create chart
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTPieChart *pieChart =  [[CPTPieChart alloc] init];
    pieChart.dataSource = self;
//    pieChart.delegate = self;
    pieChart.pieRadius = (self.hostView.bounds.size.height * 0.7f) / 2;
    pieChart.pieInnerRadius = (self.hostView.bounds.size.height * 0.4f) / 2;
    pieChart.identifier = graph.title;
    pieChart.startAngle = M_PI_4;
    pieChart.sliceDirection = CPTPieDirectionClockwise;
        // 3 - Create gradient
//    CPTGradient *overlayGradient = [[CPTGradient alloc] init];
//    overlayGradient.gradientType = CPTGradientTypeRadial;
//    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.0] atPosition:0.9];
//    overlayGradient = [overlayGradient addColorStop:[[CPTColor blackColor] colorWithAlphaComponent:0.4] atPosition:1.0];
//    pieChart.overlayFill = [CPTFill fillWithGradient:overlayGradient];
        // 4 - Add chart to graph
    [graph addPlot:pieChart];
}

-(void)configureAxes {
        // 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor blackColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 10.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth =0.0f;
	axisLineStyle.lineColor = [CPTColor blackColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor blackColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 10.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 0.0f;
    
        // 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
        // 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.titleTextStyle = axisTitleStyle;
	x.titleOffset = 0.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 0.0f;
        //    x.minorTickLength = 1.0f;
	x.tickDirection = CPTSignPositive;
	   
        // 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.titleTextStyle = axisTitleStyle;
	y.axisLineStyle = axisLineStyle;
        //    y.majorGridLineStyle = axisLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 0.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 0.0f;
	y.minorTickLength = 0.0f;
	y.tickDirection = CPTSignPositive;
    
}

#pragma mark - CPTPlotDataSource

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return [[[self plotData] objectForKey:@"plot"] count] ;
}

-(CPTFill *)sliceFillForPieChart:(CPTPieChart *)pieChart recordIndex:(NSUInteger)index
{
    CPTFill *areaGradientFill ;
    /*
    if (index==0)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor orangeColor]];
    else if (index==1)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor merunColor]];
    else if (index==2)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor greenColor]];
    else if (index==3)
        return areaGradientFill= [CPTFill fillWithColor:[CPTColor yellowColor]];
    else
        return areaGradientFill = [CPTFill fillWithColor:[CPTColor clearColor]];
    */
    return areaGradientFill = [CPTFill fillWithColor:COLOR([[[[self plotData] objectForKey:@"plot"] objectAtIndex:index] objectForKey:@"Species"])];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	if (CPTPieChartFieldSliceWidth == fieldEnum) {
		return [[[[self plotData] objectForKey:@"plot"] objectAtIndex:index] objectForKey:@"Plot"];
	}
    return [NSDecimalNumber zero];
}

@end
