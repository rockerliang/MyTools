//
//  BEToolsSinglton.m
//  IHFMedicImageNew
//
//  Created by ihefe26 on 15/7/30.
//  Copyright (c) 2015年 ihefe－hlh. All rights reserved.
//

#import "BEToolsSinglton.h"

@implementation BEToolsSinglton
static BEToolsSinglton *betools = nil;

+ (instancetype)getInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        betools = [[BEToolsSinglton alloc] init];
        
    });
    return betools;
}
-(id)init {
    
    if (self = [super init]) {
        // init code
    }
    return self;
}


+ (instancetype)alloc
{
    if (betools) {
        return betools;
    }
    return [super alloc];
}

- (id)copy
{
    if (betools) {
        return betools;
    }
    return [super copy];
}


#pragma -mark 获取当前时间
-(NSString *)getNowDate
{
    NSDate *nowDate = [NSDate date];
    NSDateFormatter *fromatter = [[NSDateFormatter alloc] init];
    [fromatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *nowDateStr = [fromatter stringFromDate:nowDate];
    return nowDateStr;
}

#pragma -mark 判断路径是否存在某文件
- (BOOL)isExistsForTargetFile:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isFilePath = [fileManager fileExistsAtPath:filePath];
    if (!isFilePath) {
        NSLog(@"文件不存在");
        return NO;
    }
    else
    {
        return YES;
    }
}

#pragma -mark 获取到沙盒路径
-(NSString *)getCaches
{
    NSArray *cache = NSSearchPathForDirectoriesInDomains(NSCachesDirectory,
                                                         NSUserDomainMask,
                                                         YES);    
    NSString *cachePath = [cache objectAtIndex:0];
    return cachePath;

}

#pragma -mark  删除
-(BOOL)deleteFilaByFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL delete = [fileManager removeItemAtPath:filePath error:nil];
    if(delete)
    {
        NSLog(@"删除成功！");
        return YES;
    }
    return NO;
}

#pragma -mark 截图
-(UIImage *)capImageByView:(UIView *)capView
{
    CGRect rect = [capView bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [capView.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *imageViewData = UIImagePNGRepresentation(img);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *imageName = @"capImage.png";
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSLog(@"%@", savedImagePath);
    [imageViewData writeToFile:savedImagePath atomically:YES];
    return img;
}


#pragma -mark http网络请求
-(void)HtttpGet:(NSString *)url andCondition1:(NSString *)str1 andCondition1:(NSString *)str2
{
    NSDictionary *param = @{@"Condition1": str1};
    NSDictionary *param1 = @{@"str2": @(1)};
    NSString *jsonStr = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:param options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    NSString *jsonStr1 = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:param1 options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    [HttpClient GET:url parameters:@{@"where" : jsonStr,@"projection" : jsonStr1} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

//发送图片，通过_id关联
-(void)postImage:(UIImage *)image
{
    [HttpClient POST:@"http://192.168.10.108:5000/images" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *dataImage = UIImagePNGRepresentation(image);
        [formData appendPartWithFileData:dataImage name:@"images" fileName:@"image" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *imageId = responseObject[@"_id"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error:%@",error);
    }];

}


-(NSString *)imageChangeToData:(UIImage *)image
{
//    //NSData转换为UIImage
//    NSData *imageData = [NSData dataWithContentsOfFile: imagePath];
//    UIImage *image = [UIImage imageWithData: imageData];
   
    //UIImage转换为NSData
    NSData *imageData = UIImagePNGRepresentation(image);
    //data转String
    NSString *imgStr = [[NSString alloc] initWithData:imageData encoding:NSUTF8StringEncoding];
    //string转Data
    NSData* xmlData = [@"testdata" dataUsingEncoding:NSUTF8StringEncoding];
    return  imgStr;
}


#pragma -mark 网络连接
-(NSString *)canConnectNet
{
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            return @"没有链接到网络";
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            return @"使用3G网络";
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            return @"使用WiFi网络";
            break;
    }
}

@end
