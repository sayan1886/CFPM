    //
    //  CFPMPatientOutcome.m
    //  CFPM
    //
    //  Created by h.sayy on 17/04/14.
    //  Copyright (c) 2014 h.sayy. All rights reserved.
    //

#import "CFPMPatientOutcome.h"

@interface CPTColor (Pie)
+ (instancetype) greenColor;
@end
@implementation CPTColor (Pie)
+ (instancetype) greenColor{
    static CPTColor *color = nil;
    
    if ( nil == color ) {
        color = [[CPTColor alloc] initWithComponentRed:CPTFloat(40.0f/255.0f) green:CPTFloat(70.0f/255.0f) blue:CPTFloat(34.0f/255.0f) alpha:CPTFloat(1.0)];
    }
    return color;
}
@end

@interface CFPMPatientOutcome ()
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@end

@implementation CFPMPatientOutcome

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMPatientOutcome" owner:self options:nil];
    self = [nibViews objectAtIndex:0];
    [self setFrame:frame];
    [self setAutoresizesSubviews:YES];
    return self;
}

- (void) setPlotDataArray:(NSArray *)plotDataArray {
    if (plotDataArray != _plotDataArray) {
        _plotDataArray = [[NSArray alloc] initWithArray:plotDataArray copyItems:YES];
        if (self) {
            [self configureGraph];
            [self configurePlots];
            [self configureAxes];
            [self configureLegend];
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


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
	[graph.plotAreaFrame setPaddingLeft:15.0f];
	[graph.plotAreaFrame setPaddingBottom:5.0f];
        // 5 - Enable user interactions for plot space
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.allowsUserInteraction = YES;
    self.hostView.hostedGraph = graph;
}

-(void)configurePlots {
        // 1 - Get graph and plot space
	CPTGraph *graph = self.hostView.hostedGraph;
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
        // 2 - Create the three plots
	CPTScatterPlot *physicalPlot = [[CPTScatterPlot alloc] init];
	physicalPlot.dataSource = self;
	physicalPlot.identifier = [@"physical" capitalizedString];
	CPTColor *physicalPlotColor = [CPTColor blackColor];
	[graph addPlot:physicalPlot toPlotSpace:plotSpace];
    
	CPTScatterPlot *respatoryPlot = [[CPTScatterPlot alloc] init];
	respatoryPlot.dataSource = self;
	respatoryPlot.identifier = [@"respatory" capitalizedString];
	CPTColor *respatoryPlotColor = [CPTColor blueColor];
    [graph addPlot:respatoryPlot toPlotSpace:plotSpace];
    
    CPTScatterPlot *ucsdPlot = [[CPTScatterPlot alloc] init];
	ucsdPlot.dataSource = self;
	ucsdPlot.identifier = [@"ucsd" capitalizedString];
	CPTColor *ucsdPlotColor = [CPTColor greenColor];
    [graph addPlot:ucsdPlot toPlotSpace:plotSpace];
    
    
        // 3 - Set up plot space
	[plotSpace scaleToFitPlots:[NSArray arrayWithObjects:physicalPlot, respatoryPlot, ucsdPlot, nil]];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(2.0f)];
	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(2.0f)];
	plotSpace.yRange = yRange;
    
        // 4 - Create styles and symbols
	CPTMutableLineStyle *physicalPlotLineStyle = [physicalPlot.dataLineStyle mutableCopy];
	physicalPlotLineStyle.lineWidth = 1.0;
	physicalPlotLineStyle.lineColor = physicalPlotColor;
	physicalPlot.dataLineStyle = physicalPlotLineStyle;
	CPTMutableLineStyle *physicalPlotSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	physicalPlotSymbolLineStyle.lineColor = physicalPlotColor;
    
    CPTMutableLineStyle *respatoryPlotLineStyle = [respatoryPlot.dataLineStyle mutableCopy];
	respatoryPlotLineStyle.lineWidth = 1.0;
	respatoryPlotLineStyle.lineColor = physicalPlotColor;
	respatoryPlot.dataLineStyle = respatoryPlotLineStyle;
	CPTMutableLineStyle *respatoryPlotSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	respatoryPlotSymbolLineStyle.lineColor = respatoryPlotColor;
    
    CPTMutableLineStyle *ucsdPlotLineStyle = [ucsdPlot.dataLineStyle mutableCopy];
	ucsdPlotLineStyle.lineWidth = 1.0;
	ucsdPlotLineStyle.lineColor = ucsdPlotColor;
	ucsdPlot.dataLineStyle = ucsdPlotLineStyle;
	CPTMutableLineStyle *ucsdPlotSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	ucsdPlotSymbolLineStyle.lineColor = ucsdPlotColor;
    
    
	CPTPlotSymbol *physcialPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	physcialPlotSymbol.fill = [CPTFill fillWithColor:physicalPlotColor];
	physcialPlotSymbol.lineStyle = physicalPlotLineStyle;
	physcialPlotSymbol.size = CGSizeMake(6.0f, 6.0f);
    physicalPlot.plotSymbol = physcialPlotSymbol;
    
	CPTPlotSymbol *respartoryPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	respartoryPlotSymbol.fill = [CPTFill fillWithColor:respatoryPlotColor];
	respartoryPlotSymbol.lineStyle = respatoryPlotLineStyle;
	respartoryPlotSymbol.size = CGSizeMake(6.0f, 6.0f);
    respatoryPlot.plotSymbol = respartoryPlotSymbol;
    
    CPTPlotSymbol *ucsdPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	ucsdPlotSymbol.fill = [CPTFill fillWithColor:ucsdPlotColor];
	ucsdPlotSymbol.lineStyle = ucsdPlotLineStyle;
	ucsdPlotSymbol.size = CGSizeMake(6.0f, 6.0f);
    ucsdPlot.plotSymbol = ucsdPlotSymbol;
    
}

-(void)configureAxes {
        // 1 - Create styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor blackColor];
	axisTitleStyle.fontName = @"Helvetica-Bold";
	axisTitleStyle.fontSize = 10.0f;
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 1.0f;
	axisLineStyle.lineColor = [CPTColor blackColor];
	CPTMutableTextStyle *axisTextStyle = [[CPTMutableTextStyle alloc] init];
	axisTextStyle.color = [CPTColor blackColor];
	axisTextStyle.fontName = @"Helvetica-Bold";
	axisTextStyle.fontSize = 10.0f;
	CPTMutableLineStyle *tickLineStyle = [CPTMutableLineStyle lineStyle];
	tickLineStyle.lineColor = [CPTColor blackColor];
	tickLineStyle.lineWidth = 0.5f;

    
        // 2 - Get axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
        // 3 - Configure x-axis
	CPTAxis *x = axisSet.xAxis;
	x.titleTextStyle = axisTitleStyle;
	x.titleOffset = 15.0f;
	x.axisLineStyle = axisLineStyle;
	x.labelingPolicy = CPTAxisLabelingPolicyNone;
	x.labelTextStyle = axisTextStyle;
	x.majorTickLineStyle = axisLineStyle;
	x.majorTickLength = 5.0f;
        //    x.minorTickLength = 1.0f;
	x.tickDirection = CPTSignPositive;
	
    
    CGFloat dateCount = [_plotDataArray count];
	NSMutableSet *xLabels = [NSMutableSet setWithCapacity:dateCount];
	NSMutableSet *xLocations = [NSMutableSet setWithCapacity:dateCount];
        //	NSInteger i = 0;
    
	for (int i = 0; i <= dateCount; i++) {
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[self getXAxisLabelForIndex:i] textStyle:x.labelTextStyle];
		CGFloat location = i;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = x.majorTickLength;
		if (label) {
			[xLabels addObject:label];
			[xLocations addObject:[NSNumber numberWithFloat:location]];
		}
	}
        //	x.axisLabels = xLabels;
	x.majorTickLocations = xLocations;
    
        // 4 - Configure y-axis
	CPTAxis *y = axisSet.yAxis;
	y.titleTextStyle = axisTitleStyle;
	y.axisLineStyle = axisLineStyle;
        //    y.majorGridLineStyle = axisLineStyle;
	y.labelingPolicy = CPTAxisLabelingPolicyNone;
	y.labelTextStyle = axisTextStyle;
	y.labelOffset = 15.0f;
	y.majorTickLineStyle = axisLineStyle;
	y.majorTickLength = 5.0f;
	y.minorTickLength = 0.5f;
	y.tickDirection = CPTSignPositive;
    
    int minValue = [[self getMinY] intValue], maxValue = [[self getMaxY] intValue];
    NSInteger majorIncrement = 50.0f;
	NSInteger minorIncrement = 25.0f;
    int factor = 10;
    NSInteger roundedofMin = 0;
    NSInteger roundedofMax = 0;
    if (minValue != maxValue) {
        roundedofMin = (minValue - factor) + (factor - ((minValue - factor) % factor));
        roundedofMax = (maxValue + factor) + (factor - ((maxValue + factor) % factor));
    }
    if (roundedofMin == minValue) {
        roundedofMin -= majorIncrement;
    }
    if (roundedofMax == maxValue) {
        roundedofMax += minorIncrement;
    }
    
	CGFloat yMax = roundedofMax;  // should determine dynamically based on max price
	NSMutableSet *yLabels = [NSMutableSet set];
	NSMutableSet *yMajorLocations = [NSMutableSet set];
	NSMutableSet *yMinorLocations = [NSMutableSet set];
    
	for (NSInteger j = roundedofMin; j <= yMax; j += minorIncrement) {
		NSUInteger mod = j % factor;
		if (mod == 0) {
			CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%d", j] textStyle:y.labelTextStyle];
			NSDecimal location = CPTDecimalFromInteger(j);
			label.tickLocation = location;
			label.offset = -y.majorTickLength - y.labelOffset;
			if (label) {
				[yLabels addObject:label];
			}
			[yMajorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:location]];
		} else {
			[yMinorLocations addObject:[NSDecimalNumber decimalNumberWithDecimal:CPTDecimalFromInteger(j)]];
		}
	}
    
    
	y.axisLabels = yLabels;
	y.majorTickLocations = yMajorLocations;
        //    y.minorTickLocations = yMinorLocations;
    
    
        //set the axes within the range
    CPTXYAxis *yAxis = axisSet.yAxis;
    yAxis.orthogonalCoordinateDecimal = CPTDecimalFromFloat(roundedofMin);
    yAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:10.0];
    
    CPTXYAxis *xAxis = axisSet.xAxis;
    yAxis.orthogonalCoordinateDecimal = CPTDecimalFromFloat(roundedofMin);
    xAxis.axisConstraints = [CPTConstraints constraintWithLowerOffset:10.0];
    
}

-(void)configureLegend {
        // 1 - Get graph instance
	CPTGraph *graph = self.hostView.hostedGraph;
        // 2 - Create legend
	CPTLegend *theLegend = [CPTLegend legendWithGraph:graph];
        // 3 - Configure legen
	theLegend.numberOfColumns = 1;
	theLegend.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
	theLegend.borderLineStyle = [CPTLineStyle lineStyle];
	theLegend.cornerRadius = 5.0;
        // 4 - Add legend to graph
	graph.legend = theLegend;
	graph.legendAnchor = CPTRectAnchorTopRight;
        //	CGFloat legendPadding = -(self.view.bounds.size.width / 8);
	graph.legendDisplacement = CGPointMake(-22.0, -22.0);
}

#pragma mark - CPTPlotDataSource

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot{
    return [[[self plotDataArray] objectAtIndex:1]count] ;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	NSInteger valueCount = [[[self plotDataArray] objectAtIndex:0] count];
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
			if (index < valueCount) {
				return [self plotDate:index];
			}
			break;
            
		case CPTScatterPlotFieldY:
			if ([plot.identifier isEqual:[@"physical" capitalizedString]] == YES) {
				return [self plotPhysical:index];
			} else if ([plot.identifier isEqual:[@"respatory" capitalizedString]] == YES) {
				return [self plotRespatory:index];
			}
            else if([plot.identifier isEqual:[@"ucsd" capitalizedString]]){
                return [self plotUCSD:index];
            }
			break;
	}
	return [NSDecimalNumber zero];
}

#pragma mark - PlotHelper

- (NSNumber *) getMaxY {
    int maxY = NSIntegerMin;
    if ([[[self plotDataArray] objectAtIndex:1] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:1] count]; i++) {
            if (maxY < [[[[self plotDataArray] objectAtIndex:1] objectAtIndex:i] integerValue]) {
                maxY = [[[[self plotDataArray] objectAtIndex:1] objectAtIndex:i] integerValue];
            }
        }
    }
    if ([[[self plotDataArray] objectAtIndex:2] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:1] count]; i++) {
            if (maxY < [[[[self plotDataArray] objectAtIndex:2] objectAtIndex:i] integerValue]) {
                maxY = [[[[self plotDataArray] objectAtIndex:2] objectAtIndex:i] integerValue];
            }
        }
    }
    if ([[[self plotDataArray] objectAtIndex:3] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:3] count]; i++) {
            if (maxY < [[[[self plotDataArray] objectAtIndex:3] objectAtIndex:i] integerValue]) {
                maxY = [[[[self plotDataArray] objectAtIndex:3] objectAtIndex:i] integerValue];
            }
        }
    }
    return [NSNumber numberWithInt:maxY];
}

-(NSNumber *) getMinY {
    int minY = NSIntegerMax;
    if ([[[self plotDataArray] objectAtIndex:1] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:1] count]; i++) {
            if (minY > [[[[self plotDataArray] objectAtIndex:1] objectAtIndex:i] integerValue]) {
                minY = [[[[self plotDataArray] objectAtIndex:1] objectAtIndex:i] integerValue];
            }
        }
    }
    if ([[[self plotDataArray] objectAtIndex:1] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:2] count]; i++) {
            if (minY > [[[[self plotDataArray] objectAtIndex:2] objectAtIndex:i] integerValue]) {
                minY = [[[[self plotDataArray] objectAtIndex:2] objectAtIndex:i] integerValue];
            }
        }
    }
    if ([[[self plotDataArray] objectAtIndex:1] count] > 0) {
        for (int i = 0; i < [[[self plotDataArray] objectAtIndex:3] count]; i++) {
            if (minY > [[[[self plotDataArray] objectAtIndex:3] objectAtIndex:i] integerValue]) {
                minY = [[[[self plotDataArray] objectAtIndex:3] objectAtIndex:i] integerValue];
            }
        }
    }
    return [NSNumber numberWithInt:minY];
}

- (NSString *) getXAxisLabelForIndex : (NSInteger) index {
    return @"";
}

- (NSNumber *) plotDate:(NSUInteger)index{
        //    return [NSNumber numberWithDouble:0.0f];
    NSString *dateString  = [[[self plotDataArray] objectAtIndex:0] objectAtIndex:index];
        //    // x axis - return observation date converted to UNIX TS as NSNumber
        //    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        //    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        //    NSDate * observationDate = [dateFormatter dateFromString:dateString];
        //    NSTimeInterval secondsSince1970 = [observationDate timeIntervalSince1970];
        //    int num = [[[dateString componentsSeparatedByString:@"-"] objectAtIndex:1] intValue] ;
    return [NSNumber numberWithDouble:(index + 1)];
}

- (NSNumber *) plotPhysical:(NSUInteger)index{
    return [NSNumber numberWithDouble:[[[[self plotDataArray] objectAtIndex:1] objectAtIndex:index] doubleValue]];
}

- (NSNumber *) plotRespatory:(NSUInteger)index{
    return [NSNumber numberWithDouble:[[[[self plotDataArray] objectAtIndex:2] objectAtIndex:index] doubleValue]];
}

- (NSNumber *) plotUCSD:(NSUInteger)index{
    return [NSNumber numberWithDouble:[[[[self plotDataArray] objectAtIndex:3] objectAtIndex:index] doubleValue]];
}

@end
