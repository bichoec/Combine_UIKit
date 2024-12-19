//
//  ViewController.swift
//  MiscelaneasCODE
//
//  Created by Eric Guzman on 6/12/24.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    let textToCompare = "Delete account"
    var titleLabel = UILabel()
    var textField = UITextField()
    var deleteButton = UIButton()
    
    //Published
    @Published private var enteredText = ""
    
    //Subscriber
    private var inputTextSubscriber: AnyCancellable?
    
    //Publisher
    private var updateButtonColor: AnyPublisher<UIColor?, Never> {
        return Publishers.Map(upstream: $enteredText) { textInput in
            if textInput.lowercased() == self.textToCompare.lowercased() {
                return .systemRed
            } else {
                return .systemGray2
            }
        }
        .eraseToAnyPublisher()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createObjects()
        addTargetsToObjects()
        addViews()
        addConstraints()
        
        inputTextSubscriber = updateButtonColor
            .receive(on: RunLoop.main)
            .assign(to: \.backgroundColor, on: deleteButton)
    }
    
    @objc func getPokemon(_ sender: UIButton) {
        print("Submit button tapped")
    }
    
    @objc func updateName(_ sender: UITextField) {
        enteredText = sender.text ?? ""
    }
    
    private func createObjects() {
        titleLabel = createLabel()
        textField = createTextField()
        deleteButton = createButton()
    }
    
    private func addTargetsToObjects() {
        textField.addTarget(self, action: #selector(updateName), for: .editingChanged)
        deleteButton.addTarget(self, action: #selector(getPokemon), for: .touchUpInside)
    }
    
    private func addViews() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(deleteButton)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            deleteButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 8),
            deleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            deleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)
        ])
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.text = "Combine Example"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    private func createTextField() -> UITextField {
        let textField = UITextField()
        textField.placeholder = "Enter delete account"
        textField.borderStyle = .roundedRect
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.textColor = .black
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.setTitle("Delete Account", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }
}