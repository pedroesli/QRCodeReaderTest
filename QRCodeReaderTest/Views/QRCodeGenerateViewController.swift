//
//  QRCodeGenerateViewController.swift
//  QRCodeReaderTest
//
//  Created by Pedro Ésli Vieira do Nascimento on 04/05/23.
//

import UIKit
import EFQRCode

class QRCodeGenerateViewController: UIViewController {

    let codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.text = "Insira um texto para gerar o seu QRCode"
        codeLabel.translatesAutoresizingMaskIntoConstraints = false
        codeLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return codeLabel
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "texto"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return textField
    }()
    
    lazy var generateButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.borderedTinted()
        configuration.title = "Gerar QRCode"
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(generateButtonPressed), for: .touchUpInside)
        button.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return button
    }()
    
    let imagePreviewView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "questionmark.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemGray6
        imageView.layer.cornerRadius = 6
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setContentHuggingPriority(.defaultLow, for: .vertical)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(codeLabel)
        view.addSubview(textField)
        view.addSubview(generateButton)
        view.addSubview(imagePreviewView)
        configureContraints()
    }
    
    func configureContraints() {
        NSLayoutConstraint.activate([
            codeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            codeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            codeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            
            textField.topAnchor.constraint(equalTo: codeLabel.bottomAnchor, constant: 6),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            
            generateButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 16),
            generateButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            generateButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            
            imagePreviewView.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 16),
            imagePreviewView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 6),
            imagePreviewView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -6),
            imagePreviewView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func generateButtonPressed() {
        guard let code = textField.text else {
            print("Code Label can't be empty")
            return
        }
        guard let generatedImage = EFQRCode.generate(for: code) else {
            print("Generating QRCode image failed")
            return
        }
        imagePreviewView.image = UIImage(cgImage: generatedImage)
    }
}
