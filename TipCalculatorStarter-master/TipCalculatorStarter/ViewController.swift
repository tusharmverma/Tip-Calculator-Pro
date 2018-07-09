//
//  ViewController.swift
//  TipCalculatorStarter
//
//  Created by Chase Wang on 9/19/17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var headerView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var themeSwitch: UISwitch!
    @IBOutlet var billAmountTextField: BillAmountTextField!
    @IBOutlet var tipPercentSegmentedControl: UISegmentedControl!
    @IBOutlet var selectedSegmentIndex: UISegmentedControl!
    @IBOutlet var outputCardView: UIView!
    @IBOutlet var inputCardView: UIView!
    @IBOutlet var tipAmountTitleLabel: UILabel!
    @IBOutlet var tipAmountLabel: UILabel!
    @IBOutlet var totalAmountTitleLabel: UILabel!
    @IBOutlet var totalAmountLabel: UILabel!
    @IBOutlet var resetButton: UIButton!
    
    // MARK: - View Lifecycle
    
    // MARK: - Properties
    
    // 1
    var isDefaultStatusBar = true
    
    // 2
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDefaultStatusBar ? .default : .lightContent
    }
    
    // ...
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setTheme(isDark: false)

        billAmountTextField.calculateButtonAction = {
            self.calculate()
        }
    }
    
    func calculate() {
        // dismiss keyboard
        // dismiss keyboard
        if self.billAmountTextField.isFirstResponder {
            self.billAmountTextField.resignFirstResponder()
        }
        
        guard let billAmountText = self.billAmountTextField.text,
            let billAmount = Double(billAmountText) else {
                clear()
                return
        }
        
        // ...
        
        let roundedBillAmount = (100 * billAmount).rounded() / 100
        
        let tipPercent: Double
        switch tipPercentSegmentedControl.selectedSegmentIndex {
        case 0:
            tipPercent = 0.15
        case 1:
            tipPercent = 0.18
        case 2:
            tipPercent = 0.20
        default:
            preconditionFailure("Unexpected index.")
        }
        
        let tipAmount = roundedBillAmount * tipPercent
        let roundedTipAmount = (100 * tipAmount).rounded() / 100
        
        let totalAmount = roundedBillAmount + roundedTipAmount
        
        // Update UI
        self.billAmountTextField.text = String(format: "%.2f", roundedBillAmount)
        self.tipAmountLabel.text = String(format: "%.2f", roundedTipAmount)
        self.totalAmountLabel.text = String(format: "%.2f", totalAmount)
    }
    
    func clear() {
        billAmountTextField.text = nil
        tipPercentSegmentedControl.selectedSegmentIndex = 0
        tipAmountLabel.text = "$0.00"
        totalAmountLabel.text = "$0.00"
    }
    
    func setupViews() {
        headerView.layer.shadowOffset = CGSize(width: 0, height: 1)
        headerView.layer.shadowOpacity = 0.05
        headerView.layer.shadowColor = UIColor.black.cgColor
        headerView.layer.shadowRadius = 35
        
        
        inputCardView.layer.cornerRadius = 8
        inputCardView.layer.masksToBounds = true
        

        outputCardView.layer.cornerRadius = 8
        outputCardView.layer.masksToBounds = true
        
        // set output card border
        outputCardView.layer.borderWidth = 1
        outputCardView.layer.borderColor = UIColor.tcHotPink.cgColor
        
        resetButton.layer.cornerRadius = 8
        resetButton.layer.masksToBounds = true
    }
    
    func setTheme(isDark: Bool) {
        let theme = isDark ? ColorTheme.dark : ColorTheme.light
        
        view.backgroundColor = theme.viewControllerBackgroundColor
        
        headerView.backgroundColor = theme.primaryColor
        titleLabel.textColor = theme.primaryTextColor
        
        inputCardView.backgroundColor = theme.secondaryColor
        
        billAmountTextField.tintColor = theme.accentColor
        tipPercentSegmentedControl.tintColor = theme.accentColor
        
        outputCardView.backgroundColor = theme.primaryColor
        outputCardView.layer.borderColor = theme.accentColor.cgColor
        
        tipAmountTitleLabel.textColor = theme.primaryTextColor
        totalAmountTitleLabel.textColor = theme.primaryTextColor
        
        tipAmountLabel.textColor = theme.outputTextColor
        totalAmountLabel.textColor = theme.outputTextColor
        
        resetButton.backgroundColor = theme.secondaryColor
        
        isDefaultStatusBar = theme.isDefaultStatusBar
        setNeedsStatusBarAppearanceUpdate()
    }
    
    @IBAction func themeToggled(_ sender: UISwitch) {
        setTheme(isDark: sender.isOn)
    }
    
    @IBAction func tipPercentChanged(_ sender: UISegmentedControl) {
        calculate()
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        clear()
        print ("Reset Button Tapped!")
    }
}

