//
//  CKHttpClient.m
//  MedCaseHttpTest
//
//  Created by Apple on 15/4/9.
//  Copyright (c) 2015年 iHefe. All rights reserved.
//

#import "CKHttpClient.h"

@implementation CKHttpClient

static CKHttpClient* client = nil;

+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        client = [[CKHttpClient alloc] initWithBaseURL:[NSURL URLWithString:ServerURL]];
        AFJSONRequestSerializer *jsonSerializer = [[AFJSONRequestSerializer alloc] init];
        client.requestSerializer = jsonSerializer;
    });
    return client;
}
@end
