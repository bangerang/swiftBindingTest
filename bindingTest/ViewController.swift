//
//  ViewController.swift
//  bindingTest
//
//  Created by David Ventura on 2017/05/29.
//  Copyright © 2017年 Propellerhead AB. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	var observation: NSKeyValueObservation?
	
    @IBAction func sliderChanged(_ sender: UISlider) {
        viewModel.applySliderValue(Int(sender.value * 100))
    }
	@IBOutlet weak var playButton: UIButton!
	@IBOutlet weak var macroSlider: UISlider!
    @IBOutlet weak var sliderLabel: UILabel!
	
	var viewModel: PHMainViewModel = GetMainViewModelInstance()
	
	override func viewDidLoad() {
        
		super.viewDidLoad()
		
		observation = viewModel.observe(\.sliderValue) { object, change in
			self.sliderLabel.text = "\(object.sliderValue!)"
		}
        
	}
}

