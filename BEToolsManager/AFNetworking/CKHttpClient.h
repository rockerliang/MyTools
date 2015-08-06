//
//  CKHttpClient.h
//  MedCaseHttpTest
//
//  Created by Apple on 15/4/9.
//  Copyright (c) 2015年 iHefe. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

#define ServerURL @"http://192.168.10.20:5000/report/"
#define HttpClient [CKHttpClient getInstance]

@interface CKHttpClient : AFHTTPRequestOperationManager
+ (instancetype)getInstance;
@end
