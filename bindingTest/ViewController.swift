//
//  ViewController.swift
//  bindingTest
//
//  Created by David Ventura on 2017/05/29.
//  Copyright © 2017年 Propellerhead AB. All rights reserved.
//

import UIKit
import RxSwift
import ReactiveCocoa
import ReactiveSwift
import Bond
import ReactiveKit

class ViewController: UIViewController {

    @IBAction func sliderChanged(_ sender: UISlider) {
        viewModel?.applySliderValue(Int(sender.value * 100))
    }
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var macroSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
    
    var binder: Binder!
    var viewModel = GetMainViewModelInstance()
	override func viewDidLoad() {
        
		super.viewDidLoad()
        
        self.binder = Binder(object: viewModel!)
        
        let keyPath = NSStringFromSelector(#selector(getter: viewModel?.sliderValue))
        
        self.sliderLabel.reactive.text <~ binder.mutableIntProperty(keypath: keyPath).map{number in
            return "\(number)"
        }
        
	}
}

