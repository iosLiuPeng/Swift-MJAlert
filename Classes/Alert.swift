//
//  Alert.swift
//  MJAlert
//
//  Created by 刘鹏i on 2018/11/30.
//

import Foundation
import MJModule

// MARK: - Alert
public class Alert: ModuleAlert {
    /// 单例
    public static let shared = Alert()
    private init() {}
    
    /// 保存上一个keyWindow
    weak var preKeyWindow: UIWindow?
    
    /// alert所在的Window
    var alertWindow: UIWindow?
    
    /// 将要显示的弹框数组
    var viewControllers = [UIViewController]() {
        didSet {
            // 数组容量改变时，自动弹出下个弹框
            
            if oldValue.count < viewControllers.count {
                // 添加弹框
                if oldValue.count == 0 {
                    // 创建Window
                    alertWindow = createAlertWindow()
                    // 弹出
                    show(viewControllers.first!)
                }
            } else {
                // 减少弹框
                if viewControllers.count == 0 {
                    // 移除Window
                    removeAlertWindow()
                } else {
                    // 弹出下一个
                    show(viewControllers.first!)
                }
            }
        }
    }

    /// 弹出自定义视图记录
    var customViewRecord  = [UIView: UIViewController]()
}

// MARK: - Show Alert
extension Alert {

    /// 显示一个弹框，自带确定按钮
    public static func showAlert(title: String?, message: String?, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        
        Alert.shared.add(.alert, info: info, otherButtons: nil, onView: nil, completion: completion)
    }
    
    /// 显示一个弹框，自己处理按钮本地化
    public static func showAlert(title: String?, message: String?, cancel: String?, confirm: String?, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        info[.cancel] = cancel
        info[.confirm] = confirm
        
        Alert.shared.add(.alert, info: info, otherButtons: nil, onView: nil, completion: completion)
    }
    
    /// 显示一个弹框，支持多个按钮，自己处理按钮本地化
    public static func showAlert(info: [AlertInfoKey: String], otherButtons: String..., completion: AlertCompletion?) {
        Alert.shared.add(.alert, info: info, otherButtons: otherButtons, onView: nil, completion: completion)
    }
}

// MARK: - Show ActionSheet
extension Alert {
    
    /// 显示一个ActionSheet，自带确定按钮
    public static func showActionSheet(title: String?, message: String?, onView: UIView, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        
        Alert.shared.add(.actionSheet, info: info, otherButtons: nil, onView: onView, completion: completion)
    }
    
    /// 显示一个ActionSheet，自己处理按钮本地化
    public static func showActionSheet(title: String?, message: String?, cancel: String?, confirm: String?, onView: UIView, completion: AlertCompletion?) {
        var info = [AlertInfoKey: String]()
        info[.title] = title
        info[.message] = message
        info[.cancel] = cancel
        info[.confirm] = confirm
        
        Alert.shared.add(.actionSheet, info: info, otherButtons: nil, onView: onView, completion: completion)
    }
    
    /// 显示一个ActionSheet，支持多个按钮，自己处理按钮本地化
    public static func showActionSheet(info: [AlertInfoKey: String], otherButtons: String..., onView: UIView, completion: AlertCompletion?) {
        Alert.shared.add(.actionSheet, info: info, otherButtons: otherButtons, onView: onView, completion: completion)
    }
}

// MARK: - Show Custom ViewController
extension Alert {
    
    /// 弹出一个控制器，需要自己掉自己手动调移除方法
    public static func showViewControler(_ viewControler: UIViewController)  {
        Alert.shared.viewControllers.append(viewControler)
    }
    
    /// 移除指定控制器
    public static func removeViewControler(_ viewControler: UIViewController) {

        let firstIndex = Alert.shared.viewControllers.firstIndex(of: viewControler)
        if let index = firstIndex {
            if let presenting = viewControler.presentingViewController {
                // 如果正在显示，先dismiss
                presenting.dismiss(animated: true) {
                    // 数组中移除
                    Alert.shared.viewControllers.remove(at: index)
                }
            } else {
                // 数组中移除
                Alert.shared.viewControllers.remove(at: index)
            }
        }
    }
}

// MARK: - Show View
extension Alert {
    
    /// 显示一个自定义视图，需要自己手动调移除方法
    public static func showView(_ view: UIView) {
        let viewController = UIViewController()
        viewController.view.backgroundColor = UIColor.clear
        
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        viewController.view.addSubview(view)
        
        Alert.shared.customViewRecord[view] = viewController
        Alert.shared.viewControllers.append(viewController)
    }
    
    /// 移除指定视图
    public static func removeView(_ view: UIView) {
        if let viewController = Alert.shared.customViewRecord[view] {
            Alert.shared.customViewRecord.removeValue(forKey: view)
            
            viewController.presentingViewController?.dismiss(animated: true, completion: {
                Alert.removeViewControler(viewController)
            })
        }
    }
}

// MARK: - Window
extension Alert {
    
    /// 上一个keyWindow
    var keyWindow: UIWindow {
        if let preWindow = preKeyWindow {
            // 先取记录的上一个keyWindow
            return preWindow
        } else if let window = UIApplication.shared.delegate?.window, let mainWindow = window {
            // 没有的话，取mainWindow
            return mainWindow
        } else {
            // 还是没有的话，取最上层window
            return UIApplication.shared.windows.last!
        }
    }
    
    /// 创建AlertWindow
    func createAlertWindow() -> UIWindow {
        guard alertWindow == nil else { return alertWindow! }
        
        // 记录keyWindow，以便之后恢复keyWindow
        preKeyWindow = UIApplication.shared.keyWindow
        
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = UIColor.clear
        
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.rootViewController = rootVC
        newWindow.windowLevel = .alert
        newWindow.makeKeyAndVisible()
        
        return newWindow
    }
    
    /// 销毁AlertWindow
    func removeAlertWindow() {
        guard let alertWindow = alertWindow else { return }
        
        alertWindow.rootViewController?.dismiss(animated: false, completion: nil)
        
        // 这里不用makeKeyAndVisible，因为原keyWindow的hidden可能就是false
        // resignKey()方法是不能用于主动失去keyWindow的，且不能主动调用的，只能重写
        keyWindow.makeKey()
        preKeyWindow = nil
        self.alertWindow = nil
    }
}

// MARK: - Add
extension Alert {
    /// 添加一个弹框
    func add(_ style: UIAlertController.Style, info: [AlertInfoKey: String], otherButtons: [String]?, onView: UIView?, completion: AlertCompletion?) {
        let title = info[.title]
        let message = info[.message]
        
        // 标题或内容必有一个
        guard title != nil || message != nil else { return }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        var offset = 1;/// .default样式按钮的序号
        
        /// 弹框关闭回调
        func closeBlock(_ index: Int) {
            completion?(index)
            
            // 移除第一个（这里可能出现重复添加同一个alert对象，所以不将所有的都一次移除，加几个就弹几次）
            let firstIndex = viewControllers.firstIndex(of: alert)
            if let index = firstIndex {
                viewControllers.remove(at: index)
            }
        }
        
        // 取消
        if let cancel = info[.cancel] {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (AlertAction) in
                closeBlock(0)
            }))
        }
        
        // 确定
        if let confirm = info[.confirm] {
            alert.addAction(UIAlertAction(title: confirm, style: .default, handler: { (AlertAction) in
                closeBlock(1)
            }))
            offset += 1
        }
        
        // 取消、确定按钮必须有一个（除了无按钮样式）
        if alert.actions.count == 0 {
            alert.addAction(UIAlertAction(title: localizeString(.OK), style: .default, handler: { (AlertAction) in
                closeBlock(1)
            }))
            offset += 1
        }
        
        // 破坏性操作
        if let destructive = info[.destructive] {
            alert.addAction(UIAlertAction(title: destructive, style: .destructive, handler: { (AlertAction) in
                closeBlock(-1)
            }))
        }
        
        // 其他按钮
        if let otherButtons = otherButtons {
            for title in otherButtons {
                let index = offset
                alert.addAction(UIAlertAction(title: title, style: .default, handler: { (AlertAction) in
                    closeBlock(index)
                }))
                
                offset += 1
            }
        }
        
        // ipad上 .actionSheet样式要特殊处理
        if UIDevice.current.userInterfaceIdiom == .pad && style == .actionSheet {
            // 必须要有一个按钮，不然点其他地方弹框消失了，window没消失
            if  alert.actions.count == 0 {
                alert.addAction(UIAlertAction(title: localizeString(.Cancel) , style: .cancel, handler: { (AlertAction) in
                    closeBlock(0)
                }))
            }
            
            // ipad上，必须要设置依靠的视图
            if let onView = onView {
                alert.popoverPresentationController?.sourceView = onView
                alert.popoverPresentationController?.sourceRect = onView.bounds
            }
        }
    
        // 加入弹框数组，会自动弹出
        viewControllers.append(alert)
    }
}

// MARK: - Show
extension Alert {
    
    /// 显示弹框
    func show(_ viewController: UIViewController) {
        guard let rootVC = alertWindow?.rootViewController else { return }
        
        rootVC.present(viewController, animated: true, completion: nil)
    }
    
}


// MARK: - Localize
extension Alert {
    /// 可以国际化的文案
    enum LocalizeKey: String {
        case OK
        case Cancel
    }
    
    /// 国际化文案（只有中、英、繁）
    func localizeString(_ key: LocalizeKey) -> String {
        var str = key.rawValue
        
        guard let language = Locale.preferredLanguages.first else { return str }
        
        switch language {
        case let lan where lan.hasPrefix("zh"):
            if lan.range(of: "Hans") != nil {
                // 简体中文
                switch key {
                case .OK:
                    str = "确定"
                case .Cancel:
                    str = "取消"
                }
            } else {
                // 繁體中文
                switch key {
                case .OK:
                    str = "確定"
                case .Cancel:
                    str = "取消"
                }
            }
        default:
            // 英语
            break
        }

        return str
    }
}
