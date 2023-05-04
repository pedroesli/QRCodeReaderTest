//
//  MainViewController.swift
//  QRCodeReaderTest
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/05/23.
//

import UIKit

class MainViewController: UIViewController {
    
    let segmentedControlItems = ["Generate QRCode", "Scan QRCode"]
    
    lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: segmentedControlItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let generateVC: QRCodeGenerateViewController = {
        let generateVC = QRCodeGenerateViewController()
        generateVC.view.translatesAutoresizingMaskIntoConstraints = false
        return generateVC
    }()
    
    let scanVC: ScanQRCodeViewController = {
        let scanVC = ScanQRCodeViewController()
        scanVC.view.isHidden = true
        scanVC.view.translatesAutoresizingMaskIntoConstraints = false
        return scanVC
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanVC.mainVC = self

        title = segmentedControlItems[0]
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(scanVC.view)
        view.addSubview(generateVC.view)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scanVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            scanVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scanVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scanVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            generateVC.view.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10),
            generateVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            generateVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            generateVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        title = segmentedControlItems[sender.selectedSegmentIndex]
        
        generateVC.textField.resignFirstResponder()
        
        if sender.selectedSegmentIndex == 0 {
            generateVC.view.isHidden = false
            scanVC.view.isHidden = true
        } else {
            generateVC.view.isHidden = true
            scanVC.view.isHidden = false
        }
    }
}
