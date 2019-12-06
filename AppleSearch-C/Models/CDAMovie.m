//
//  CDAMovie.m
//  AppleSearch-C
//
//  Created by Chris Anderson on 12/6/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

#import "CDAMovie.h"

static NSString *const titleKey = @"title";
static NSString *const posterPathKey = @"poster_path";
static NSString *const overViewKey = @"overview";

@implementation CDAMovie

- (instancetype)initWithTitle:(NSString *)title vote_average:(double)vote_average overView:(NSString *)overView posterPath:(NSString *)posterPath
{
    self = [super init];
    if (self)
    {
        _title = title;
        _vote_average = vote_average;
        _posterPath = posterPath;
        _overView = overView;
    }
    return self;
}

@end

@implementation CDAMovie (JSONConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *title = dictionary[titleKey];
    NSString *posterPath = dictionary[posterPathKey];
    NSString *overView = dictionary[overViewKey];
    double vote_average = [dictionary[@"vote_average"] doubleValue];
    
    return [self initWithTitle:title vote_average:vote_average overView:overView posterPath:posterPath];
}

@end
