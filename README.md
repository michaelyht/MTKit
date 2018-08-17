# MTKit
Common development library

pod：

pod 'MTKit', :git => "https://github.com/michaelyht/MTKit", :branch => 'master'

remark：

该框架使用的第三方库包括(AFNetworking、YYCache)，引入该框架不需要再引入这两个第三方库，如果原工程使用了该库，请移除该库，然后在引入了MTKit.h后，不影响之前的使用。

使用该框架，需下载https://github.com/michaelyht/MTConfig.git
两个配置文件，进行网络层key值和签名的配置信息。（MT_Config.plist, MT_Signature.plist）两个文件.
	MT_Config.plist
    
    
    
    2018.8.17
    add MTLogUtil
    
    USSE:
    在AppDelegate里面[MTLogUtil logOpen];当然基本的宏定义还是需要配置的CONSOLE_LOG_ON、FILE_LOG_ON


