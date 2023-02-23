//
//  InfoViewController.swift
//  WebAdventure
//
//  Created by Anton Zyabkin on 23.02.2023.
//

import UIKit
protocol InfoViewControllerProtocol: UIViewController {
    func updateLabel(with text: String)
    func presentAuthViewController(viewController: UIViewController)
}

final class InfoViewController: UIViewController {
    var presenter: InfoViewPresenterProtocol?

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(logOutButtonDidTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.startLoadUser()
    }
    private func configureView() {
        view.addSubview(infoLabel)
        view.addSubview(logOutButton)
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 128),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            infoLabel.heightAnchor.constraint(equalToConstant: 512),
            
            logOutButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logOutButton.widthAnchor.constraint(equalToConstant: 80),
            logOutButton.heightAnchor.constraint(equalToConstant: 30)
        ])
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false

    }
    @objc func logOutButtonDidTap() {
        presenter?.logOut()
    }
}

extension InfoViewController: InfoViewControllerProtocol {
    func updateLabel(with text: String) {
        infoLabel.text = text
    }
    func presentAuthViewController(viewController: UIViewController) {
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
}
