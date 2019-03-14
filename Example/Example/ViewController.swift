//
//  ViewController.swift
//  MJAlert
//
//  Created by 刘鹏i on 2019/1/2.
//  Copyright © 2019 wuhan.musjoy. All rights reserved.
//

import UIKit
import MJModule
import MJAlert

class ViewController: UIViewController {
    
    var window: UIWindow?
    var newWindow: UIWindow?
    @IBOutlet var line: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        normalAlertTest()
        
//        defaultAlertTest()
        
//        noTitleAlert()
        
//        addTextFiledAlert()
        
        parsingInfoText()
    }
    
    @IBAction func clickAction(_ sender: Any) {
        TheAlert.showAlert(title: "hello", message: "world") { (index) in
            print("clicked \(index)")
        }
    }
    
    func parsingInfoText() {
        var dict = [String: Any]()
        dict["title"] = "title"
        dict["message"] = "message"
        dict["cancel"] = "cancel"
        dict["confirm"] = ""
        dict["destructive"] = "destructive"
        
        dict["titleKey"] = "titleKey"
        dict["messageKey"] = "messageKey"
        dict["cancelKey"] = "cancelKey"
        dict["confirmKey"] = "confirmKey"
        dict["destructiveKey"] = "destructiveKey"

        let comp = TheAlert.parsingOriginalInfo(dict)
        
        TheAlert.showAlert(info: comp.info, otherButtons: comp.otherButtons) { (index) in
            print("clicked \(index)")
        }
        
        TheAlert.showActionSheet(info: comp.info, otherButtons: comp.otherButtons, onView: self.line) { (index) in
            print("clicked \(index)")
        }
    }
    
    func addTextFiledAlert() {
        var info = [AlertInfoKey: String]()
        info[.title] = "hello"
        info[.message] = "world"
        info[.cancel] = "取消"
        info[.confirm] = "确定"
        
        TheAlert.showAlert(info: info, otherButtons: nil, completion: nil)
                
        let alert = TheAlert.showCustomAlert(info: info, otherButtons: nil) { (index) in
            print("clicked \(index)")
        }
        
        alert.addTextField { (textField) in
            
        }
        
        
        
    }
    
    func noTitleAlert() {
        TheAlert.showAlert(title: nil, message: nil) { (index) in
            print("clicked \(index)")
        }
        
        TheAlert.showAlert(title: "", message: "") { (index) in
            print("clicked \(index)")
        }
        
        TheAlert.showActionSheet(title: nil, message: nil, onView: self.line) { (index) in
            print("clicked \(index)")
        }
        
        var info = [AlertInfoKey: String]()
        info[.cancel] = "取消"
        TheAlert.showActionSheet(info: info, otherButtons: ["btn2", "btn3", "btn4", "btn5"], onView: self.line) { (index) in
            print("clicked \(index)")
        }
    }
    
    func defaultAlertTest() {
        var info = [AlertInfoKey: String]()
        info[.title] = "hello"
        info[.message] = "world"
        info[.cancel] = "取消"
        info[.confirm] = "确定"
        info[.destructive] = "警告"
        
        TheAlert.showAlert(title: "hello", message: "world") { (index) in
            print("clicked \(index)")
        }

        TheAlert.showAlert(title: "hello", message: "world", cancel: "Cancle", confirm: "OK") { (index) in
            print("clicked \(index)")
        }
        
        TheAlert.showAlert(info: info, otherButtons: ["btn1", "btn2"]) { (index) in
            print("clicked \(index)")
        }

        for _ in 1...5 {
            let vc = CustomViewController()
            
            Alert.showViewControler(vc)
            
            vc.closeBlock = {
                Alert.removeViewControler(vc)
            }
        }
        
        
        TheAlert.showActionSheet(title: "hello", message: "world", onView: self.line) { (index) in
            print("clicked \(index)")
        }

        TheAlert.showActionSheet(title: "hello", message: "world", cancel: "Cancle", confirm: "OK", onView: self.line) { (index) in
            print("clicked \(index)")
        }

        TheAlert.showActionSheet(info: info, otherButtons: ["btn2", "btn3", "btn4", "btn5"], onView: self.line) { (index) in
            print("clicked \(index)")
        }
        
        for _ in 1...5 {
            if let view = Bundle.main.loadNibNamed(String(describing: CustomView.self), owner: nil, options: nil)?.first as? CustomView {
                view.center = CGPoint(x: self.view.bounds.width / 2.0 , y: self.view.bounds.height / 2.0)
                Alert.showView(view)
                
                view.closeBlock = {
                    Alert.removeView(view)
                }
            }
        }
        
    }
    
    func normalAlertTest() {
        let alert = UIAlertController(title: "hello", message: "world", preferredStyle: .actionSheet)
        //        self.present(alert, animated: true, completion: nil)
        //        alert.addAction(UIAlertAction(title: "cancel", style: .default, handler: { (AlertAction) in
        //            print("点击了取消按钮")
        //        }))
        
        //        let view = UIApplication.shared.delegate?.window
        //        let view1 = view!!
        //        var rect = view1.bounds
        //        rect.origin.y = rect.size.height
        //        rect.size.height = 1
        //
        //        alert.popoverPresentationController?.sourceView = view1
        //        alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: view1.bounds.size.height, width: view1.bounds.size.width, height: 1)
        
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = UIColor.clear
        rootVC.view.alpha = 0.0
        
        let newWindow = UIWindow(frame: UIScreen.main.bounds)
        newWindow.rootViewController = rootVC
        newWindow.windowLevel = .alert
        newWindow.makeKeyAndVisible()
        
        self.newWindow = newWindow
        
        //        DispatchQueue(label: "T##String").aft
        self.newWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
}

