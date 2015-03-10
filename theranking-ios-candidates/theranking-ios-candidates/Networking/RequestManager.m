//
//  RequestManager.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "RequestManager.h"

@implementation RequestManager

@synthesize baseDomain = _baseDomain;
@synthesize defaultParams = _defaultParams;

#pragma mark - RequestManagerProtocol Methods
- (void)GET:(NSString *)endpoint parameters:(NSDictionary *)parameters completion:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock {
    NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfiguration.HTTPAdditionalHeaders = parameters;
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfiguration];
    NSURL *url = [NSURL URLWithString:endpoint];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"GET";
    
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)request;
        if (!error) {
            if (HTTPResponse.statusCode == 200) {
                successBlock(data);
            } else {
                errorBlock(data, error);
            }
        } else {
            errorBlock(nil, error);
        }
    }];
    [task resume];
}

@end
