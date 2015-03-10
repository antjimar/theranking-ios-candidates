//
//  PictureEntity+Parser.m
//  theranking-ios-candidates
//
//  Created by ANTONIO JIMÉNEZ MARTÍNEZ on 10/3/15.
//  Copyright (c) 2015 antjimar. All rights reserved.
//

#import "PictureEntity+Builder.h"

@implementation PictureEntity (Builder)

+ (NSDictionary *)dictionaryFromData:(NSData *)data {
    NSError *error;
    NSDictionary *pictureDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    return pictureDict;
}

@end
