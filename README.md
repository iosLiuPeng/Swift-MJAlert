# MJAlert

按添加的顺序，依次弹出内容视图（Alert、ActionSheet、UIView、UIViewController等），上一个内容视图关闭后自动弹出下一个


****
## ModuleAlert协议（默认实现）
* 功能: 弹出内容视图 (一次弹出全部，后来者居上)
* 支持弹出: Alert、ActionSheet

详细用法：  
[弹出Alert](#弹出Alert)    
[弹出ActionSheet](#弹出ActionSheet)
[解析原始数据](#解析原始数据)
****
## Alert
* 功能: 弹出内容视图 (按添加顺序弹出，一次一个，关闭后自动弹出下一个)
* 支持弹出: Alert、ActionSheet、UIView、UIViewController  

详细用法：  
[弹出Alert](#弹出Alert)    
[弹出ActionSheet](#弹出ActionSheet)    
[弹出UIView](#弹出UIView)    
[弹出UIViewController](#弹出UIViewController)  
  
  
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
    
    /// 显示一个弹框，有返回值，可自定义，可用于addTextField
    var info = [AlertInfoKey: String]()
    info[.title] = "hello"
    info[.message] = "world"
    info[.cancel] = "取消"
    info[.confirm] = "确定"
    
    let alert = TheAlert.showCustomAlert(info: info, otherButtons: nil) { (index) in
    print("clicked \(index)")
    }
    
    alert.addTextField { (textField) in
    
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
  
#### 解析原始数据
支持将原始数据，解析成Alert模块使用的数据。
因为原始数据里面可能包含国际化信息，所以使用前，请手动加载原始数据里的国际化信息

```json
元素数据格式：
{
    // 国际化key部分，value存的是国际化key，当取不到对应的国际化内容时，会再从下面的“直接内容”中取
    titleKey":"标题的国际化key"
    messageKey":"内容的国际化key"
    cancelKey":"取消按钮的国际化key"
    confirmKey":"确定按钮的国际化key"
    destructiveKey":"破坏性按钮的国际化key"

    // 直接内容
    "title":"标题",
    "message":"内容",
    "cancel":"取消按钮",
    "confirm":"确定按钮",
    "destructive":"破坏性按钮",
    
    // 其他按钮
    "btns":["btn1", "btn2", "btn3", "btn4"]
}
```

使用
```swift
    var dict = [String: Any]()

    let comp = TheAlert.parsingOriginalInfo(dict)

    TheAlert.showAlert(info: comp.info, otherButtons: comp.otherButtons) { (index) in
    print("clicked \(index)")
    }

    TheAlert.showActionSheet(info: comp.info, otherButtons: comp.otherButtons, onView: self.line) { (index) in
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
