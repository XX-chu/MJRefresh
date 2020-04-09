//
//  NSBundle+MJRefresh.m
//  MJRefreshExample
//
//  Created by MJ Lee on 16/6/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "NSBundle+MJRefresh.h"
#import "MJRefreshComponent.h"
#import "MJRefreshConfig.h"

@implementation NSBundle (MJRefresh)
+ (instancetype)mj_refreshBundle
{
    static NSBundle *refreshBundle = nil;
    if (refreshBundle == nil) {

        NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
        NSString *currLanguage = [def valueForKey:@"LocalLanguageKey"];
        if(!currLanguage){
            NSArray *preferredLanguages = [NSLocale preferredLanguages];
            currLanguage = preferredLanguages[0];
            if ([currLanguage hasPrefix:@"ug"]) {
                currLanguage = @"ug-CN";
            }else if ([currLanguage hasPrefix:@"zh"]) {
                currLanguage = @"zh-Hans";
            }else currLanguage = @"zh-Hans";
            [def setValue:currLanguage forKey:@"LocalLanguageKey"];
            [def synchronize];
        }
        // 这里不使用mainBundle是为了适配pod 1.x和0.x
        NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
        refreshBundle = [NSBundle bundleWithPath:path];//生成bundle
    }
    
    return refreshBundle;
}

+ (UIImage *)mj_arrowImage
{
    static UIImage *arrowImage = nil;
    if (arrowImage == nil) {
        arrowImage = [[UIImage imageWithContentsOfFile:[[self mj_refreshBundle] pathForResource:@"arrow@2x" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    return arrowImage;
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key
{
    return [self mj_localizedStringForKey:key value:nil];
}

+ (NSString *)mj_localizedStringForKey:(NSString *)key value:(NSString *)value
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *currLanguage = [def valueForKey:@"LocalLanguageKey"];
    if(!currLanguage){
        NSArray *preferredLanguages = [NSLocale preferredLanguages];
        currLanguage = preferredLanguages[0];
        if ([currLanguage hasPrefix:@"ug"]) {
            currLanguage = @"ug-CN";
        }else if ([currLanguage hasPrefix:@"zh"]) {
            currLanguage = @"zh-Hans";
        }else currLanguage = @"zh-Hans";
        [def setValue:currLanguage forKey:@"LocalLanguageKey"];
        [def synchronize];
    }
    
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:currLanguage ofType:@"lproj"];
    NSBundle *bundle = [NSBundle bundleWithPath:path];//生成bundle
    NSString *revalue = [bundle localizedStringForKey:key value:nil table:@"Localizable"];
    
    return revalue;
}
@end
