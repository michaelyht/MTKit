#
#  Be sure to run `pod spec lint MTKit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "MTKit"
  s.version      = "0.0.1"
  s.summary      = "MTKit is ios HT Project"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
             0.0.1 项目常用框架
                   DESC

  s.homepage     = "https://github.com/michaelyht/MTKit"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "Michael" => "htlingday@hotmail.com" }
  # Or just: s.author    = "Michael"
  # s.authors            = { "Michael" => "htlingday@hotmail.com" }
  # s.social_media_url   = "http://twitter.com/Michael"

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  # s.platform     = :ios, "8.0"


  s.ios.deployment_target = "8.0"

  #  When using multiple platforms
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  s.source       = { :git => "https://github.com/michaelyht/MTKit.git", :tag => "#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "MTKit/MTKit/MTKit/MTKit.h"
  s.exclude_files = "MTKit/MTKit.xcodeproj"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  
  s.frameworks = 'Foundation', 'CoreGraphics', 'UIKit', 'QuartzCore', 'SystemConfiguration'
  s.libraries = 'sqlite3', 'z'

  # s.framework  = "SomeFramework"
  # s.library   = "iconv"



  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

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
