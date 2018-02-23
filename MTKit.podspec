Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.name         = "MTKit"
  s.version      = "0.0.1"
  s.summary      = "MTKit is ios HT Project"
  s.description  = <<-DESC
             0.0.1 项目常用框架，测试阶段、使用问题反馈至下面邮箱htlingday@hotmail.com
                   DESC

  s.homepage     = "https://github.com/michaelyht/MTKit"

  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.license      = { :type => "MIT", :file => "LICENSE" }

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.author             = { "michaelyht" => "htlingday@hotmail.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.ios.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.source       = { :git => "https://github.com/michaelyht/MTKit.git", :tag => "#{s.version}" }

  s.requires_arc = true

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  s.source_files  = "MTKit/MTKit/MTKit.h"
  s.exclude_files = "MTKit/MTKit.xcodeproj"



  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit', 'QuartzCore', 'SystemConfiguration'
  s.libraries   = 'sqlite3', 'z'


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
     s.subspec 'Category' do |ss|
        ss.source_files = 'MTKit/MTKit/Category/*.h'
        ss.dependency 'YYCache', '~> 1.0.4'
            ss.subspec 'Foundation' do |sss|
                sss.source_files = 'MTKit/MTKit/Category/Foundation/MT_FoundationHeader.h'
                sss.subspec 'NSData' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSData/*'
                end
                sss.subspec 'NSDate' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSDate/*'
                end
                sss.subspec 'NSDictionary' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSDictionary/*'
                end
                sss.subspec 'NSObject' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSObject/*'
                end
                sss.subspec 'NSNumber' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSNumber/*'
                    ssss.dependency 'MTKit/Category/Foundation/NSData'
                end
                sss.subspec 'NSString' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSString/*'
                    ssss.dependency 'MTKit/Category/Foundation/NSNumber'
                end
                sss.subspec 'NSTimer' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSTimer/*'
                end
                sss.subspec 'NSUserDefaults' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/Foundation/NSUserDefaults/*'
                end
            end

            ss.subspec 'Quartz' do |sss|
                sss.source_files = 'MTKit/MTKit/Category/Quartz/*'
            end

            ss.subspec 'UIKit' do |sss|
                sss.source_files = 'MTKit/MTKit/Category/UIKit/MT_UIKitHeader.h'
                sss.subspec 'UIApplication' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIApplication/*'
                    ssss.dependency 'MTKit/Category/UIKit/UIDevice'
                end
                sss.subspec 'UIBarButtonItem' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIBarButtonItem/*'
                end
                sss.subspec 'UIBezierPath' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIBezierPath/*'
                    ssss.dependency 'MTKit/Category/UIKit/UIFont'
                end
                sss.subspec 'UIButton' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIButton/*'
                end
                sss.subspec 'UIColor' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIColor/*'
                end
                sss.subspec 'UIControl' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIControl/*'
                end
                sss.subspec 'UIDevice' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIDevice/*'
                    ssss.dependency 'MTKit/Category/Foundation/NSString'
                end
                sss.subspec 'UIFont' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIFont/*'
                end
                sss.subspec 'UIGesture' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIGesture/*'
                end
                sss.subspec 'UIImage' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIImage/*'
                    ssss.dependency 'MTKit/Category/YYUtils'
                end
                sss.subspec 'UIImageView' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIImageView/*'
                end
                sss.subspec 'UINavigationBar' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UINavigationBar/*'
                end
                sss.subspec 'UINavigationController' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UINavigationController/*.{h,m}'
                end
                sss.subspec 'UIScrollView' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIScrollView/*'
                end
                sss.subspec 'UITableView' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UITableView/*'
                end
                sss.subspec 'UITextField' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UITextField/*'
                end
                sss.subspec 'UITextView' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UITextView/*'
                end
                sss.subspec 'UIView' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIView/*'
                end
                sss.subspec 'UIViewController' do |ssss|
                    ssss.source_files = 'MTKit/MTKit/Category/UIKit/UIViewController/*'
                end
            end

            ss.subspec 'YYUtils' do |sss|
                sss.source_files = 'MTKit/MTKit/Category/YYUtils/*'
                sss.dependency 'MTKit/Category/UIKit/UIView'
            end
    end

    s.subspec 'Macros' do |ss|
        ss.source_files = 'MTKit/MTKit/Macros/*.h'
        ss.dependency 'MTKit/Category'
    end

    s.subspec 'Utils' do |ss|
        ss.source_files = 'MTKit/MTKit/Utils/MT_Utils_Header.h'
        ss.dependency 'MTKit/Macros'
        ss.subspec 'MTAlertUtil' do |sss|
            sss.source_files = 'MTKit/MTKit/Utils/MTAlertUtil/*'
            sss.dependency 'MTKit/Category/Foundation/NSString'
        end
        ss.subspec 'MTProgressHUD' do |sss|
        sss.source_files = 'MTKit/MTKit/Utils/MTProgressHUD/*.{h,m}'
            sss.dependency 'SVProgressHUD', '~> 2.1.2'
        end
        ss.subspec 'AppInfoUtil' do |sss|
            sss.source_files = 'MTKit/MTKit/Utils/AppInfoUtil/*'
            sss.dependency 'AFNetworking', '~> 3.1.0'
        end
        ss.subspec 'MTTableViewUtil' do |sss|
            sss.source_files = 'MTKit/MTKit/Utils/MTTableViewUtil/*'
        end
        ss.subspec 'UserInfoUtil' do |sss|
            sss.source_files = 'MTKit/MTKit/Utils/UserInfoUtil/*'
            sss.dependency 'MTKit/Core/Action/Constants'
        end
    end

    s.subspec 'Core' do |ss|
        ss.dependency 'AFNetworking', '~> 3.1.0'
        ss.subspec 'Action' do |sss|

            sss.subspec 'Reachability' do |ssss|
            ssss.source_files = 'MTKit/MTKit/Core/Action/Reachability/*.{h,m}'
            ssss.dependency 'MTKit/Utils'
            end

            sss.subspec 'Constants' do |ssss|
            ssss.source_files = 'MTKit/MTKit/Core/Action/Constants/*.{h,m}'
            end

            sss.subspec 'Actions' do |ssss|
            ssss.source_files = 'MTKit/MTKit/Core/Action/Actions/*.{h,m}'
            ssss.dependency 'MTKit/Core/Action/Reachability'
            end
        end
        ss.subspec 'Service' do |sss|
            sss.source_files = 'MTKit/MTKit/Core/Service/*.{h,m}'
            sss.dependency 'MTKit/Core/Action'
        end
        ss.subspec 'MTMediator' do |sss|
            sss.source_files = 'MTKit/MTKit/Core/MTMediator/*.{h,m}'
            sss.dependency 'MTKit/Category/Foundation/NSString'
        end
    end

    s.subspec 'Component' do |ss|
        ss.source_files = 'MTKit/MTKit/Component/MT_ComponetHeader.h'
        ss.subspec 'MTBanner' do |sss|
            sss.source_files = 'MTKit/MTKit/Component/MTBanner/*'
        end
        ss.subspec 'MTQRCode' do |sss|
            sss.source_files = 'MTKit/MTKit/Component/MTQRCode/*.{h,m}'
            sss.frameworks = 'AVFoundation'
        end
    end

end
