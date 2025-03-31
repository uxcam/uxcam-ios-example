import UIKit

class ContainerViewController: UIViewController {
    
    private let textInputViewController = TextInputViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupChildViewController()
    }
    
    private func setupChildViewController() {
        addChild(textInputViewController)
        view.addSubview(textInputViewController.view)
        textInputViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textInputViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            textInputViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            textInputViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            textInputViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        textInputViewController.didMove(toParent: self)
    }
} 