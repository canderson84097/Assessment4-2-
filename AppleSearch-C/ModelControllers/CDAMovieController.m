//
//  CDAMovieController.m
//  AppleSearch-C
//
//  Created by Chris Anderson on 12/6/19.
//  Copyright © 2019 Renaissance Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDAMovieController.h"
#import "CDAMovie.h"

static NSString *const baseURLString = @"http://api.themoviedb.org/3/search";
static NSString *const movieComponent = @"movie";
static NSString *const apiKeyQueryKey = @"api_key";
static NSString *const apiKey = @"7a3c3c6e0fa5f811b2d2c0453c97522b";
static NSString *const baseImageURLString = @"http://image.tmdb.org/t/p/w500/";

@implementation CDAMovieController

+ (void)fetchMoviesWithSearchText:(NSString *)searchText completion:(void (^)(NSArray<CDAMovie *> * _Nullable))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSURL *movieURL = [baseURL URLByAppendingPathComponent:movieComponent];
    
    NSMutableArray<NSURLQueryItem *> *queryItems = [NSMutableArray new];
    
    NSURLQueryItem *apiKeyQuery = [NSURLQueryItem queryItemWithName:apiKeyQueryKey value:apiKey];
    NSURLQueryItem *movieQuery = [NSURLQueryItem queryItemWithName:@"query" value:searchText];
    
    [queryItems addObject:apiKeyQuery];
    [queryItems addObject:movieQuery];
    
    NSURLComponents *urlComponents = [[NSURLComponents alloc]initWithURL:movieURL resolvingAgainstBaseURL:true];
    
    [urlComponents setQueryItems:queryItems];
    
    NSURL *finalURL = [urlComponents URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            completion(nil);
            return;
        }
        
        if (response)
        {
            NSLog(@"%@", response);
        }
        
        if (!data)
        {
            NSLog(@"Problem fetching data! %@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        if (data)
        {
            NSDictionary *topLevel = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *resultsDict = topLevel[@"results"];
            NSMutableArray *movies = [NSMutableArray new];
            
            for (NSDictionary *movieDict in resultsDict)
            {
                CDAMovie *movie = [[CDAMovie alloc]initWithDictionary:movieDict];
                [movies addObject:movie];
            }
            completion(movies);
        }
    }] resume];
}

+ (void)fetchImageForMovie:(CDAMovie *)movie completion:(void (^)(UIImage * _Nullable))completion
{
    NSURL *baseImageURL = [NSURL URLWithString:baseImageURLString];
    NSURL *finalImageURL = [baseImageURL URLByAppendingPathComponent:movie.posterPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalImageURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (error)
        {
            NSLog(@"Error\nIn %s: %@\n---\n%@", __PRETTY_FUNCTION__, error.localizedDescription, error);
            return completion(nil);
        }
        
        if (response)
        {
            NSLog(@"Response: %@", response);
        }
        
        if (!data)
        {
            NSLog(@"Error passing the JSON for image: %@", error.localizedDescription);
            return completion(nil);
        }
        
        UIImage *image = [[UIImage alloc]initWithData: data];
        
        completion(image);
    }] resume];
}
@end
