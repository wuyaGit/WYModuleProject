//
//  WYRongIMHelper.h
//  WYModule
//
//  Created by mac on 2019/2/17.
//

#import <Foundation/Foundation.h>

// 会话类型
typedef NS_ENUM(NSUInteger, WYRIMConversationType) {
    /*!
     单聊
     */
    WYRIMConversationType_PRIVATE = 1,
    
    /*!
     讨论组
     */
    WYRIMConversationType_DISCUSSION = 2,
    
    /*!
     群组
     */
    WYRIMConversationType_GROUP = 3,
    
    /*!
     聊天室
     */
    WYRIMConversationType_CHATROOM = 4,
    
    /*!
     客服
     */
    WYRIMConversationType_CUSTOMERSERVICE = 5,
    
    /*!
     系统会话
     */
    WYRIMConversationType_SYSTEM = 6,
    
    /*!
     应用内公众服务会话
     
     @discussion
     客服2.0使用应用内公众服务会话（ConversationType_APPSERVICE）的方式实现。
     即客服2.0会话是其中一个应用内公众服务会话，这种方式我们目前不推荐，请尽快升级到新客服，升级方法请参考官网的客服文档。
     */
    WYRIMConversationType_APPSERVICE = 7,
    
    /*!
     跨应用公众服务会话
     */
    WYRIMConversationType_PUBLICSERVICE = 8,
    
    /*!
     推送服务会话
     */
    WYRIMConversationType_PUSHSERVICE = 9,
    
    /*!
     加密会话（仅对部分私有云用户开放，公有云用户不适用）
     */
    WYRIMConversationType_Encrypted = 11,
    
    /*!
     无效类型
     */
    WYRIMConversationType_INVALID
    
};

// 会话提醒状态
typedef NS_ENUM(NSUInteger, WYRIMConversationNotificationStatus) {
    /*!
     免打扰
     */
    WYRIMConversationNotificationStatus_DO_NOT_DISTURB = 0,
    
    /*!
     新消息提醒
     */
    WYRIMConversationNotificationStatus_NOTIFY = 1,
};

NS_ASSUME_NONNULL_BEGIN

@interface WYRongIMHelper : NSObject

// 链接融云
+ (void)connectRongCloudIMWithToken:(NSString *)token
                            success:(void (^)(NSString *))success
                            failure:(void (^)(void))failure;

// 获取会话消息提醒状态（是否免打扰）
+ (void)getConversationNotificationStatus:(WYRIMConversationType)conversationType
                                 targetId:(NSString *)targetId
                                  success:(void (^)(WYRIMConversationNotificationStatus nStatus))successBlock
                                    error:(void (^)(NSInteger status))errorBlock;

// 设置消息免打扰
- (void)setConversationisBlocked:(WYRIMConversationType)conversationType
                        targetId:(NSString *)targetId
                       isBlocked:(BOOL)isBlocked
                      completion:(void (^)(BOOL success))completion;

// 获取会话是否置顶
+ (BOOL)conversationIsTop:(WYRIMConversationType)conversationType targetId:(NSString *)targetId;

// 设置会话是否置顶
+ (void)setConversationToTop:(WYRIMConversationType)conversationType
                    targetId:(NSString *)targetId
                  completion:(void (^)(BOOL success))completion;

// 清空消息记录
+ (void)clearMessagesForConversation:(WYRIMConversationType)conversationType targetId:(NSString *)targetId;

// 调用api删除好友(或群等)后，删除会话，清空消息记录
+ (void)deleteConversation:(WYRIMConversationType)conversationType targetId:(NSString *)targetId;

// 刷新好友信息缓存
+ (void)refreshUserInfoCacheWithUserId:(NSString *)userId name:(NSString *)name portrait:(NSString *)portrait;

// 刷新群消息缓存
+ (void)refreshGroupInfoCacheWithGroupId:(NSString *)groupId name:(NSString *)name portrait:(NSString *)portrait;

@end

NS_ASSUME_NONNULL_END
