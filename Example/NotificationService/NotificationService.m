//
//  NotificationService.m
//  NotificationService
//
//  Created by mac on 2019/2/15.
//  Copyright © 2019 407671883@qq.com. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
//    self.contentHandler = contentHandler;
//    self.bestAttemptContent = [request.content mutableCopy];
//
//    // Modify the notification content here...
//    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
//
//    self.contentHandler(self.bestAttemptContent);
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    //[modified]这个是一个标示，可以实现对服务器下发下来的内容进行更改
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    NSDictionary *apsDic = [request.content.userInfo objectForKey:@"aps"];
    NSString *attachUrl = [apsDic objectForKey:@"image"];
    
    NSString *category = [apsDic objectForKey:@"category"];
    self.bestAttemptContent.categoryIdentifier = category;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:attachUrl];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url
                                                        completionHandler:^(NSURL * _Nullable location,
                                                                            NSURLResponse * _Nullable response,
                                                                            NSError * _Nullable error) {
                                                            NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
                                                            NSString *file = [caches stringByAppendingPathComponent:response.suggestedFilename];
                                                            NSFileManager *mgr = [NSFileManager defaultManager];
                                                            [mgr moveItemAtPath:location.path toPath:file error:nil];
                                                            
                                                            if (file && ![file  isEqualToString: @""])
                                                            {
                                                                UNNotificationAttachment *attch= [UNNotificationAttachment attachmentWithIdentifier:@"photo"
                                                                                                                                                URL:[NSURL URLWithString:[@"file://" stringByAppendingString:file]]
                                                                                                                                            options:nil
                                                                                                                                              error:nil];
                                                                if(attch)
                                                                {
                                                                    self.bestAttemptContent.attachments = @[attch];
                                                                }
                                                            }
                                                            self.contentHandler(self.bestAttemptContent);
                                                        }];
    [downloadTask resume];

}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
