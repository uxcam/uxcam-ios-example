import UIKit
import UXCam

class SessionReplayViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Session Replay Demo"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This screen demonstrates how UXCam captures user interactions for session replay analysis."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let demoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap Me!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let textField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter some text"
        field.borderStyle = .roundedRect
        return field
    }()
    
    private let toggleSwitch: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Session Replay"
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        // Add demo interactive elements
        let demoElementsStack = UIStackView()
        demoElementsStack.axis = .vertical
        demoElementsStack.spacing = 15
        
        demoElementsStack.addArrangedSubview(demoButton)
        demoElementsStack.addArrangedSubview(textField)
        
        let toggleStack = UIStackView()
        toggleStack.axis = .horizontal
        toggleStack.spacing = 10
        toggleStack.addArrangedSubview(UILabel(text: "Enable Feature"))
        toggleStack.addArrangedSubview(toggleSwitch)
        
        demoElementsStack.addArrangedSubview(toggleStack)
        stackView.addArrangedSubview(demoElementsStack)
        
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            demoButton.heightAnchor.constraint(equalToConstant: 44),
            textField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
        demoButton.addTarget(self, action: #selector(demoButtonTapped), for: .touchUpInside)
    }
    
    @objc private func demoButtonTapped() {
        // Simulate user interaction
    }
    
}

// MARK: - UILabel Extension
extension UILabel {
    convenience init(text: String) {
        self.init()
        self.text = text
    }
} 
