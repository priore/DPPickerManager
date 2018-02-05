# DPPickerManager

[![CI Status](http://img.shields.io/travis/priore/DPPickerManager.svg?style=flat)](https://travis-ci.org/priore/DPPickerManager)
[![Version](https://img.shields.io/cocoapods/v/DPPickerManager.svg?style=flat)](http://cocoapods.org/pods/DPPickerManager)
[![License](https://img.shields.io/cocoapods/l/DPPickerManager.svg?style=flat)](http://cocoapods.org/pods/DPPickerManager)
[![Language](https://img.shields.io/badge/language-Swift-orange.svg?style=flat)]()
[![Supports](https://img.shields.io/badge/supports-CocoaPods-green.svg?style=flat)]()
[![Platform](https://img.shields.io/cocoapods/p/DPPickerManager.svg?style=flat)](http://cocoapods.org/pods/DPPickerManager)
<br />

[![Twitter: @DaniloPriore](https://img.shields.io/badge/contact-@DaniloPriore-blue.svg?style=flat)](https://twitter.com/DaniloPriore)
[![Documentation](https://img.shields.io/badge/Documentation-available-0D2D54.svg)](https://priore.github.io/DPPickerManager/)

UIPicker inside a UIAlertController

![](/DPPickerManager/DPPickerManager.gif)

**HOW TO USE :**

```swift

// Strings Picker
let values = ["Value 1", "Value 2", "Value 3", "Value 4"]
DPPickerManager.shared.showPicker(title: "Strings Picker", selected: "Value 1", strings: values) { (value, index, cancel) in
    if !cancel {
        // TODO: you code here
        debugPrint(value as Any)
    }
}
```


```swift
// Date Picker
let min = Date()
let max = min.addingTimeInterval(31536000) // 1 year
DPPickerManager.shared.showPicker(title: "Date Picker", selected: Date(), min: min, max: max) { (date, cancel) in
    if !cancel {
        // TODO: you code here
        debugPrint(date as Any)
    }
}
```

```swift
// Time Picker (custom picker)
DPPickerManager.shared.showPicker(title: "Time Picker", picker: { (picker) in
    picker.date = Date()
    picker.datePickerMode = .time
}) { (date, cancel) in
    if !cancel {
        // TODO: you code here
        debugPrint(date as Any)
    }
}
```

