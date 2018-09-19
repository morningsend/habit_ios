//
//  NewChallengeViewController.swift
//  ThirtyDayChallengePrototype
//
//  Created by Zaiyang Li on 09/09/2018.
//  Copyright © 2018 smallteam. All rights reserved.
//

import Foundation
import UIKit

class NewChallengeViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
    }
    
    @IBOutlet var durationPicker: UIPickerView!
    @IBOutlet var durationButton: UIButton!
    @IBOutlet var titleField: UITextField!
    @IBOutlet var createButton: UIButton!
    @IBOutlet var cancelBarButton: UIBarButtonItem!
    
    var selectedDurationDays: Int? = nil
    var challengeTitle: String? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        //duration button
        durationButton.addTarget(self,
                                 action: #selector(showDurationPicker(sender:)),
                                 for: .touchUpInside)
        
        
        // duration picker
        durationPicker.isHidden = true
        durationPicker.delegate = self
        durationPicker.dataSource = self
        durationPicker.showsSelectionIndicator = true
        
        // keyboard management
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeKeyboard(sender:)))
        self.view.addGestureRecognizer(tap)
    }
    
    @objc
    func closeKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
        self.durationPicker.isHidden = true
    }
    
    @objc
    func cancel(sender: UIBarButtonItem) {
        dismissSelf()
    }
    
    private func dismissSelf() {
        if(self.isBeingPresented) {
            self.dismiss(animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @objc
    func create(sender: UIButton) {
        dismissSelf()
    }
    
    @objc
    func showDurationPicker(sender: UIButton) {
        if(durationPicker.isHidden) {
            durationPicker.isHidden = false
        }
    }
    
    func updateDisplayDuration(_ display: String?) {
        self
            .durationButton
            .titleLabel?
            .text = display
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
