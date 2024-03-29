#import "_CPTPlainWhiteTheme.h"

#import "CPTBorderedLayer.h"
#import "CPTColor.h"
#import "CPTFill.h"
#import "CPTMutableLineStyle.h"
#import "CPTMutableTextStyle.h"
#import "CPTPlotAreaFrame.h"
#import "CPTUtilities.h"
#import "CPTXYAxis.h"
#import "CPTXYAxisSet.h"
#import "CPTXYGraph.h"

NSString *const kCPTPlainWhiteTheme = @"Plain White";

/**
 *  @brief Creates a CPTXYGraph instance formatted with white backgrounds and black lines.
 **/
@implementation _CPTPlainWhiteTheme

+(void)load
{
    [self registerTheme:self];
}

+(NSString *)name
{
    return kCPTPlainWhiteTheme;
}

#pragma mark -

-(void)applyThemeToBackground:(CPTGraph *)graph
{
        //graph.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    graph.fill = [CPTFill fillWithColor:[CPTColor clearColor]];
}

-(void)applyThemeToPlotArea:(CPTPlotAreaFrame *)plotAreaFrame
{
        //graph.fill = [CPTFill fillWithColor:[CPTColor whiteColor]];
    plotAreaFrame.fill = [CPTFill fillWithColor:[CPTColor clearColor]];

    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor blackColor];
    borderLineStyle.lineWidth = CPTFloat(1.0);

    plotAreaFrame.borderLineStyle = borderLineStyle;
    plotAreaFrame.cornerRadius    = CPTFloat(0.0);
}

-(void)applyThemeToAxisSet:(CPTAxisSet *)axisSet
{
    CPTXYAxisSet *xyAxisSet             = (CPTXYAxisSet *)axisSet;
    CPTMutableLineStyle *majorLineStyle = [CPTMutableLineStyle lineStyle];

    majorLineStyle.lineCap   = kCGLineCapButt;
    majorLineStyle.lineColor = [CPTColor colorWithGenericGray:CPTFloat(0.5)];
    majorLineStyle.lineWidth = CPTFloat(1.0);

    CPTMutableLineStyle *minorLineStyle = [CPTMutableLineStyle lineStyle];
    minorLineStyle.lineCap   = kCGLineCapButt;
    minorLineStyle.lineColor = [CPTColor blackColor];
    minorLineStyle.lineWidth = CPTFloat(1.0);

    CPTXYAxis *x                        = xyAxisSet.xAxis;
    CPTMutableTextStyle *blackTextStyle = [[CPTMutableTextStyle alloc] init];
    blackTextStyle.color    = [CPTColor blackColor];
    blackTextStyle.fontSize = CPTFloat(14.0);
    CPTMutableTextStyle *minorTickBlackTextStyle = [[CPTMutableTextStyle alloc] init];
    minorTickBlackTextStyle.color    = [CPTColor blackColor];
    minorTickBlackTextStyle.fontSize = CPTFloat(12.0);
    x.labelingPolicy                 = CPTAxisLabelingPolicyFixedInterval;
    x.majorIntervalLength            = CPTDecimalFromDouble(0.5);
    x.orthogonalCoordinateDecimal    = CPTDecimalFromDouble(0.0);
    x.tickDirection                  = CPTSignNone;
    x.minorTicksPerInterval          = 4;
    x.majorTickLineStyle             = majorLineStyle;
    x.minorTickLineStyle             = minorLineStyle;
    x.axisLineStyle                  = majorLineStyle;
    x.majorTickLength                = CPTFloat(7.0);
    x.minorTickLength                = CPTFloat(5.0);
    x.labelTextStyle                 = blackTextStyle;
    x.minorTickLabelTextStyle        = blackTextStyle;
    x.titleTextStyle                 = blackTextStyle;

    CPTXYAxis *y = xyAxisSet.yAxis;
    y.labelingPolicy              = CPTAxisLabelingPolicyFixedInterval;
    y.majorIntervalLength         = CPTDecimalFromDouble(0.5);
    y.minorTicksPerInterval       = 4;
    y.orthogonalCoordinateDecimal = CPTDecimalFromDouble(0.0);
    y.tickDirection               = CPTSignNone;
    y.majorTickLineStyle          = majorLineStyle;
    y.minorTickLineStyle          = minorLineStyle;
    y.axisLineStyle               = majorLineStyle;
    y.majorTickLength             = CPTFloat(7.0);
    y.minorTickLength             = CPTFloat(5.0);
    y.labelTextStyle              = blackTextStyle;
    y.minorTickLabelTextStyle     = minorTickBlackTextStyle;
    y.titleTextStyle              = blackTextStyle;
}

#pragma mark -
#pragma mark NSCoding Methods

-(Class)classForCoder
{
    return [CPTTheme class];
}

@end
