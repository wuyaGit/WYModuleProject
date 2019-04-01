//
//  WYRongIMHelper.m
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import "WYRongIMHelper.h"

#import <RongIMKit/RongIMKit.h>

@implementation WYRongIMHelper

// 链接融云
+ (void)connectRongCloudIMWithToken:(NSString *)token
                            success:(void (^)(NSString *))success
                            failure:(void (^)(void))failure {
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        if (success) {
            success(userId);
        }
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%ld", (long)status);
        if (failure) {
            failure();
        }
    } tokenIncorrect:^{
        NSLog(@"token错误");
        if (failure) {
            failure();
        }
    }];
}

// 获取会话消息提醒状态（是否免打扰）
+ (void)getConversationNotificationStatus:(WYRIMConversationType)conversationType
                                 targetId:(NSString *)targetId
                                  success:(void (^)(WYRIMConversationNotificationStatus nStatus))successBlock
                                    error:(void (^)(NSInteger status))errorBlock {
    
    // 获取会话消息提醒状态
    [[RCIMClient sharedRCIMClient]getConversationNotificationStatus:(NSUInteger)conversationType targetId:targetId success:^(RCConversationNotificationStatus nStatus) {
        if (successBlock) {
            successBlock((WYRIMConversationNotificationStatus)nStatus);
        }
    } error:^(RCErrorCode status) {
        if (errorBlock) {
            errorBlock(status);
        }
    }];
}

// 设置消息免打扰
- (void)setConversationisBlocked:(WYRIMConversationType)conversationType
                        targetId:(NSString *)targetId
                       isBlocked:(BOOL)isBlocked
                      completion:(void (^)(BOOL success))completion {
    [[RCIMClient sharedRCIMClient] setConversationNotificationStatus:(NSUInteger)conversationType targetId:targetId isBlocked:isBlocked success:^(RCConversationNotificationStatus nStatus) {
        if (completion) {
            completion(YES);
        }
    } error:^(RCErrorCode status) {
        if (completion) {
            completion(NO);
        }
    }];
}

// 获取会话是否置顶
+ (BOOL)conversationIsTop:(WYRIMConversationType)conversationType targetId:(NSString *)targetId {
    // 获取会话
    RCConversation *conversation = [[RCIMClient sharedRCIMClient] getConversation:(NSUInteger)conversationType targetId:targetId];

    return conversation.isTop;
}

// 设置会话是否置顶
+ (void)setConversationToTop:(WYRIMConversationType)conversationType targetId:(NSString *)targetId completion:(void (^)(BOOL success))completion {
    RCConversation *conversation = [[RCIMClient sharedRCIMClient] getConversation:(NSUInteger)conversationType targetId:targetId];
    BOOL success = [[RCIMClient sharedRCIMClient] setConversationToTop:(NSUInteger)conversationType targetId:targetId isTop:!conversation.isTop];
    if (completion) {
        completion(success);
    }
}

// 清空消息记录
+ (void)clearMessagesForConversation:(WYRIMConversationType)conversationType targetId:(NSString *)targetId {
    [[RCIMClient sharedRCIMClient] clearMessages:(NSUInteger)conversationType targetId:targetId];
}

// 调用api删除好友(或群等)后，删除会话，清空消息记录
+ (void)deleteConversation:(WYRIMConversationType)conversationType targetId:(NSString *)targetId {
    [[RCIMClient sharedRCIMClient] clearMessages:(NSUInteger)conversationType targetId:targetId];
    [[RCIMClient sharedRCIMClient] removeConversation:(NSUInteger)conversationType targetId:targetId];
}

// 刷新好友信息缓存
+ (void)refreshUserInfoCacheWithUserId:(NSString *)userId name:(NSString *)name portrait:(NSString *)portrait {
    RCUserInfo *userInfo = [[RCUserInfo alloc] initWithUserId:userId name:name portrait:portrait];
    [[RCIM sharedRCIM] refreshUserInfoCache:userInfo withUserId:userId];
}

// 刷新群消息缓存
+ (void)refreshGroupInfoCacheWithGroupId:(NSString *)groupId name:(NSString *)name portrait:(NSString *)portrait {
    RCGroup *groupInfo = [[RCGroup alloc] initWithGroupId:groupId groupName:name portraitUri:portrait];
    [[RCIM sharedRCIM] refreshGroupInfoCache:groupInfo withGroupId:groupId];
}

@end
