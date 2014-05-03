//
//  CFPMFevGraph.m
//  CFPM
//
//  Created by h.sayy on 18/04/14.
//  Copyright (c) 2014 h.sayy. All rights reserved.
//

#import "CFPMFevGraph.h"
#import "PopoverView.h"

@interface CFPMFevGraph () <CPTBarPlotDataSource, CPTPlotDelegate>
@property (strong, nonatomic) IBOutlet CPTGraphHostingView *hostView;
@end

@implementation CFPMFevGraph

- (id)initWithFrame:(CGRect)frame
{
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"CFPMFevGraph" owner:self options:nil];
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
	[graph.plotAreaFrame setPaddingLeft:20.0f];
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
	CPTScatterPlot *fevPlot = [[CPTScatterPlot alloc] init];
	fevPlot.dataSource = self;
    fevPlot.delegate = self;
	fevPlot.identifier = [@"FEV%" capitalizedString];
	CPTColor *fevPlotColor = [CPTColor blackColor];
	[graph addPlot:fevPlot toPlotSpace:plotSpace];
    
        // 3 - Set up plot space
	[plotSpace scaleToFitPlots:[NSArray arrayWithObjects:fevPlot, nil]];
	CPTMutablePlotRange *xRange = [plotSpace.xRange mutableCopy];
	[xRange expandRangeByFactor:CPTDecimalFromCGFloat(0.5f)];
//	plotSpace.xRange = xRange;
	CPTMutablePlotRange *yRange = [plotSpace.yRange mutableCopy];
	[yRange expandRangeByFactor:CPTDecimalFromCGFloat(2.0f)];
	plotSpace.yRange = yRange;
    
    
        // 4 - Create styles and symbols
	CPTMutableLineStyle *fevPlotLineStyle = [fevPlot.dataLineStyle mutableCopy];
	fevPlotLineStyle.lineWidth = 1.0;
	fevPlotLineStyle.lineColor = fevPlotColor;
	fevPlot.dataLineStyle = fevPlotLineStyle;
	CPTMutableLineStyle *fevPlotSymbolLineStyle = [CPTMutableLineStyle lineStyle];
	fevPlotSymbolLineStyle.lineColor = fevPlotColor;
    
	CPTPlotSymbol *fevPlotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
	fevPlotSymbol.fill = [CPTFill fillWithColor:fevPlotColor];
	fevPlotSymbol.lineStyle = fevPlotLineStyle;
	fevPlotSymbol.size = CGSizeMake(6.0f, 6.0f);
    fevPlot.plotSymbol = fevPlotSymbol;
    
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
	
    
    CGFloat dateCount = [[self plotDataArray] count];
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
    y.title = @"FEV%";
    y.titleOffset = -30.0f;
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
    
    CPTGraph *graph = _hostView.hostedGraph;
    if (roundedofMin != roundedofMax && [[self plotDataArray] count] > 0) {
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
//            //block negetive scrolling
//        CPTPlotRange *globalYRange = [[CPTPlotRange alloc] initWithLocation:CPTDecimalFromInteger(roundedofMin - 2) length:CPTDecimalFromInteger(roundedofMax - roundedofMin + 2)];
//            //        plotSpace.globalYRange = globalYRange;
//        [plotSpace setGlobalYRange:globalYRange];
        
//        CPTPlotRange *globalXRange = [[CPTPlotRange alloc] initWithLocation:CPTDecimalFromInteger(-1) length:CPTDecimalFromInteger([_plotDataArray count] + 1)];
//            //        plotSpace.globalXRange = globalXRange;
//        [plotSpace setGlobalXRange:globalXRange];
        plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromInt(0.5 * [[self plotDataArray] count])];
        plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(roundedofMin) length:CPTDecimalFromFloat(roundedofMax - roundedofMin)];
    }

    
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
    return [[self plotDataArray] count] ;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	NSInteger valueCount = [[self plotDataArray]  count];
	switch (fieldEnum) {
		case CPTScatterPlotFieldX:
			if (index < valueCount) {
				return [self plotDate:index];
			}
			break;
            
		case CPTScatterPlotFieldY:
			if ([plot.identifier isEqual:[@"FEV%" capitalizedString]] == YES) {
				return [self plotFEV:index];
			}
			break;
	}
	return [NSDecimalNumber zero];
}

#pragma mark - CPTPlotDelegate

-(void)scatterPlot:(CPTScatterPlot *)plot plotSymbolTouchUpAtRecordIndex:(NSUInteger)idx {
//    NSLog(@"Data : %@",[[self plotDataArray] objectAtIndex:idx]);
    NSDecimal plotPoint[2];
    NSNumber *plotXvalue = [self numberForPlot:plot
                                         field:CPTScatterPlotFieldX
                                   recordIndex:idx];
    plotPoint[CPTCoordinateX] = plotXvalue.decimalValue;
    
    NSNumber *plotYvalue = [self numberForPlot:plot
                                         field:CPTScatterPlotFieldY
                                   recordIndex:idx];
    plotPoint[CPTCoordinateY] = plotYvalue.decimalValue;
    
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)[[self hostView] hostedGraph].defaultPlotSpace;
    
        // convert from data coordinates to plot area coordinates
    CGPoint dataPoint = [plotSpace plotAreaViewPointForPlotPoint:plotPoint numberOfCoordinates:2];
    
        // convert from plot area coordinates to graph (and hosting view) coordinates
    dataPoint = [/*[[self hostView] hostedGraph]*/[self layer] convertPoint:dataPoint fromLayer:[[self hostView] hostedGraph].plotAreaFrame.plotArea];
    
        // convert from hosting view coordinates to self.view coordinates (if needed)
//    dataPoint = [self convertPoint:dataPoint fromView:[self hostView]];
    
    NSLog(@"barWasSelectedAtRecordIndex x: %@, y: %@", plotXvalue, plotYvalue);
    NSLog(@"datapoint coordinates tapped: %@", NSStringFromCGPoint(dataPoint));
    
    [PopoverView showPopoverAtPoint:dataPoint
                             inView:self
                          withTitle:[self getFormattedDateStringFromString:[[[self plotDataArray] objectAtIndex:idx] objectForKey:@"Date"]]
                    withStringArray:@[[[[self plotDataArray] objectAtIndex:idx] objectForKey:@"HealthStat"], [[[self plotDataArray] objectAtIndex:idx] objectForKey:@"Disease_State"], [[[self plotDataArray] objectAtIndex:idx] objectForKey:@"Treatment"]]
                           delegate:nil];
}

- (NSString *) getFormattedDateStringFromString:(NSString *) dateString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate * observationDate = [dateFormatter dateFromString:dateString];
    [dateFormatter setDateFormat:@"dd MMM yyyy"];
    return [dateFormatter stringFromDate:observationDate];
}

/*
-(BOOL)plotSpace:(CPTPlotSpace *)space shouldHandlePointingDeviceDownEvent:(CPTNativeEvent *)event atPoint:(CGPoint)point {
    
    CPTScatterPlot *plot = (CPTScatterPlot*)[[[[self hostView] hostedGraph]allPlots] objectAtIndex: 0];
    CGPoint pointInPlotArea = [plot convertPoint:point toLayer:plot];
    
    if ([plot containsPoint:pointInPlotArea]) {
        CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace*)[[[self hostView] hostedGraph]defaultPlotSpace];
        NSDecimal touchDataPoint[2];
        [plotSpace plotPoint:touchDataPoint numberOfCoordinates:2 forPlotAreaViewPoint:pointInPlotArea ];
        [self showPopOverAtPoint:point];
        return YES;
    }
    return NO;
}*/

#pragma mark - Private
- (UIColor *)_pleaseGiveMeARandomColor
{
    NSInteger countOfItems = 200;
    NSInteger random = arc4random()%countOfItems;
    UIColor *color = [UIColor colorWithHue:(CGFloat)random/countOfItems saturation:.6f brightness:.7f alpha:.5f];
    return color;
}

#pragma mark - PlotHelper

- (NSNumber *) getMaxY {
    int maxY = NSIntegerMin;
    if ([[self plotDataArray] count] > 0) {
        for (int i = 0; i < [[self plotDataArray]  count]; i++) {
            if (maxY < [[[[self plotDataArray] objectAtIndex:i] objectForKey:@"FEV1"] integerValue]) {
                maxY = [[[[self plotDataArray] objectAtIndex:i] objectForKey:@"FEV1"] integerValue];
            }
        }
    }
    return [NSNumber numberWithInt:maxY];
}

-(NSNumber *) getMinY {
    int minY = NSIntegerMax;
    if ([[self plotDataArray] count] > 0) {
        for (int i = 0; i < [[self plotDataArray]  count]; i++) {
            if (minY > [[[[self plotDataArray] objectAtIndex:i] objectForKey:@"FEV1"] integerValue]) {
                minY = [[[[self plotDataArray] objectAtIndex:i] objectForKey:@"FEV1"] integerValue];
            }
        }
    }
    return [NSNumber numberWithInt:minY];
}

- (NSString *) getXAxisLabelForIndex : (NSInteger) index {
    return @"";
}

- (NSNumber *) plotDate:(NSUInteger)index{
//    NSString *dateString  = [[[self plotDataArray] objectAtIndex:0] objectForKey:@"Date"];
//    // x axis - return observation date converted to UNIX TS as NSNumber
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    NSDate * observationDate = [dateFormatter dateFromString:dateString];
//    NSTimeInterval secondsSince1970 = [observationDate timeIntervalSince1970];
//    long long int day  = secondsSince1970 / (24 * 3600);
//    return [NSNumber numberWithLongLong:day];
    return [NSNumber numberWithDouble:(index + 1)];
}

- (NSNumber *) plotFEV:(NSUInteger)index{
    return [NSNumber numberWithDouble:[[[[self plotDataArray] objectAtIndex:index] objectForKey:@"FEV1"] doubleValue]];
}


@end

