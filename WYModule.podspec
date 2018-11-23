#
# Be sure to run `pod lib lint WYModuleProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'WYModule'
    s.version          = '0.0.2'
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

    #基础组件（WYCategory、WYMacros、WYMediator、WYNetwork、WYCoreHelper）
    s.subspec 'WYCore' do |wYCore|
        wYCore.source_files = 'WYModule/WYCore/**/*'
        
        wYCore.subspec 'WYCoreHelper' do |wYCoreHelper|
          wYCoreHelper.source_files = 'WYModule/WYCore/WYCoreHelper/**/*.{h,m}'
          wYCoreHelper.dependency 'XAspect'
          wYCoreHelper.dependency 'FLEX'
          wYCoreHelper.dependency 'CocoaLumberjack'
        end

        wYCore.subspec 'WYCategory' do |wYCategory|
          wYCategory.source_files = 'WYModule/WYCore/WYCategory/**/*.{h,m}'
        end
        
        wYCore.subspec 'WYMacros' do |wYMacros|
          wYMacros.source_files = 'WYModule/WYCore/WYMacros/**/*.{h,m}'
        end
        
        wYCore.subspec 'WYMediator' do |wYMediator|
          wYMediator.source_files = 'WYModule/WYCore/WYMediator/**/*.{h,m}'
        end

        wYCore.subspec 'WYNetwork' do |wYNetwork|
          wYNetwork.source_files = 'WYModule/WYCore/WYNetwork/**/*.{h,m}'
          wYNetwork.dependency 'YTKNetwork'
        end
    end

    #友盟分析
    s.subspec 'WYAnalytics' do |wYAnalytics|
        wYAnalytics.source_files = 'WYModule/WYAnalytics/**/*.{h,m}'
        wYAnalytics.public_header_files = 'WYModule/WYAnalytics/*.h'
        wYAnalytics.dependency 'WYModule/WYCore'
        wYAnalytics.dependency 'UMCCommon'                         #友盟基础库
        wYAnalytics.dependency 'UMCCommonLog'                      #友盟日志库
        wYAnalytics.dependency 'UMCAnalytics'
        wYAnalytics.dependency 'Aspects'
    end

    #支付模块
    s.subspec 'WYPay' do |wYPay|
        wYPay.source_files = 'WYModule/WYPay/**/*.{h,m}'
        wYPay.public_header_files = 'WYModule/WYPay/*.h'
        wYPay.dependency 'WYModule/WYCore'
        wYPay.dependency 'AlipaySDK-iOS'
        wYPay.dependency 'WechatOpenSDK'
    end

    #社交模块
    s.subspec 'WYSocial' do |wYSocial|
        wYSocial.source_files = 'WYModule/WYSocial/**/*.{h,m}'
        wYSocial.public_header_files = 'WYModule/WYSocial/*.h'
        wYSocial.dependency 'WYModule/WYCore'
        wYSocial.dependency 'XAspect'
        wYSocial.dependency 'UMCCommon'                         #友盟基础库
        wYSocial.dependency 'UMCCommonLog'                      #友盟日志库
        wYSocial.dependency 'UMCShare/UI'                       # U-Share SDK UI模块（分享面板，建议添加）
        wYSocial.dependency 'UMCShare/Social/ReducedSina'       # 集成新浪微博(精简版1M)
        wYSocial.dependency 'UMCShare/Social/ReducedWeChat'     # 集成微信(精简版0.2M)
        wYSocial.dependency 'UMCShare/Social/ReducedQQ'         # 集成QQ/QZone/TIM(精简版0.5M)
    end

    #热更新模块
    s.subspec 'WYPatchHelper' do |wYPatchHelper|
      wYPatchHelper.source_files = 'WYModule/WYPatchHelper/**/*.{h,m}'
      wYPatchHelper.public_header_files = 'WYModule/WYPatchHelper/*.h'
      wYPatchHelper.dependency 'WYModule/WYCore'
      wYPatchHelper.dependency 'YYCache'
      wYPatchHelper.dependency 'JSPatch'
      wYPatchHelper.dependency 'AFNetworking'
    end

    #个推模块
    s.subspec 'WYGT' do |wYGT|
        wYGT.source_files = 'WYModule/WYGT/**/*.{h,m}'
        wYGT.public_header_files = 'WYModule/WYGT/*.h'
        wYGT.dependency 'WYModule/WYCore'
        wYGT.dependency 'XAspect'
        wYGT.dependency 'GTSDK'
    end

    #开机广告
    s.subspec 'WYLaunchAdHelper' do |wYLaunchAdHelper|
        wYLaunchAdHelper.source_files = 'WYModule/WYLaunchAdHelper/**/*.{h,m}'
        wYLaunchAdHelper.public_header_files = 'WYModule/WYLaunchAdHelper/*.h'
        wYLaunchAdHelper.dependency 'WYModule/WYCore'
        wYLaunchAdHelper.dependency 'XHLaunchAd'
        wYLaunchAdHelper.dependency 'AFNetworking'
    end
    
    #更新引导页
    s.subspec 'WYIntroViewHelper' do |wYIntroViewHelper|
      wYIntroViewHelper.source_files = 'WYModule/WYIntroViewHelper/**/*'
      wYIntroViewHelper.public_header_files = 'WYModule/WYIntroViewHelper/*.h'
      wYIntroViewHelper.dependency 'WYModule/WYCore'
      wYIntroViewHelper.resource_bundles = { 'GuideImage' => ['WYModule/WYIntroViewHelper/DHGuidePageHUD/GuideImage.bundle'] }
    end

    #空页面占位图
    s.subspec 'WYEmptyViewHelper' do |wYEmptyViewHelper|
        wYEmptyViewHelper.source_files = 'WYModule/WYEmptyViewHelper/**/*.{h,m}'
        wYEmptyViewHelper.public_header_files = 'WYModule/WYEmptyViewHelper/*.h'
        wYEmptyViewHelper.dependency 'WYModule/WYCore'
        wYEmptyViewHelper.dependency 'LYEmptyView'
        wYEmptyViewHelper.resource_bundles = { 'WYEmptyView' => ['WYModule/WYEmptyViewHelper/WYEmptyView.bundle'] }
    end

    #定位
    s.subspec 'WYLocationManager' do |wYLocationManager|
      wYLocationManager.source_files = 'WYModule/WYLocationManager/**/*.{h,m}'
      wYLocationManager.dependency 'WYModule/WYCore'
    end
    
    #常用UI组件
    s.subspec 'WYUI' do |wYUI|
        wYUI.source_files = 'WYModule/WYUI/**/*'
        wYUI.dependency 'WYModule/WYCore'
        
        wYUI.subspec 'WYSearchBar' do |wYSearchBar|
          wYSearchBar.source_files = 'WYModule/WYUI/WYSearchBar/**/*.{h,m}'
          wYSearchBar.resource_bundles = { 'WYSearchBar' => ['WYModule/WYUI/WYSearchBar/WYSearchBar.bundle'] }
        end
        
        wYUI.subspec 'MBProgressHUD' do |mBProgressHUD|
          mBProgressHUD.source_files = 'WYModule/WYUI/MBProgressHUD/**/*'
          mBProgressHUD.dependency 'MBProgressHUD'
        end
        
    end

    s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
