//
//  RequestManager.h
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^SuccessBlock)(id data);
typedef void (^ErrorBlock)(id data, NSError *error);

@protocol RequestManager <NSObject>

@property (copy, nonatomic) NSString *baseDomain;
@property (copy, nonatomic) NSDictionary *defaultParams;

- (void)GET:(NSString *)endpoint parameters:(NSDictionary *)parameters completion:(SuccessBlock)successBlock error:(ErrorBlock)errorBlock;

@end
