//
//  LocolData.m
//  ComboAF
//
//  Created by li on 14/11/21.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import "LocolData.h"
#import <Accelerate/Accelerate.h>
@implementation LocolData
//=====返回局详细信息cell============
+(NSArray *)locolBureauArray
{
    NSDictionary *dic1 = @{@"Cell": @"ImageCell",@"isAttached":@(NO)};
    NSDictionary *dic2 = @{@"Cell": @"PackageCell",@"isAttached":@(NO),@"flag":@(0)};
    NSDictionary *dic7 = @{@"Cell": @"PackageCell",@"isAttached":@(NO),@"flag":@(1)};
    NSDictionary *dic8 = @{@"Cell": @"PackageCell",@"isAttached":@(NO),@"flag":@(2)};
    NSDictionary *dic3 = @{@"Cell": @"CreaterCell",@"isAttached":@(NO)};
    NSDictionary *dic4 = @{@"Cell": @"PeopleCell",@"isAttached":@(NO)};
    NSDictionary *dic5 = @{@"Cell": @"DistributeCell",@"isAttached":@(NO)};
    NSDictionary *dic6 = @{@"Cell": @"IntroduceCell",@"isAttached":@(NO)};
    NSArray * array = @[dic1,dic2,dic7,dic8,dic3,dic4,dic5,dic6];
    return array;
}
+(NSArray *)locolCreatBureau
{
    NSDictionary *dic1 = @{@"Cell": @"ChPacageCell",@"isAttached":@(NO)};
    NSDictionary *dic2 = @{@"Cell": @"ChPacageCell",@"isAttached":@(NO)};
    NSDictionary *dic3 = @{@"Cell": @"ChPacageCell",@"isAttached":@(NO)};
    NSArray * array = @[dic1,dic2,dic3];
    return array;
}
//=====保存个人信息===========
+(void)getPersonDict:(NSDictionary*)dict
{
//    NSMutableArray *mutableArr=[Manager dataAnalysisDictionary:@"UserModel" andDictionry:dict];
//    UserModel *myModel=(UserModel *)mutableArr;
//    [UserModel LMUser].id=myModel.id;
//    [UserModel LMUser].mobile=myModel.mobile;
//    [UserModel LMUser].accountInfoId=myModel.accountInfoId;
//    [UserModel LMUser].nickName=myModel.nickName;
//    [UserModel LMUser].email=myModel.email;
//    [UserModel LMUser].gender=myModel.gender;
//    [UserModel LMUser].birthDate=myModel.birthDate;
//    [UserModel LMUser].introduce=myModel.introduce;
//    [UserModel LMUser].iconUrl=myModel.iconUrl;
//    [UserModel LMUser].name=myModel.name;
//    [GlobalClass storeUserData];
//    [LM_USER_DEFAULT synchronize];
}
+(void)personDetail:(NSDictionary*)dict
{
//    NSMutableArray *mutableArr=[Manager dataAnalysisDictionary:@"UserModel" andDictionry:dict];
//    UserModel *myModel=(UserModel *)mutableArr;
//    //[UserModel LMUser].id=myModel.id;
//    [UserModel LMUser].mobile=myModel.mobile;
//    [UserModel LMUser].accountInfoId=myModel.accountInfoId;
//    [UserModel LMUser].nickName=myModel.nickName;
//    [UserModel LMUser].email=myModel.email;
//    [UserModel LMUser].gender=myModel.gender;
//    [UserModel LMUser].birthDate=myModel.birthDate;
//    [UserModel LMUser].introduce=myModel.introduce;
//    [UserModel LMUser].iconUrl=myModel.iconUrl;
//    [UserModel LMUser].name=myModel.name;
//    [GlobalClass storeUserData];
//    [LM_USER_DEFAULT synchronize];
}
//======计算时间1990.10.10
+(NSString*)timeDate:(NSString *)time andtype:(NSString *)type
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:type];//@"yyyy.MM.dd"
    NSString *strBegin=[NSString stringWithFormat:@"%@",time];
    NSInteger beginTime=[strBegin integerValue];
    NSDate* beginDate=[NSDate dateWithTimeIntervalSince1970:beginTime];
    NSString *beginStr = [formatter stringFromDate:beginDate];
    return beginStr;
}
//普通字符串转换为十六进制的。

+ (NSString *)hexStringFromString:(NSString *)string{
    NSData *myD = [string dataUsingEncoding:NSUTF8StringEncoding];
    Byte *bytes = (Byte *)[myD bytes];
    //下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i=0;i<[myD length];i++)
        
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff];///16进制数
        
        if([newHexStr length]==1)
            
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        
        else
            
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr]; 
    } 
    return hexStr; 
}
/*
//====背景变换颜色
+(void)changeBack:(UIView*)view andmodel:(MainModel*)model
{
    TLog(@"转换完的数字为1111：%@",model.imageAve);
    if (![Manager isBlankString:model.imageAve]) {
        unsigned long red = strtoul([model.imageAve UTF8String],0,16);
        TLog(@"转换完的数字为1111：%@",model.imageAve);
        TLog(@"转换完的数字为：%lx",red);
        UIColor *color=UIColorToRGB(red);
        CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        shake.duration = 0.1;
        shake.autoreverses = YES;
        //shake.repeatCount = 4;
        
        [view.layer addAnimation:shake forKey:@"shakeAnimation"];
        [UIView animateWithDuration:0.2 delay:0.0
                            options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             view.backgroundColor=color;
                             TLog(@"颜色变换结束");
                             
                         } completion:nil];
    }
    
}*/

//=====lable标签颜色
+(UIColor *)lableOne:(NSString *)index
{
    if ([index intValue]>7) {
        return RGB(255, 120, 110);
    }
    //颜色排序:::红、青、绿、海绿、浅蓝、蓝、蓝紫。
    NSArray *array=[NSArray arrayWithObjects:RGB(81, 131, 230),RGB(255, 174, 65),RGB(255, 90, 106),RGB(126, 201, 109),RGB(110, 184, 253),RGB(51, 205, 191),RGB(123, 114, 207), nil];
    UIColor *color=[array objectAtIndex:[index intValue]];
    return color;
}
//=====五维图颜色
+(UIColor *)lableFive:(NSString *)index
{
    if ([index intValue]>7) {
        return RGB(255, 120, 110);
    }
    //颜色排序:::红、青、绿、海绿、浅蓝、蓝、蓝紫。
    
    NSArray *array=[NSArray arrayWithObjects:RGBAlp(81, 131, 230),RGBAlp(255, 174, 65),RGBAlp(255, 90, 106),RGBAlp(126, 201, 109),RGBAlp(110, 184, 253),RGBAlp(51, 205, 191),RGBAlp(123, 114, 207), nil];
    UIColor *color=[array objectAtIndex:[index intValue]];
    return color;
}
//=====票的数量的标签颜色标签颜色
+(UIColor *)lableNumber:(NSString *)index
{
    if ([index intValue]>7) {
        return RGB(255, 120, 110);
    }
    //颜色排序:::红、青、绿、海绿、浅蓝、蓝、蓝紫。
    
    NSArray *array=[NSArray arrayWithObjects:RGBAlp(213, 222, 240),RGBAlp(244, 230, 210),RGBAlp(244, 215, 217),RGBAlp(221, 235, 218),RGBAlp(218, 232, 244),RGBAlp(208, 235, 233),RGBAlp(221, 219, 236), nil];
    UIColor *color=[array objectAtIndex:[index intValue]];
    return color;
}
//======加号，减号
+(NSString *)addImage:(NSString *)index
{
    NSArray *array=[NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    NSString *string=[array objectAtIndex:[index intValue]];
    return string;
}
+(NSString *)subImage:(NSString *)index
{
    NSArray *array=[NSArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    NSString *string=[array objectAtIndex:[index intValue]];
    return string;
}
#pragma mark 使图片模糊
+(UIImage *)imageFromView:(UIView *)theView
{
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur {
    if ((blur < 0.0f) || (blur > 1.0f)) {
        blur = 0.5f;
    }
    
    int boxSize = (int)(blur * 100);
    boxSize -= (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL,
                                       0, 0, boxSize, boxSize, NULL,
                                       kvImageEdgeExtend);
    
    if (error) {
        TLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             CGImageGetBitmapInfo(image.CGImage));
    
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
#pragma mark UIcolor 转UIimage
+(UIImage *) createImageWithColor: (UIColor *) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//将图片按给定的比例放大缩小
+(UIImage *)scaleImage:(UIImage *)image proportion:(float)scale {
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width/scale, image.size.height/scale));
    CGRect imageRect = CGRectMake(0.0, 0.0, image.size.width/scale, image.size.height/scale);
    [image drawInRect:imageRect];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image {
    // Create a thumbnail version of the image for the event object.
    CGSize size = image.size;
    CGSize croppedSize;
    CGFloat ratio = 64.0;
    CGFloat offsetX = 0.0;
    CGFloat offsetY = 0.0;
    
    // check the size of the image, we want to make it
    // a square with sides the size of the smallest dimension
    if (size.width > size.height) {
        offsetX = (size.height - size.width) / 2;
        croppedSize = CGSizeMake(size.height, size.height);
    } else {
        offsetY = (size.width - size.height) / 2;
        croppedSize = CGSizeMake(size.width, size.width);
    }
    
    // Crop the image before resize
    CGRect clippedRect = CGRectMake(offsetX * -1, offsetY * -1, croppedSize.width, croppedSize.height);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], clippedRect);
    // Done cropping
    
    // Resize the image
    CGRect rect = CGRectMake(0.0, 0.0, ratio, ratio);
    
    UIGraphicsBeginImageContext(rect.size);
    [[UIImage imageWithCGImage:imageRef] drawInRect:rect];
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    // Done Resizing
    
    return thumbnail;
}
//兼职类型图片
+(NSArray *)typeImageAll
{
    NSArray *arrayType=[NSArray arrayWithObjects:@"客服",@"演出",@"家教",@"模特",@"派单",@"文员",@"设计",@"校内",@"临时工",@"服务员",@"促销",@"安保",@"翻译",@"礼仪",@"销售",@"其他",nil];
    TLog(@"输出数组个数%ld",arrayType.count);
    NSArray *array=[NSArray arrayWithObjects:@"kefu.png",@"yanchu.png",@"jiajiao.png",@"mote.png",@"paidan.png",@"wenzhi.png",@"sheji.png",@"xiaonei.png",@"lingshigong.png",@"fuwuyuan.png",@"yanchu.png",@"yanchu.png",@"yanchu.png",@"yanchu.png",@"yanchu.png",@"yanchu.png",nil];
//    NSArray *arrayPaixu=[NSArray arrayWithObjects:@"离我最近",@"只看高薪",@"只看日结",@"周末兼职",nil];
//    NSArray *arrayPixu=[NSArray arrayWithObjects:@"locicon.png",@"cashicon.png",@"dateicon.png",@"weekicon.png",nil];
//    [NSMutableArray arrayWithArray:@[@[@"全城",@"东城区",@"西城区",@"朝阳区",@"海淀区"],@[@"全部类型",@"客服",@"演出",@"家教",@"模特",@"派单",@"文员",@"设计",@"校内",@"临时工",@"服务员",@"促销",@"安保",@"翻译",@"礼仪",@"销售",@"其他"],@[@"智能排序",@"离我最近",@"工资最高",@"周末兼职",@"随时可以"]]];
    return array;
}
//=======将选择的时间转化为上传服务器的字典
+(NSMutableDictionary *)timeSendToserver:(NSMutableDictionary *)mutabledict
{
    NSMutableDictionary *dictNumber=[[NSMutableDictionary alloc] init];
    for(id key in mutabledict) {
        NSLog(@"key :%@  value :%@", key, [mutabledict objectForKey:key]);
        id obj = [mutabledict objectForKey:key];
        NSInteger number=[[NSString stringWithFormat:@"%@",obj] integerValue];
        NSLog(@"取出其中的数字%ld", (long)number);
        NSInteger i=number-100;
        NSInteger x=i/3+1;
        NSInteger y=i%3+1;
        TLog(@"输出显示的内容%ld,输出yyy==%ld",(long)x,(long)y);
        NSMutableArray *muArray=[[NSMutableArray alloc] init];
        [muArray addObject:[NSString stringWithFormat:@"%ld",y]];
        NSArray *arrayNum=[dictNumber objectForKey:[NSString stringWithFormat:@"%ld",(long)x]];
        [muArray addObjectsFromArray:arrayNum];
        [dictNumber setObject:muArray forKey:[NSString stringWithFormat:@"%ld",(long)x]];
    }
    return dictNumber;
}
#pragma mark-compareCurrentTime
+(NSString *) compareCurrentTime:(NSString*)compareDate
//
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterFullStyle];
    [formatter setDateFormat:@"yyyy.MM.dd HH:mm"];
    NSInteger time=[compareDate integerValue];
    NSDate* date=[NSDate dateWithTimeIntervalSince1970:time];
    NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
    timeInterval = -timeInterval;
    long temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <60){
        result = [NSString stringWithFormat:@"%ld分前",temp];
    }
    
    else if((temp = temp/60) <24){
        result = [NSString stringWithFormat:@"%ld小时前",temp];
    }
    
    else if((temp = temp/24) <30){
        result = [NSString stringWithFormat:@"%ld天前",temp];
    }
    
    else if((temp = temp/30) <12){
        result = [NSString stringWithFormat:@"%ld月前",temp];
    }
    else{
        temp = temp/12;
        result = [NSString stringWithFormat:@"%ld年前",temp];
    }
    
    return  result;
}
//设定大小文字
+(UIBarButtonItem *)setCityTitle:(NSString *)title Action:(SEL)action Target:(id)target
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame=CGRectMake(0, 0, 44, 44);
    //[bt setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font=boldFont(14);
    [bt setImage:[UIImage imageNamed:@"CitySelect"] forState:UIControlStateNormal];
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    bt.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, -10);
    bt.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, -20);
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    //[leftButton setTitle:title];
    [leftButton setTintColor:[UIColor whiteColor]];
    return leftButton;
}
+(UIBarButtonItem *)setCustomTitle:(NSString *)title Action:(SEL)action Target:(id)target
{
    UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
    bt.frame=CGRectMake(0, 0, 44, 44);
    //[bt setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [bt setTitle:title forState:UIControlStateNormal];
    bt.titleLabel.font=boldFont(14);
    [bt addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    bt.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -20);
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithCustomView:bt];
    //[leftButton setTitle:title];
    [leftButton setTintColor:[UIColor whiteColor]];
    return leftButton;
}
@end
