Pod::Spec.new do |s|
    s.name            = "Swift-MJAlert"
    s.module_name     = 'MJAlert'

    s.version         = "0.1.0"
    s.swift_version   = '5.0'
    s.summary         = "This is a module management center in swift"
    s.homepage        = "https://github.com/iosLiuPeng/Swift-MJAlert"
    s.license         = { :type => 'MIT', :file => 'LICENSE' }
    s.author          = { 'iosLiuPeng' => '392009255@qq.com' }
    s.source          = { :git => "https://github.com/iosLiuPeng/Swift-MJAlert.git", :tag => "v-#{s.version}" }
    s.ios.deployment_target = '8.0'
    s.source_files    = 'Classes/*'
    s.user_target_xcconfig = {
       'OTHER_SWIFT_FLAGS' => '-DMODULE_ALERT'
    }
    s.dependency "Swift-MJModule/Alert"
    s.dependency "Swift-MJModule/Localize"

    s.prepare_command = 'exit 0;ModuleRegister:"Alert"            : "MJAlert.Alert"'
end
