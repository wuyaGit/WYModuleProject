#
# Be sure to run `pod lib lint WYModuleProject.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'WYModule'
    s.version          = '0.0.3'
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
        wYCore.source_files = 'WYModule/WYCore/*.{h,m}'

        wYCore.subspec 'WYCoreHelper' do |wYCoreHelper|
          wYCoreHelper.source_files = 'WYModule/WYCore/WYCoreHelper/**/*.{h,m}'
          wYCoreHelper.dependency 'XAspect'
          wYCoreHelper.dependency 'CocoaLumberjack'
        end

        wYCore.subspec 'WYCategory' do |wYCategory|
          wYCategory.source_files = 'WYModule/WYCore/WYCategory/**/*.{h,m}'
          wYCategory.dependency 'GVUserDefaults'
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
    
#    #友盟推送模块
#    s.subspec 'WYUMengPush' do |wYUMengPush|
#      wYUMengPush.source_files = 'WYModule/WYUMengPush/**/*.{h,m}'
#      wYUMengPush.public_header_files = 'WYModule/WYUMengPush/*.h'
#      wYUMengPush.dependency 'WYModule/WYCore'
#      wYUMengPush.dependency 'XAspect'
#      wYUMengPush.dependency 'UMCCommon'                         #友盟基础库
#      wYUMengPush.dependency 'UMCCommonLog'                      #友盟日志库
#      wYUMengPush.dependency 'UMCPush'
#      #wYUMengPush.dependency 'UMCSecurityPlugins'
#    end

    #热更新模块
    s.subspec 'WYPatchHelper' do |wYPatchHelper|
      wYPatchHelper.source_files = 'WYModule/WYPatchHelper/**/*.{h,m}'
      wYPatchHelper.public_header_files = 'WYModule/WYPatchHelper/*.h'
      wYPatchHelper.dependency 'WYModule/WYCore'
      wYPatchHelper.dependency 'YYCache'
      wYPatchHelper.dependency 'JSPatch'
      wYPatchHelper.dependency 'AFNetworking'
    end

#    #个推模块
#    s.subspec 'WYGT' do |wYGT|
#        wYGT.source_files = 'WYModule/WYGT/**/*.{h,m}'
#        wYGT.public_header_files = 'WYModule/WYGT/*.h'
#        wYGT.dependency 'WYModule/WYCore'
#        wYGT.dependency 'XAspect'
#        wYGT.dependency 'GTSDK'
#    end

    #极光推送模块
    s.subspec 'WYJPush' do |wYJPush|
        wYJPush.source_files = 'WYModule/WYJPush/**/*.{h,m}'
        wYJPush.public_header_files = 'WYModule/WYJPush/*.h'
        wYJPush.dependency 'WYModule/WYCore'
        wYJPush.dependency 'XAspect'
        wYJPush.dependency 'JPush'
    end

    #魔窗模块
    s.subspec 'WYMagicWindow' do |wYMagicWindow|
        wYMagicWindow.source_files = 'WYModule/WYMagicWindow/**/*.{h,m}'
        wYMagicWindow.public_header_files = 'WYModule/WYMagicWindow/*.h'
        wYMagicWindow.dependency 'WYModule/WYCore'
        wYMagicWindow.dependency 'XAspect'
        wYMagicWindow.dependency 'MagicWindowSDK'
    end
    
    #融云即时通讯
    s.subspec 'WYRongIM' do |wYRongIM|
      wYRongIM.source_files = 'WYModule/WYRongIM/**/*.{h,m}'
      wYRongIM.public_header_files = 'WYModule/WYRongIM/*.h'
      wYRongIM.dependency 'WYModule/WYCore'
      wYRongIM.dependency 'XAspect'
      wYRongIM.dependency 'RongCloudIM/IMLib'
      wYRongIM.dependency 'RongCloudIM/IMKit'
    end

    #百度地图
    s.subspec 'WYBaiduMap' do |wYBaiduMap|
      wYBaiduMap.source_files = 'WYModule/WYBaiduMap/**/*.{h,m}'
      wYBaiduMap.public_header_files = 'WYModule/WYBaiduMap/*.h'
      wYBaiduMap.dependency 'WYModule/WYCore'
      wYBaiduMap.dependency 'BMKLocationKit'        #百度地图定位sdk
      wYBaiduMap.dependency 'BaiduMapKit'           #百度地图sdk
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
        
        wYUI.subspec 'WYSearchBar' do |wYSearchBar|
          wYSearchBar.source_files = 'WYModule/WYUI/WYSearchBar/**/*.{h,m}'
          wYSearchBar.resource_bundles = { 'WYSearchBar' => ['WYModule/WYUI/WYSearchBar/WYSearchBar.bundle'] }
        end
        
        wYUI.subspec 'MBProgressHUD' do |mBProgressHUD|
          mBProgressHUD.source_files = 'WYModule/WYUI/MBProgressHUD/**/*.{h,m}'
          mBProgressHUD.dependency 'MBProgressHUD'
          mBProgressHUD.resource_bundles = { 'MBProgressHUD' => ['WYModule/WYUI/MBProgressHUD/*.png']}
        end
        
        wYUI.subspec 'WSDatePickerView' do |wSDatePickerView|
          wSDatePickerView.source_files = 'WYModule/WYUI/WSDatePickerView/**/*'
        end
        
        wYUI.subspec 'WYAlertCityPickerView' do |wYAlertCityPickerView|
          wYAlertCityPickerView.source_files = 'WYModule/WYUI/WYAlertCityPickerView/**/*.{h,m}'
          wYAlertCityPickerView.resource_bundles = { 'WYAlertCityPickerView' => ['WYModule/WYUI/WYAlertCityPickerView/WYAlertCityPickerView.bundle'] }
        end

    end

    s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
