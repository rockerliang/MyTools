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


//正则判断手机号码格式
- (BOOL)validatePhone:(NSString *)phone
{
    /**
             * 手机号码
             * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
             * 联通：130,131,132,152,155,156,185,186
             * 电信：133,1349,153,180,189
             */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
             10         * 中国移动：China Mobile
             11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
             12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
             15         * 中国联通：China Unicom
             16         * 130,131,132,152,155,156,185,186
             17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
             20         * 中国电信：China Telecom
             21         * 133,1349,153,180,189
             22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
             25         * 大陆地区固话及小灵通
             26         * 区号：010,020,021,022,023,024,025,027,028,029
             27         * 号码：七位或八位
             28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phone] == YES)
        || ([regextestcm evaluateWithObject:phone] == YES)
        || ([regextestct evaluateWithObject:phone] == YES)
        || ([regextestcu evaluateWithObject:phone] == YES))
    {
        if([regextestcm evaluateWithObject:phone] == YES) {
            NSLog(@"China Mobile");
        } else if([regextestct evaluateWithObject:phone] == YES) {
            NSLog(@"China Telecom");
        } else if ([regextestcu evaluateWithObject:phone] == YES) {
            NSLog(@"China Unicom");
        } else {
            NSLog(@"Unknow");
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
}


-(NSString *)stringValue:(NSString *)value
{
    if ([value isKindOfClass:[NSNull class]]|| value == nil) {
        return  @"null";
    }else if ([value isKindOfClass:[NSNumber class]]) {
        return  [NSString stringWithFormat:@"%@",[value description]];
    }else if([value isKindOfClass:[NSString class]]){
        return (NSString *)value;
    }else{
        return @"null";
    }
    return @"null";
}



@end
