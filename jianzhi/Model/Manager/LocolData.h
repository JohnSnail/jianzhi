//
//  LocolData.h
//  ComboAF
//
//  Created by li on 14/11/21.
//  Copyright (c) 2014年 li. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface LocolData : NSObject
//=====返回局详细信息cell============
+(NSArray *)locolBureauArray;
+(NSArray *)locolCreatBureau;
//=====保存个人信息===========
+(void)getPersonDict:(NSDictionary*)dict;
+(void)personDetail:(NSDictionary*)dict;
//======计算时间1990.10.10
+(NSString*)timeDate:(NSString *)time andtype:(NSString *)type;
//普通字符串转换为十六进制的。
+ (NSString *)hexStringFromString:(NSString *)string;
//====背景变换颜色
//+(void)changeBack:(UIView*)view andmodel:(MainModel*)model;
//===修改navigation颜色

//=====lable标签颜色
+(UIColor *)lableOne:(NSString *)index;
//=====五维图颜色
+(UIColor *)lableFive:(NSString *)index;
//=====票的数量的标签颜色标签颜色
+(UIColor *)lableNumber:(NSString *)index;
//======加号，减号
+(NSString *)addImage:(NSString *)index;
+(NSString *)subImage:(NSString *)index;
//======模糊图片======
+(UIImage *)imageFromView:(UIView *)theView;
+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
//======uicolor 转uiimage
+(UIImage *) createImageWithColor: (UIColor *) color;
+(UIImage *)scaleImage:(UIImage *)image proportion:(float)scale;
+ (UIImage *)generatePhotoThumbnail:(UIImage *)image;
+(NSArray *)typeImageAll;//兼职类型本地图片
//=======将选择的时间转化为上传服务器的字典
+(NSMutableDictionary *)timeSendToserver:(NSMutableDictionary *)mutabledict;
//======多少分钟前
+(NSString *)compareCurrentTime:(NSString*)compareDate;
+(UIBarButtonItem *)setCityTitle:(NSString *)title Action:(SEL)action Target:(id)target;
+(UIBarButtonItem *)setCustomTitle:(NSString *)title Action:(SEL)action Target:(id)target;
@end
