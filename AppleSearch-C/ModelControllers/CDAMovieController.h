//
//  CDAMovieController.h
//  AppleSearch-C
//
//  Created by Chris Anderson on 12/6/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDAMovie.h"
@class UIImage;

NS_ASSUME_NONNULL_BEGIN

@interface CDAMovieController : NSObject

+ (void) fetchMoviesWithSearchText: (NSString *)searchText completion: (void (^) (NSArray<CDAMovie *> * _Nullable))completion;

+ (void) fetchImageForMovie: (CDAMovie *)movie completion: (void (^)(UIImage * _Nullable))completion;

@end

NS_ASSUME_NONNULL_END
