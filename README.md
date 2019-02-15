# MJAlert
----
按添加的顺序，依次弹出内容视图（Alert、ActionSheet、UIView、UIViewController等），上一个内容视图关闭后自动弹出下一个


****
## ModuleAlert协议（默认实现）
* 功能: 弹出内容视图 (一次弹出全部，后来者居上)
* 支持弹出: Alert、ActionSheet

详细用法见：
[弹出Alert](#弹出Alert)  

[弹出ActionSheet](#弹出ActionSheet)

****
## Alert
* 功能: 弹出内容视图 (按添加顺序弹出，一次一个，关闭后自动弹出下一个)
* 支持弹出: Alert、ActionSheet、UIView、UIViewController  


#### 弹出Alert
```swift
	/// 显示一个弹框，带有确定按钮
    TheAlert.showAlert(title: "hello", message: "world") { (index) in
        print("clicked \(index)")
    }

    /// 显示一个弹框，自己处理按钮本地化
    TheAlert.showAlert(title: "hello", message: "world", cancel: "Cancle", confirm: "OK") { (index) in
        print("clicked \(index)")
    }
    
    /// 显示一个弹框，支持多个按钮，自己处理按钮本地化
    var info = [AlertInfoKey: String]()
    info[.title] = "hello"
    info[.message] = "world"
    info[.cancel] = "Cancle"
    info[.confirm] = "OK"
    info[.destructive] = "Destructive"

    TheAlert.showAlert(info: info, otherButtons: "btn1", "btn2") { (index) in
        print("clicked \(index)")
    }
```
  
  
#### 弹出ActionSheet
使用ActionSheet样式时，必须传入弹出框所依靠的视图。（ipad上ActionSheet样式需要）

```swift
    /// 显示一个ActionSheet，带有确定按钮
    TheAlert.showActionSheet(title: "hello", message: "world", onView: aSourceView) { (index) in
        print("clicked \(index)")
    }
    
    /// 显示一个ActionSheet，自己处理按钮本地化
    TheAlert.showActionSheet(title: "hello", message: "world", cancel: "Cancle", confirm: "OK", onView: aSourceView) { (index) in
        print("clicked \(index)")
    }
    
    /// 显示一个ActionSheet，支持多个按钮，自己处理按钮本地化
    var info = [AlertInfoKey: String]()
    info[.title] = "hello"
    info[.message] = "world"
    info[.cancel] = "Cancle"
    info[.confirm] = "OK"
    info[.destructive] = "Destructive"
    
    TheAlert.showActionSheet(info: info, otherButtons: "btn2", "btn3", "btn4", "btn5", onView: aSourceView) { (index) in
        print("clicked \(index)")
    }
```
  
  
#### 弹出UIView
```swift
    /// 显示一个自定义视图，需要自己手动调移除方法
    Alert.showView(aView)

    /// 移除指定视图
    Alert.removeView(view)

    /// 自己在合适的时机，调用关闭方法。一般需要自己提供一个关闭视图回调，如下
    aView.closeBlock = {
        Alert.removeView(view)
    }
```

  
  
#### 弹出UIViewController
```swift
    /// 弹出一个控制器，需要自己掉自己手动调移除方法
    Alert.showViewControler(aViewController)

    /// 移除指定控制器
    Alert.removeViewControler(aViewController)

    /// 自己在合适的时机，调用关闭方法。一般需要自己提供一个关闭视图控制器回调，如下
    aViewController.closeBlock = {
        Alert.removeViewControler(aViewController)
    }
```
