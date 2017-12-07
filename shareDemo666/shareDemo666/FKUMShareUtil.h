//
//  FKUMShareUtil.h
//  OWL
//
//  Created by frankay on 2017/12/6.
//  Copyright © 2017年 frankay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FKSharePlatform) {
    
    FKSharePlatformSina = 0,      // 新浪微博
    FKSharePlatformWechat = 1,    // 微信
    FKSharePlatformTimeLine = 2,  // 朋友圈
    FKSharePlatformQQ = 4,        // qq
    FKSharePlatformQzone = 5,     // qq空间
   
};


typedef NS_ENUM(NSInteger, FKErrorType){
    
    FKErrorTypeUnknow =  2000,     // 未知错误
    FKErrorTypeAuthFailed = 2002,  // 授权失败
    FKErrorTypeShareFailed = 2003, // 分享失败
    FKErrorTypeGetUserInfoFailed = 2004, // 获取用户信息失败
    FKErrorTypeNotInstall  = 2008,  // 应用未安装
    FKErrorTypeCancel = 2009,  // 取消操作 ，取消分享，取消授权
    FKErrorTypeNotNetWork = 2010, // 网络异常
    FKErrorTypeSourceError = 2011, // 第三方出错
    
};



typedef void (^shareCompletion)(id result,FKErrorType errorType);

typedef void (^clickPlatformBlock)(FKSharePlatform platform,NSDictionary *info);

typedef void (^loginCompletion)(id result,FKErrorType errorType);


@interface FKUMShareUtil : NSObject

/**
 *  开启分享日志
 */

+ (void)openShareLog;


/**
 *  注册友盟和分享平台
 */

+ (void)registUmengAndSharePlatform;


/**
 *  分享文本
 */

+ (void)shareTextToPlatform:(FKSharePlatform)platform withText:(NSString *)text completion:(shareCompletion)completion;

/**
 *  分享图文  @{@"thumbImage":@"",@"shareImage":@""}
 */

+ (void)shareImageToPlatform:(FKSharePlatform)platform withContent:(NSDictionary *)dict completion:(shareCompletion)completion;

/**
 *  分享网页   @{@"title":@"",@"desc"：@"",@"thumbImage":@"",@"url":@""}
 */
+ (void)shareWebPageToPlatform:(FKSharePlatform)platform withContent:(NSDictionary *)dict completion:(shareCompletion)completion;

/**
 *  显示share UI界面
 */

+ (void)showShareMenuWithPlatformSelectionBlock:(clickPlatformBlock)block;

/**
 *  处理回调
 */

+ (BOOL)handleOpenURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;


/***---***----***-------登录-----***----***----***/
/**
 *    第三方登录
 */

+ (void)loginWithPlatform:(FKSharePlatform)platfrom completion:(loginCompletion)completion;


@end
