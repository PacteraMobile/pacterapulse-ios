//  Copyright (c) 2015 Pactera. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// THIS CODE IS PROVIDED *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS
// OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION
// ANY IMPLIED WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A
// PARTICULAR PURPOSE, MERCHANTABILITY OR NON-INFRINGEMENT.
//
// See the Apache License, Version 2.0 for the specific language
// governing permissions and limitations under the License.
//
#import "PPLColoredBarChart.h"
#import "PPLSummaryGenerals.h"
#import "PPLUtils.h"

@interface PPLColoredBarChart ()

@end

@implementation PPLColoredBarChart

- (id)init
{
    if ((self = [super init]))
    {
        self.section = kBarPlots;
        // self.title = sBarchartTitle;
    }
    return self;
}

- (void)renderInGraphHostingView:(CPTGraphHostingView *)layerHostingView
                       withTheme:(CPTTheme *)theme
                        animated:(BOOL)animated
{
    CGRect bounds = layerHostingView.bounds;
    CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:bounds];
    [self addGraph:graph toHostingView:layerHostingView];
    [self applyTheme:theme
             toGraph:graph
         withDefault:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];

    graph.plotAreaFrame.paddingLeft += 0.0;
    graph.plotAreaFrame.paddingTop += 10.0;
    graph.plotAreaFrame.paddingRight += 10.0;
    graph.plotAreaFrame.paddingBottom += 35.0;
    graph.plotAreaFrame.masksToBorder = YES;
    graph.plotAreaFrame.borderLineStyle = nil;

    // Create axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x = axisSet.xAxis;
    {
        x.majorIntervalLength = [NSNumber numberWithInt:10];
        x.minorTicksPerInterval = 9;
        x.majorGridLineStyle = nil;
        x.minorGridLineStyle = nil;
        x.axisLineStyle = nil;
        x.majorTickLineStyle = nil;
        x.minorTickLineStyle = nil;
        x.labelFormatter = nil;
        x.labelOffset = 5.0;
        x.labelingPolicy = CPTAxisLabelingPolicyNone;
        NSArray *subjectsArray = [self getSubjectTitlesAsArray];
        [x setAxisLabels:[NSSet setWithArray:subjectsArray]];

        CPTMutableTextStyle *textStyle = [self getGeneralTextStyle];
        [x setLabelTextStyle:textStyle];
        subjectsArray = nil;
    }

    CPTXYAxis *y = axisSet.yAxis;
    {
        y.majorIntervalLength = [NSNumber numberWithInt:1];
        y.minorTicksPerInterval = 9;
        y.axisConstraints = [CPTConstraints constraintWithLowerOffset:0.0];
        y.preferredNumberOfMajorTicks = 2;
        y.majorGridLineStyle = nil;
        y.minorGridLineStyle = nil;
        y.axisLineStyle = nil;
        y.majorTickLineStyle = nil;
        y.minorTickLineStyle = nil;
        y.labelOffset = 5.0;
        [y setLabelingPolicy:CPTAxisLabelingPolicyNone];
    }

    // Create a bar line style
    CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
    barLineStyle.lineWidth = 1.0;
    barLineStyle.lineColor = [CPTColor whiteColor];

    // Create bar plot
    CPTBarPlot *barPlot = [[CPTBarPlot alloc] init];
    barPlot.lineStyle = barLineStyle;
    barPlot.barWidth =
        [NSNumber numberWithFloat:1.0f]; // bar is 75% of the available space
    barPlot.barCornerRadius = 4.0;
    barPlot.barsAreHorizontal = NO;
    barPlot.dataSource = self;
    barPlot.identifier = @"Bar Plot 1";

    [graph addPlot:barPlot];

    // Plot space
    CPTMutablePlotRange *barRange =
        [[barPlot plotRangeEnclosingBars] mutableCopy];
    [barRange expandRangeByFactor:[NSNumber numberWithInt:1]];

    CPTXYPlotSpace *barPlotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    barPlotSpace.xRange = [CPTPlotRange
        plotRangeWithLocation:[NSNumber numberWithFloat:0.0f]
                       length:[NSNumber numberWithUnsignedInteger:
                                            [self numberOfRecordsForPlot:nil]]];
    ;
    NSInteger yRange = iMaxPercent + iLabelSpace;

    barPlotSpace.yRange =
        [CPTPlotRange plotRangeWithLocation:[NSNumber numberWithFloat:0.0f]
                                     length:[NSNumber numberWithLong:yRange]];
}

- (CPTColor *)getColorFromIndex:(NSInteger)index
{
    CPTColor *color = nil;
    switch (index)
    {
    case 0:
        color = [CPTColor cyanColor];
        break;
    case kHappy + 1: // 0 base to 1 base
        color = [CPTColor colorWithComponentRed:253.0 / 255.0
                                          green:239.0 / 255.0
                                           blue:200.0 / 255.0
                                          alpha:1.0];
        break;
    case kSoso + 1:
        color = [CPTColor colorWithComponentRed:220.0 / 255.0
                                          green:215.0 / 255.0
                                           blue:255.0 / 255.0
                                          alpha:1.0];
        break;
    case kUnHappy + 1:
        color = [CPTColor colorWithComponentRed:198.0 / 255.0
                                          green:241.0 / 255.0
                                           blue:255.0 / 255.0
                                          alpha:1.0];
        break;
    case 4:
        color = [CPTColor purpleColor];
        break;
    default:
        color = [CPTColor cyanColor];
        break;
    }
    return color;
}

- (NSString *)createSubTitleForIndex:(NSInteger)index
{
    NSString *titleForEmotions = @"";
    NSInteger indexOfEmotion =
        [[(NSMutableDictionary *)[self.summaryData objectAtIndex:index]
            objectForKey:kEmotion] integerValue];
    switch (indexOfEmotion)
    {
    case kHappy:
        titleForEmotions = sBarchartSubtitleHappy;
        break;
    case kSoso:
        titleForEmotions = sBarchartSubtileSoso;
        break;
    case kUnHappy:
        titleForEmotions = sBarchartSubtitleUnhappy;
        break;
    default:
        break;
    }
    return titleForEmotions;
}

- (NSArray *)getSubjectTitlesAsArray
{
    NSMutableArray *labelArray = [[NSMutableArray alloc] init];
    CPTMutableTextStyle *textStyle = [self getGeneralTextStyle];
    for (int i = 0; i < [self.summaryData count]; i++)
    {
        NSString *titleForEmotions = [self createSubTitleForIndex:i];
        // Leave this for later extenstion
        //[textStyle setColor:[self getColorFromIndex:(i+1)]];
        CPTAxisLabel *axisLabel =
            [[CPTAxisLabel alloc] initWithText:titleForEmotions
                                     textStyle:textStyle];
        [axisLabel setTickLocation:[NSNumber numberWithInt:i + 1]];
        [axisLabel setRotation:M_PI_4];
        [axisLabel setOffset:0.1];
        [labelArray addObject:axisLabel];
    }
    textStyle = nil;
    return [labelArray copy];
}

- (CPTMutableTextStyle *)getGeneralTextStyle
{
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontSize = 25.0f;
    textStyle.fontName = @"Helvetica Bold";
    textStyle.color = [CPTColor blackColor];
    return textStyle;
}

#pragma mark -
#pragma mark Plot Data Source Methods

- (NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if (self.summaryData.count > iMinColumnInBarchart)
    {
        return self.summaryData.count + 1;
    }
    else
    {
        return iMinColumnInBarchart + 1;
    }
}

- (id)numberForPlot:(CPTPlot *)plot
              field:(NSUInteger)fieldEnum
        recordIndex:(NSUInteger)index
{
    id num = nil;
    if (fieldEnum == CPTBarPlotFieldBarLocation)
    {
        // location
        num = @(index * 1); // space between each bar
    }
    else if (fieldEnum == CPTBarPlotFieldBarTip)
    {
        // column 0 may be hidden, so we start from column 1, but our index is
        // still from 0, so add 1 here , and minus 1 in the index later
        if (index != 0 && index < [self.summaryData count] + 1)
        {
            num = [(NSMutableDictionary *)[self.summaryData
                objectAtIndex:index - 1] objectForKey:kEmotionValue];
        }
        else
        {
            num = 0;
        }
    }
    else
    {
        num = @(index);
    }
    return num;
}

- (CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot
                   recordIndex:(NSUInteger)index
{
    // Need to convert from index to different emotion, which mean each emotion
    // should alwayse use the same color
    // index is surpassing 1, so decrease firstly and increase later
    if (index > 0 && index <= [self.summaryData count])
    {
        NSUInteger colorIndex = [[[self.summaryData objectAtIndex:index - 1]
                                    objectForKey:kEmotion] integerValue] +
                                1;
        CPTColor *color = [self getColorFromIndex:colorIndex];
        return [CPTFill fillWithColor:color];
        // Leave this for later extenstion
        // CPTGradient *fillGradient = [CPTGradient
        // gradientWithBeginningColor:color endingColor:[CPTColor blackColor]];
        // return [CPTFill fillWithGradient:fillGradient];
    }
    else
    {
        return [CPTFill fillWithColor:[CPTColor cyanColor]];
    }
}

- (CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    CPTTextLayer *textLayer = nil;
    // column 0 may be hidden, so we start from column 1, but our index is still
    // from 0, so add 1 here , and minus 1 in the index later
    if (index != 0 && index < [self.summaryData count] + 1)
    {
        textLayer = [[CPTTextLayer alloc]
            initWithText:[NSString
                             stringWithFormat:
                                 @"%0.2f%%",
                                 [[(NSDictionary *)[self.summaryData
                                     objectAtIndex:index - 1]
                                     objectForKey:kEmotionValue] floatValue]]];
    }
    return textLayer;
}

@end
