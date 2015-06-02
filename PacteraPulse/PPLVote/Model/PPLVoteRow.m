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

#import "PPLVoteRow.h"

@implementation PPLVoteRow
/**
 *  Initilization for this object with Image and tag(which would be the value
 *sent to server)
 *
 *  @param image Image to display on the row
 *  @param tag   Tag or value related to this image which would be sent to
 *server
 *
 */
- (id)initWithImage:(UIImage *)image Tag:(NSInteger)tag
{
    self = [super init];
    if (self)
    {
        _rowImage = image;
        _imageTag = tag;
    }
    return self;
}

/**
 *  Class level function which initializes all the objects and return in an
 *Array
 *
 *  @return return the created array with images and values
 */
+ (NSArray *)initObjects
{
    NSArray *imageNames =
        [[NSArray alloc] initWithObjects:@"unhappy", @"neutral", @"happy", nil];
    NSMutableArray *returnArray = [[NSMutableArray alloc] init];
    NSInteger tagCounter = imageNames.count - 1;
    for (NSString *item in imageNames)
    {
        [returnArray addObject:[[PPLVoteRow alloc]
                                   initWithImage:[UIImage imageNamed:item]
                                             Tag:tagCounter--]];
    }
    return returnArray;
}

@end
