//
//  Manager.h
//  AiMianDan
//
//  Created by li on 14-7-2.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface Manager : NSObject
{
    
}
@property (nonatomic,strong) NSString *city;



//===改字符串格式时间为时间戳=============
+(long)changeTimeToTimeSp:(NSString *)timeStr;

+(void)getLocationlat:(CGFloat)lat andlng:(CGFloat)lng;
//统一弹框
+ (void)textNoSpace:(NSString *)string;
//判断字符串是否为空
+(BOOL) isBlankString:(NSString *)string;

//
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;
//解析网络数据,转化为Model
+ (id)dataAnalysisDictionary:(NSString *)modelClass andDictionry:(NSDictionary *)dic;

+ (NSMutableArray *)dataAnalysisArray:(NSString *)modelClass andArray:(NSArray *)array;
//随机生成字符串
+(NSString *)randString;
//===================获取webview高度
+(int)webHeight:(UIWebView*)webView;
//===================获取图片主色调
+(UIColor*)mostColor:(NSString *)strImage;
//======空字符串转化
+(NSString*)convertNull:(id)object;
//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email;
@end
