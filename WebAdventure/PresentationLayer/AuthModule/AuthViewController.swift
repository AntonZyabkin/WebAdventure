//
//  AuthViewController.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 22.02.2023.
//

import UIKit

protocol AuthViewControllerProtocol: UIViewController{
    func configureCaptcha(with image: UIImage)
    func showErrorMessage(_ error: String)
}

final class AuthViewController: UIViewController {
    var presenter: AuthViewPresenterProtocol?
    var loader: InfoViewPresenterProtocol?
    
    var loginTextfield: UITextField = {
        let textfield = UITextField()
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true
        textfield.placeholder = "Введите логин"
        textfield.font = .mainHelvetica(size: 18)
        return textfield
    }()
    private let passwordTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true
        textfield.placeholder = "Введите пароль"
        textfield.font = .mainHelvetica(size: 18)
        return textfield
    }()
    private let captchaTextfield: UITextField = {
        let textfield = UITextField()
        textfield.keyboardType = .default
        textfield.backgroundColor = .white
        textfield.layer.cornerRadius = 10
        textfield.layer.masksToBounds = true
        textfield.placeholder = "Введите слово с картинки"
        textfield.font = .mainHelvetica(size: 18)
        return textfield
    }()
    private lazy var authButton: UIButton =  {
        let button = UIButton(type: .system)
        button.backgroundColor = .myPurpleBold
        button.setTitle("Войти", for: .normal)
        button.titleLabel?.font = .mainHelvetica(size: 18)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(authRequest), for: .touchUpInside)
        return button
    }()
    lazy var tipsLabel: UILabel = {
        let label = UILabel()
        label.sizeToFit()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        return label
    }()
    private lazy var captchaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    private lazy var authViewsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextfield, passwordTextfield, captchaTextfield,tipsLabel, captchaImageView, authButton])
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    //MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.startLoadCaptcha()
        view.backgroundColor = .myPurpleLight
        configureView()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loader?.startLoadUser()
    }
    
    @objc
    func authRequest() {
        guard let login = loginTextfield.text, let password = passwordTextfield.text, let captcha = captchaTextfield.text  else {
            tipsLabel.text = "Enter login and/or password"
            return
        }
        tipsLabel.text = " "
        presenter?.authButtonDidPressed(login, password, captcha)
    }
    
    private func configureView() {
        view.addSubview(authViewsStackView)
        NSLayoutConstraint.activate([
            authViewsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            authViewsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            authViewsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            authViewsStackView.heightAnchor.constraint(equalToConstant: 512)
        ])
        authViewsStackView.translatesAutoresizingMaskIntoConstraints = false
    }
}

extension AuthViewController: AuthViewControllerProtocol {
    func configureCaptcha(with image: UIImage) {
        captchaImageView.image = image
    }
    
    func showErrorMessage(_ error: String) {
        tipsLabel.text = error
    }
}
