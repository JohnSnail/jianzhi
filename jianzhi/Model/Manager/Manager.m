//
//  Manager.m
//  AiMianDan
//
//  Created by li on 14-7-2.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "Manager.h"
#import <objc/runtime.h>
@implementation Manager
@synthesize city;
//===改字符串格式时间为时间戳=============
+(long)changeTimeToTimeSp:(NSString *)timeStr{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}
+(void)getLocationlat:(CGFloat)lat andlng:(CGFloat)lng
{
    CLLocation *mycurLocaton=[[CLLocation alloc]initWithLatitude:lat longitude:lng];
    CLGeocoder *geocoder =[[CLGeocoder alloc]init];
    [geocoder reverseGeocodeLocation:mycurLocaton completionHandler:^(NSArray *placemarks,NSError *error){
        for (CLPlacemark * placemark in placemarks) {
            NSString *test = nil;
            if ([placemark locality]) {
                test = [placemark locality];
            }else{
                test = [placemark administrativeArea];
            }
            TLog(@"%@",test);
            if ([[test substringFromIndex:(test.length-1)] isEqualToString:@"省"] || [[test substringFromIndex:(test.length-1)] isEqualToString:@"市"]) {
                [ClassModel LMAppModel].city=[NSString stringWithFormat:@"%@",[test substringToIndex:(test.length-1)]];
            }else{
                [ClassModel LMAppModel].city=test;
                
            }
//            [GlobalClass storeUserData];
//            [LM_USER_DEFAULT synchronize];
            break;
        }
    }];
}
//统一弹框
+ (void)textNoSpace:(NSString *)string
{
    UIAlertView *alert = nil;
    if (string) {
        alert = kYX_ALERT_VIEW(@"提示", string, nil, @"确定", nil);
    }else{
        alert = kYX_ALERT_VIEW(@"提示", @"数据有误", nil, @"确定", nil);
    }
    [alert show];
}
//判断字符串是否为空
+(BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    if ([string isEqualToString:@"(null)"]) {
        return YES;
    }
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    return NO;
}
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary{
    NSArray *keys = [dictionary allKeys];
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"{"];
    NSMutableArray *keyValues = [NSMutableArray array];
    for (int i=0; i<[keys count]; i++) {
        NSString *name = [keys objectAtIndex:i];
        id valueObj = [dictionary objectForKey:name];
        NSString *value = [Manager jsonStringWithObject:valueObj];
        
        if (value) {
            [keyValues addObject:[NSString stringWithFormat:@"\"%@\":%@",name,value]];
        }
    }
    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","]];
    [reString appendString:@"}"];
    return reString;
}
+(NSString *) jsonStringWithString:(NSString *) string{
    return [NSString stringWithFormat:@"\"%@\"",
            [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""]
            ];
}
+(NSString *) jsonStringWithArray:(NSArray *)array{
    NSMutableString *reString = [NSMutableString string];
    [reString appendString:@"["];
    NSMutableArray *values = [NSMutableArray array];
    for (id valueObj in array) {
        NSString *value = [Manager jsonStringWithObject:valueObj];
        if (value) {
            [values addObject:[NSString stringWithFormat:@"%@",value]];
        }
    }
    [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
    [reString appendString:@"]"];
    return reString;
}
+(NSString *) jsonStringWithObject:(id) object{
    NSString *value = nil;
    if (!object) {
        return value;
    }
    if ([object isKindOfClass:[NSString class]]) {
        value = [Manager jsonStringWithString:object];
    }else if([object isKindOfClass:[NSDictionary class]]){
        value = [Manager jsonStringWithDictionary:object];
    }else if([object isKindOfClass:[NSArray class]]){
        value = [Manager jsonStringWithArray:object];
    }
    return value;
}
//随机生成字符串
+(NSString *)randString
{
    int NUMBER_OF_CHARS = 16;
    char data[NUMBER_OF_CHARS];
    for (int x=0;x<16;data[x++] = (char)('A' + (arc4random_uniform(26))));
    NSString *dataPoint = [[NSString alloc] initWithBytes:data length:NUMBER_OF_CHARS encoding:NSUTF8StringEncoding];
    return dataPoint;
}
+ (id)dataAnalysisDictionary:(NSString *)modelClass andDictionry:(NSDictionary *)dic
{
    //由于objc_getClass()函数的参数类型是const char *类型的，故在这里要转化一下；
    const char *cComplexClassName = [modelClass UTF8String];
    
    //将传过来的字符串转化为一个类对象
    id theComplexClass = objc_getClass(cComplexClassName);
    
    //用来存放一个类中有几个成员变量。
    unsigned int outCount = 0;
    
    //这句话执行之后outCount的值就会是当前类中属性的个数。整体返回的是一个指针数组，里面包含对应类的各个属性信息。
    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
    
    
    //创建一个传过来字符串（类名）相应的对象
    id model = [[NSClassFromString(modelClass) alloc] init];
    
    //判断类中的每一个属性
    for (int j = 0; j < outCount; j++)
    {
        //获取类中的第j个成员变量信息
        objc_property_t property = properties[j];
        
        //获取类中的第j个成员变量将其转化为字符串
        NSString *propertyNameString =[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        //把第一个字母变成大写
        NSString *firstStr = [propertyNameString substringToIndex:1];
        NSString *propertyNameString1 = [propertyNameString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstStr uppercaseString]];
        
        //为每个成员变量设置一个set函数相关的字符串。
        NSString * setProperty = [NSString stringWithFormat:@"%@%@:",@"set",propertyNameString1];
        
        //把字符串转换为一个函数
        SEL setSelector = NSSelectorFromString(setProperty);
        
        //获得json串中的键对应的值
        id object = [dic objectForKey:propertyNameString];
        
        //判断上面取得的值是否存在，不存在就去转换下一个属性
        if(!object || [object isKindOfClass:[NSNull class]])
        {
            continue;
        }
        
        //为对应类的对象设置对应的属性
        [model performSelector:setSelector withObject:object];
    }
    
    return model;
}

+ (NSMutableArray *)dataAnalysisArray:(NSString *)modelClass andArray:(NSArray *)array
{
    //由于objc_getClass()函数的参数类型是const char *类型的，故在这里要转化一下；
    const char *cComplexClassName = [modelClass UTF8String];
    
    //将传过来的字符串转化为一个类对象
    id theComplexClass = objc_getClass(cComplexClassName);
    
    //用来存放一个类中有几个成员变量。
    unsigned int outCount = 0;
    
    //这句话执行之后outCount的值就会是当前类中属性的个数。整体返回的是一个指针数组，里面包含对应类的各个属性信息。
    objc_property_t *properties = class_copyPropertyList(theComplexClass, &outCount);
    
    //创建一个数组用来存放传过来数组中的字典转化成的对象；
    NSMutableArray * dataArr = [NSMutableArray arrayWithCapacity:1];
    
    for (int i = 0; i < [array count]; i++) {
        //取出数组中的一个对象
        id jsonDic = [array objectAtIndex:i];
        
        //若数组中的对象不是字典对象就跳过它。继续下一个。
        if(![jsonDic isKindOfClass:[NSDictionary class]])
        {
            continue;
        }
        
        //创建一个传过来字符串（类名）相应的对象
        id model = [[NSClassFromString(modelClass) alloc] init];
        
        //判断类中的每一个属性
        for (int j = 0; j < outCount; j++)
        {
            //获取类中的第j个成员变量信息
            objc_property_t property = properties[j];
            
            //获取类中的第j个成员变量将其转化为字符串
            NSString *propertyNameString =[NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            
            //把第一个字母变成大写
            NSString *firstStr = [propertyNameString substringToIndex:1];
            NSString *propertyNameString1 = [propertyNameString stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[firstStr uppercaseString]];
            
            //为每个成员变量设置一个set函数相关的字符串。
            NSString * setProperty = [NSString stringWithFormat:@"%@%@:",@"set",propertyNameString1];
            
            //把字符串转换为一个函数
            SEL setSelector = NSSelectorFromString(setProperty);
            
            //获得json串中的键对应的值
            id object = [jsonDic objectForKey:propertyNameString];
            
            //判断上面取得的值是否存在，不存在就去转换下一个属性
            if(!object || [object isKindOfClass:[NSNull class]])
            {
                continue;
            }
            
            //为对应类的对象设置对应的属性
            [model performSelector:setSelector withObject:object];
        }
        //把数组中对应的每个字典整体转化后加到一个数组中去。
        [dataArr addObject:model];
        
        //释放掉转化的对象。
    }
    return dataArr;
}
#pragma mari 获取webview高度
//===================获取webview高度
+(int)webHeight:(UIWebView*)webView
{
    int height=0;
    NSMutableArray *oldArray=[[NSMutableArray alloc] init];
    NSMutableArray *newArray=[[NSMutableArray alloc] init];
    NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.images.length"];
    TLog(@"输出str%@",title);
    for (int i=0; i<[title intValue]; i++) {
        NSString *imageH = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.images[%d].height",i]];
        TLog(@"输出内容大小3333%@",imageH);
        [oldArray addObject:imageH];
    }
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth;"
     "var maxwidth=340;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "myimg.width = maxwidth;"
     "myimg.height = myimg.height * (1);"
     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    for (int i=0; i<[title intValue]; i++) {
        NSString *imageH = [webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.images[%d].height",i]];
        TLog(@"输出内容大小22222%@",imageH);
        [newArray addObject:imageH];
    }
    
    for (int i=0; i<newArray.count; i++) {
        int height1 =[[oldArray objectAtIndex:i] intValue];
        int height2=[[newArray objectAtIndex:i] intValue];
        int height3=height1-height2;
        height+=height3;
    }
    if (newArray.count>=2) {
        height+=30;
    }
    return height;
}
#pragma mari 获取图片主色调
//===================获取图片主色调
+(UIColor*)mostColor:(NSString *)strImage{
    UIImage *image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strImage]]];
    //UIImage *uiImage=[UIImage imageNamed:@"abc.png"];
    CGImageRef cgRef=image.CGImage;
#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_6_1
    int bitmapInfo = kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast;
#else
    int bitmapInfo = kCGImageAlphaPremultipliedLast;
#endif
    
    //第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
    CGSize thumbSize=CGSizeMake(10, 100);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 thumbSize.width,
                                                 thumbSize.height,
                                                 8,//bits per component
                                                 thumbSize.width*4,
                                                 colorSpace,
                                                 bitmapInfo);
    
    CGRect drawRect = CGRectMake(0, 0, thumbSize.width, thumbSize.height);
    CGContextDrawImage(context, drawRect, cgRef);
    CGColorSpaceRelease(colorSpace);
    
    
    
    //第二步 取每个点的像素值
    unsigned char* data = CGBitmapContextGetData (context);
    
    if (data == NULL) return nil;
    
    NSCountedSet *cls=[NSCountedSet setWithCapacity:thumbSize.width*thumbSize.height];
    
    for (int x=0; x<thumbSize.width; x++) {
        for (int y=0; y<thumbSize.height; y++) {
            
            int offset = 4*(x*y);
            
            int red = data[offset];
            int green = data[offset+1];
            int blue = data[offset+2];
            int alpha =  data[offset+3];
            
            NSArray *clr=@[@(red),@(green),@(blue),@(alpha)];
            [cls addObject:clr];
            
        }
    }
    CGContextRelease(context);
    
    
    //第三步 找到出现次数最多的那个颜色
    NSEnumerator *enumerator = [cls objectEnumerator];
    NSArray *curColor = nil;
    
    NSArray *MaxColor=nil;
    NSUInteger MaxCount=0;
    
    while ( (curColor = [enumerator nextObject]) != nil )
    {
        NSUInteger tmpCount = [cls countForObject:curColor];
        
        if ( tmpCount < MaxCount ) continue;
        
        MaxCount=tmpCount;
        MaxColor=curColor;
        
    }
    
    return [UIColor colorWithRed:([MaxColor[0] intValue]/255.0f) green:([MaxColor[1] intValue]/255.0f) blue:([MaxColor[2] intValue]/255.0f) alpha:([MaxColor[3] intValue]/255.0f)];
}
#pragma mark将空字符串转化
//===将空字符串转化
+(NSString*)convertNull:(id)object{
    // 转换空串
    TLog(@"输出内容%@",object);
    if ([object isEqual:[NSNull null]]) {
        return @"";
    }
    else if ([object isKindOfClass:[NSNull class]])
    {
        return @"";
    }
    else if ([object isEqualToString:@"(null)"])
    {
        return @"";
    }
    else if (object==nil){
        return @"";
    }
    return object;
}
//利用正则表达式验证
+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
@end
