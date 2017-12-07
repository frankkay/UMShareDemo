//
//  FKUMShareUtil.m
//  OWL
//
//  Created by frankay on 2017/12/6.
//  Copyright © 2017年 frankay. All rights reserved.
//

#import "FKUMShareUtil.h"
#import <UMSocialCore/UMSocialCore.h>
#import <UShareUI/UShareUI.h>

#define kUmengKey @"5a28e6918f4a9d44f3000105"

#define kWxShareAppId @"wx467bba49e855a955"
#define kWxShareAppSecret @"4405d1087e46cf2ab11895e3e293aa55"
#define kWxRedirectURL @"http://mobile.umeng.com/social"

#define kQQShareAppId   @"100424468"
#define kQQShareAppSecret   @""
#define kQQRedirectURL @"http://mobile.umeng.com/social"

#define kSinaShareAppId   @"3921700954"
#define kSinaShareAppSecret   @"04b48b094faeb16683c32669824ebdad"
#define kSinaRedirectURL @"https://sns.whalecloud.com/sina2/callback"

@implementation FKUMShareUtil

+ (void)openShareLog{
    BOOL open = NO;
#if DEBUG
    open = YES;
#endif
    [[UMSocialManager defaultManager] openLog:open];
    
}


+ (void)registUmengAndSharePlatform{
    
    [self openShareLog];
    
    //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:kUmengKey];
    
    //设置微信的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:kWxShareAppId appSecret:kWxShareAppSecret redirectURL:kWxRedirectURL];
    
    //设置分享到QQ互联的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:kQQShareAppId    appSecret:nil redirectURL:kQQRedirectURL];
    
    //设置新浪的appKey和appSecret
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:kSinaShareAppId  appSecret:kSinaShareAppSecret redirectURL:kSinaRedirectURL];
}

+ (void)shareTextToPlatform:(FKSharePlatform)platform withText:(NSString *)text completion:(shareCompletion)completion{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //设置文本
    messageObject.text = text;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:(UMSocialPlatformType)platform messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (completion) {
            completion(data,error);
        }
    }];
    
}


+ (void)shareImageToPlatform:(FKSharePlatform)platform withContent:(NSDictionary *)dict completion:(shareCompletion)completion{
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:dict[@"thumbImage"]];
    [shareObject setShareImage:dict[@"shareImage"]];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:(UMSocialPlatformType)platform messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        if (completion) {
            completion(data,error.code);
        }
    }];
    
}


+ (void)shareWebPageToPlatform:(FKSharePlatform)platform withContent:(NSDictionary *)dict completion:(shareCompletion)completion{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:dict[@"title"] descr:dict[@"desc"] thumImage:[UIImage imageNamed:dict[@"thumbImage"]]];
    
    //设置网页地址
    shareObject.webpageUrl = dict[@"url"];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:(UMSocialPlatformType)platform messageObject:messageObject currentViewController:nil completion:^(id data, NSError *error) {
        completion(data,error.code);
    }];
}

+ (void)showShareMenuWithPlatformSelectionBlock:(clickPlatformBlock)block{
    [self setPlatformsInMenu];
    
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        if (block) {
         block((FKSharePlatform)platformType,userInfo);
        }
        
    }];
    
}


+ (void)setPlatformsInMenu{
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_QQ),@(UMSocialPlatformType_Qzone),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine)]];
}


+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    
   return [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
}



/**---*-----*-----*------登录部分-----*----*----*----**/

+ (void)loginWithPlatform:(FKSharePlatform)platfrom completion:(loginCompletion)completion{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:(UMSocialPlatformType)platfrom currentViewController:nil completion:^(id result, NSError *error) {
        if (completion) {
            completion(result,error.code);
        }
    }];
}

@end
