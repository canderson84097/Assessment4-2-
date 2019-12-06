//
//  CDAMovie.h
//  AppleSearch-C
//
//  Created by Chris Anderson on 12/6/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CDAMovie : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) double vote_average;
@property (nonatomic, readonly, copy) NSString *overView;
@property (nonatomic, readonly, copy) NSString *posterPath;

- (instancetype) initWithTitle: (NSString *)title vote_average: (double)voteAverage overView: (NSString *)overView posterPath: (NSString *)posterPath;

@end

@interface CDAMovie (JSONConvertable)

- (instancetype) initWithDictionary: (NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END
