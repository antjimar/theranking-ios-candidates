//
//  RequestManager.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "NetworkFetcher.h"

@implementation NetworkFetcher

@synthesize baseDomain = _baseDomain;
@synthesize defaultParams = _defaultParams;

#pragma mark - RequestManagerProtocol Methods
- (void)GET:(NSString *)stringURL parameters:(NSDictionary *)parameters completion:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:stringURL];
    url = [self NSURL:url byAppendingQueryParameters:parameters];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
        if (!error) {
            if (HTTPResponse.statusCode == 200) {
                successBlock(data);
            } else {
                errorBlock(data, error);
            }
        } else {
            errorBlock(nil, error);
        }
        
        [session finishTasksAndInvalidate];
    }];
    [task resume];
}

#pragma mark - private Methods
- (NSURL *)NSURL:(NSURL *) URL byAppendingQueryParameters:(NSDictionary *)parameters {
    NSString* URLString = [NSString stringWithFormat:@"%@?%@", [URL absoluteString], [self stringFromQueryParameters:parameters]];
    return [NSURL URLWithString:URLString];
}
- (NSString *)stringFromQueryParameters:(NSDictionary *) queryParameters {
    NSMutableArray* parts = [NSMutableArray array];
    [queryParameters enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
        NSString *part = [NSString stringWithFormat: @"%@=%@",
                          [key stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding],
                          [value stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]
                          ];
        [parts addObject:part];
    }];
    return [parts componentsJoinedByString: @"&"];
}

@end
