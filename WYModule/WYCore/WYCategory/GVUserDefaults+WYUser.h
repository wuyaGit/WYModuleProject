//
//  GVUserDefaults+WYUser.h
//  WYModule
//
//  Created by hero on 2018/12/7.
//

#import <GVUserDefaults/GVUserDefaults.h>

NS_ASSUME_NONNULL_BEGIN

@interface GVUserDefaults (WYUser)

@property (nonatomic, copy, nullable) NSString *user_id;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *zfb_name;
@property (nonatomic, copy) NSString *zfb_username;
@property (nonatomic, copy) NSString *inviter_username;
@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSInteger is_bd_qq;
@property (nonatomic, assign) NSInteger is_bd_wx;
@property (nonatomic, assign) NSInteger payword_status; //是否设置了支付密码

//"is_del" = 0;
//"is_frozen" = 0;
//"is_login" = 1;
//"is_team" = 0;
//"login_num" = 1;
//"open_status" = 1;
//"open_time" = 0;
@end

NS_ASSUME_NONNULL_END
