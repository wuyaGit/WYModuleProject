#
# Be sure to run `pod lib lint WYModuleProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'WYModule'
    s.version          = '0.1.0'
    s.summary          = 'iOS模块化开发的解决方案（不断完善中~~~） '

    s.description      = <<-DESC
                        iOS模块化开发的解决方案（不断完善中~~~）
                       DESC

    s.homepage         = 'https://github.com/wuyaGit/WYModuleProject'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Young' => '407671883@qq.com' }
    s.source           = { :git => 'https://github.com/wuyaGit/WYModuleProject.git', :tag => s.version.to_s }

    s.ios.deployment_target = '9.0'

    s.requires_arc = true

    s.subspec 'WYCore' do |wYCore|
        wYCore.source_files = 'WYModule/WYCore/**/*'
        wYCore.dependency 'XAspect'
        wYCore.dependency 'YYCache'
        wYCore.dependency 'JSPatch'
        wYCore.dependency 'RealReachability'
        wYCore.dependency 'FLEX'
        wYCore.dependency 'CocoaLumberjack'
        wYCore.dependency 'YTKNetwork'
        wYCore.dependency 'MBProgressHUD'
    end

    s.subspec 'WYAnalytics' do |wYAnalytics|
        wYAnalytics.source_files = 'WYModule/WYAnalytics/**/*.{h,m}'
        wYAnalytics.dependency 'WYModule/WYCore'
        wYAnalytics.dependency 'UMCCommon'                         #友盟基础库
        wYAnalytics.dependency 'UMCCommonLog'                      #友盟日志库
        wYAnalytics.dependency 'UMCAnalytics'
        wYAnalytics.dependency 'Aspects'
    end

    s.subspec 'WYPay' do |wYPay|
        wYPay.source_files = 'WYModule/WYPay/**/*.{h,m}'
        wYPay.dependency 'WYModule/WYCore'
        wYPay.dependency 'AlipaySDK-iOS'
        wYPay.dependency 'WechatOpenSDK'
    end

    s.subspec 'WYSocial' do |wYSocial|
        wYSocial.source_files = 'WYModule/WYSocial/**/*.{h,m}'
        wYSocial.dependency 'WYModule/WYCore'
        wYSocial.dependency 'XAspect'
        wYSocial.dependency 'UMCCommon'                         #友盟基础库
        wYSocial.dependency 'UMCCommonLog'                      #友盟日志库
        wYSocial.dependency 'UMCShare/UI'                       # U-Share SDK UI模块（分享面板，建议添加）
        wYSocial.dependency 'UMCShare/Social/ReducedSina'       # 集成新浪微博(精简版1M)
        wYSocial.dependency 'UMCShare/Social/ReducedWeChat'     # 集成微信(精简版0.2M)
        wYSocial.dependency 'UMCShare/Social/ReducedQQ'         # 集成QQ/QZone/TIM(精简版0.5M)
    end

    s.subspec 'WYGT' do |wYGT|
        wYGT.source_files = 'WYModule/WYGT/**/*.{h,m}'
        wYGT.dependency 'WYModule/WYCore'
        wYGT.dependency 'XAspect'
        wYGT.dependency 'GTSDK'
    end

    s.subspec 'WYLaunchAdHelper' do |wYLaunchAdHelper|
        wYLaunchAdHelper.source_files = 'WYModule/WYLaunchAdHelper/**/*.{h,m}'
        wYLaunchAdHelper.dependency 'WYModule/WYCore'
        wYLaunchAdHelper.dependency 'XHLaunchAd'
        wYLaunchAdHelper.dependency 'AFNetworking'
    end
    
    s.subspec 'WYIntroViewHelper' do |wYIntroViewHelper|
      wYIntroViewHelper.source_files = 'WYModule/WYIntroViewHelper/**/*.{h,m}'
      wYIntroViewHelper.dependency 'WYModule/WYCore'

    end

    s.subspec 'WYEmptyViewHelper' do |wYEmptyViewHelper|
        wYEmptyViewHelper.source_files = 'WYModule/WYEmptyViewHelper/**/*.{h,m}'
        wYEmptyViewHelper.dependency 'WYModule/WYCore'
    end

    s.subspec 'WYUI' do |wYUI|
        wYUI.source_files = 'WYModule/WYUI/**/*.{h,m}'
        wYUI.dependency 'WYModule/WYCore'
    end

    s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
