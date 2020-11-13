//
//  DPPickerManager.swift
//
//
//  Created by Danilo Priore on 06/12/17.
//  Copyright © 2018 Danilo Priore. All rights reserved.
//

import UIKit

public typealias DPPickerCompletion = (_ cancel: Bool) -> Void
public typealias DPPickerDateCompletion = (_ date: Date?, _ cancel: Bool) -> Void
public typealias DPPickerValueIndexCompletion = (_ value: String?, _ index: Int, _ cancel: Bool) -> Void

open class DPPickerManager: NSObject, UIPickerViewDelegate, UIPickerViewDataSource {
    
    public static let shared = DPPickerManager()

    private typealias PickerCompletionBlock  = (_ cancel: Bool) -> Void

    private var alertView: UIAlertController?
    private var pickerValues: [String]?
    private var pickerCompletion: PickerCompletionBlock?
    
    @objc open var timeZone: TimeZone? = TimeZone(identifier: "EN")
    
    // MARK: - Show
    
    @objc open func showPicker(title: String?, selected: Date?, completion:DPPickerDateCompletion?) {
        let currentDate = Date()
        let gregorian = NSCalendar(calendarIdentifier: .gregorian)
        var components = DateComponents()
        
        components.year = -110
        let minDate = gregorian?.date(byAdding: components, to: currentDate, options: NSCalendar.Options(rawValue: 0))
        self.showPicker(title: title, selected: selected, min: minDate, max: currentDate, completion: completion)
    }
    
    @objc open func showPicker(title: String?, selected: Date?, min: Date?, max: Date?, completion:DPPickerDateCompletion?) {
        self.showPicker(title: title, picker: { (picker) in
            picker.date = selected ?? Date()
            picker.minimumDate = min
            picker.maximumDate = max
            picker.timeZone = self.timeZone
            picker.datePickerMode = .date
        }, completion: completion)
    }
    
    @objc open func showPicker(title: String?, picker:((_ picker: UIDatePicker) -> Void)?, completion:DPPickerDateCompletion?) {
        let datePicker = UIDatePicker()
        datePicker.timeZone = self.timeZone
        
        picker?(datePicker)
        
        self.showPicker(title: title, view: datePicker) { (cancel) in
            completion?(datePicker.date, cancel)
        }
    }
    
    @objc open func showPicker(title: String?, selected: String?, strings:[String], completion:DPPickerValueIndexCompletion?) {
        self.pickerValues = strings
        
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        if let value = selected {
            picker.reloadAllComponents()
            if strings.count > 0 {
                OperationQueue.current?.addOperation {
                    let index = strings.index(of: value) ?? 0
                    picker.selectRow(index, inComponent: 0, animated: false)
                }
            }
        }

        self.showPicker(title: title, view: picker) { (cancel) in
            
            var index = -1
            var value: String? = nil
            
            if !cancel, strings.count > 0 {
                index = picker.selectedRow(inComponent: 0)
                if index >= 0 {
                    value = self.pickerValues?[index]
                }
            }
            
            completion?(value, index, cancel || index < 0)
        }
    }
    
    @objc open func showPicker(title: String?, view: UIView, completion:DPPickerCompletion?) {
        
        var center: CGFloat?
        var buttonX: CGFloat = 0
        
        let image = UIImage(named: "ic_close")?.withRenderingMode(.alwaysTemplate)
        
        // trick
        let alertView = UIAlertController(title: title, message: "\n\n\n\n\n\n\n\n\n\n", preferredStyle: .actionSheet);
        alertView.view.addSubview(view)
        alertView.popoverPresentationController?.sourceView = UIViewController.top?.view
        alertView.popoverPresentationController?.sourceRect = view.bounds
        alertView.view.tintColor = .gray
        self.alertView = alertView

        // device orientation
        switch UIApplication.shared.statusBarOrientation {
        case .landscapeLeft, .landscapeRight:
            center = UIViewController.top?.view.center.y
            buttonX = alertView.view.frame.size.height - (image!.size.height * 2)
        case .portrait, .portraitUpsideDown:
            center = UIViewController.top?.view.center.x
            buttonX = alertView.view.frame.size.width - (image!.size.width * 2)
        default: break
        }
        
        view.center.x = center ?? 0
        view.transform = .init(translationX: -10, y: title != nil ? 35 : 0)
        
        self.pickerCompletion = completion
        
        // close button
        let close = UIButton(frame: CGRect(x: buttonX - 10 , y: 10, width: image!.size.width, height: image!.size.height))
        close.tintColor = .gray
        close.setImage(image!, for: .normal)
        close.addTarget(self, action: #selector(pickerClose(_:)), for: .touchUpInside)
        alertView.view.addSubview(close)

        // ok button
        let ok = UIAlertAction(title: "Ok", style: .default) { (action) in
            completion?(false)
        }
        alertView.addAction(ok)
        
        UIViewController.top?.present(alertView, animated: true, completion: nil)
        
    }
    
    // MARK: - Picker Delegates
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerValues?.count == 0 ? 0 : 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerValues?.count ?? 0
    }
    
    public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues?[row]
    }
    
    @objc internal func pickerClose(_ sender: UIButton) {
        alertView?.dismiss(animated: true, completion: {
            self.pickerCompletion?(true)
        })
    }
    
}

internal extension UIViewController {

    static var top: UIViewController? {
        get {
            return topViewController()
        }
    }

    static var root: UIViewController? {
        get {
            return UIApplication.shared.delegate?.window??.rootViewController
        }
    }

    static func topViewController(from viewController: UIViewController? = UIViewController.root) -> UIViewController? {
        if let tabBarViewController = viewController as? UITabBarController {
            return topViewController(from: tabBarViewController.selectedViewController)
        } else if let navigationController = viewController as? UINavigationController {
            return topViewController(from: navigationController.visibleViewController)
        } else if let presentedViewController = viewController?.presentedViewController {
            return topViewController(from: presentedViewController)
        } else {
            return viewController
        }
    }
    
}
