//
//  ScanQRCodeViewController.swift
//  QRCodeReaderTest
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/05/23.
//

import UIKit
import AVFoundation
import QRCodeReader

class ScanQRCodeViewController: UIViewController {
    
    let scanResultLabel: UILabel = {
        let label = UILabel()
        label.text = "Valor escaneado: "
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var scanButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.image = UIImage(systemName: "qrcode.viewfinder")
        configuration.title = " Scanear"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(scanButtonPressed), for: .touchUpInside)
        return button
    }()
    
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            
            // Configure the view controller (optional)
            $0.showSwitchCameraButton = false
            $0.showOverlayView        = true
            $0.cancelButtonTitle      = "Cancelar"
//            $0.rectOfInterest         = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    weak var mainVC: MainViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(scanResultLabel)
        view.addSubview(scanButton)
        configureContraints()
    }
    
    func configureContraints() {
        NSLayoutConstraint.activate([
            scanResultLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            scanResultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            scanResultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 6),
            
            scanButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scanButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc func scanButtonPressed() {
        readerVC.completionBlock = { [weak self] (result: QRCodeReaderResult?) in
            let value = result?.value ?? "???"
            self?.scanResultLabel.text = "Valor escaneado: \(value)"
            self?.readerVC.stopScanning()
            self?.mainVC?.dismiss(animated: true)
        }
        
        readerVC.modalPresentationStyle = .formSheet
        
        mainVC?.present(readerVC, animated: true, completion: nil)
    }
    
}
