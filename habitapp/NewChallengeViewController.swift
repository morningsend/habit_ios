//
//  NewChallengeViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 09/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class TextFieldPickerInputDelegate : NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
    }
}

class NewChallengeViewController : UIViewController {
    
    static func instantiateFromMainStoryboard() -> NewChallengeViewController? {
        return UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(
                withIdentifier: String(describing: NewChallengeViewController.self)
            )
            as? NewChallengeViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    var durationPicker: UIPickerView!
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var cancelBarButton: UIBarButtonItem!
    @IBOutlet var durationField: UITextField!
    
    var selectedDurationDays: Int? = nil
    var challengeTitle: String? = nil
    var durationFieldDelegate = TextFieldPickerInputDelegate()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    var durationPickerBar: UIToolbar!
    
    private func setupUI() {
        // cancel button
        cancelBarButton.setTarget(target: self, action: #selector(self.cancel(sender:)))
        
        
        // create button
        createButton.isEnabled = false
        createButton.addTarget(self,
                               action: #selector(create(sender:)),
                               for: .touchUpInside)
        // title text field
        titleField.delegate = self
        durationPicker = UIPickerView()
        // duration picker
        durationPicker.delegate = self
        durationPicker.dataSource = self
        durationPicker.showsSelectionIndicator = true
        durationPicker.backgroundColor? = UIColor.black
        // keyboard management
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard(sender:)))
        self.view.addGestureRecognizer(tap)
        
        durationField.delegate = durationFieldDelegate
        durationField.inputView = durationPicker
        
        durationPickerBar = UIToolbar()
        
        durationPickerBar.barStyle = .blackTranslucent
        durationPickerBar.isUserInteractionEnabled = true
        let doneBarItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(closePicker(sender:)))
        doneBarItem.tintColor = UIColor.lightGray
        durationPickerBar.setItems([doneBarItem], animated: false)
        durationPickerBar.sizeToFit()
        
        durationField.inputAccessoryView = durationPickerBar
        
        titleField.padLeft(points: 12)
        durationField.padLeft(points: 12)
        
        titleField.layer.cornerRadius = 4
        titleField.clipsToBounds = true
        durationField.layer.cornerRadius = 4
        durationField.clipsToBounds = true
    }
    
    @objc
    func closePicker(sender: Any) {
        durationField.resignFirstResponder()
    }
    
    @objc
    func closeKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc
    func cancel(sender: UIBarButtonItem) {
        print("cancelling")
        dismissSelf()
    }
    
    private func dismissSelf() {
        if let nav = self.navigationController {
            nav.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
            print("dismissing")
        }
    }
    
    @objc
    func create(sender: UIButton) {
        dismissSelf()
    }
    
    func updateDisplayDuration(_ display: String?) {
        durationField.text = display
    }
    
    func validate() {
        guard selectedDurationDays != nil else {
            createButton.isEnabled = false
            return
        }
        guard challengeTitle != nil else {
            createButton.isEnabled = false
            return
        }
        
        if(selectedDurationDays! >= 1 && selectedDurationDays! <= 30) {
            if(!challengeTitle!.isEmpty) {
               createButton.isEnabled = true
                return
            }
        }
        createButton.isEnabled = false
    }
}

extension NewChallengeViewController : UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
        challengeTitle = textField.text
        validate()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}

extension NewChallengeViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return NewChallengeViewController.maxDurationDays - NewChallengeViewController.minDurationDays + 1
    }
    
    static let minDurationDays = 1
    static let maxDurationDays = 30
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let text = "\(row+NewChallengeViewController.minDurationDays) Days"
        return text
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 32
    }
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let text = "\(row+NewChallengeViewController.minDurationDays) Days"
        return NSAttributedString(string: text, attributes: [
            NSAttributedString.Key.foregroundColor: UIColor.white
            ])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedDurationDays = NewChallengeViewController.minDurationDays + row
        updateDisplayDuration(self.pickerView(pickerView, titleForRow: row, forComponent: component))
        validate()
    }
}
