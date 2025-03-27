import UIKit
import UXCam

class UserAnalyticsViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "User Analytics Demo"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This screen demonstrates how UXCam tracks user behavior and provides analytics insights."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let userInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let trackEventButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Track User Event", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let setUserPropertyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set User Property", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var userProperties = [
        ("User ID", "demo_user_123"),
        ("Device", "iPhone 13"),
        ("App Version", "1.0.0"),
        ("Last Active", "Just now")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "User Analytics"
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(userInfoView)
        stackView.addArrangedSubview(trackEventButton)
        stackView.addArrangedSubview(setUserPropertyButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            userInfoView.heightAnchor.constraint(equalToConstant: 200),
            trackEventButton.heightAnchor.constraint(equalToConstant: 44),
            setUserPropertyButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        trackEventButton.addTarget(self, action: #selector(trackEventButtonTapped), for: .touchUpInside)
        setUserPropertyButton.addTarget(self, action: #selector(setUserPropertyButtonTapped), for: .touchUpInside)
        
        setupUserInfoView()
    }
    
    private func setupUserInfoView() {
        let infoStack = UIStackView()
        infoStack.axis = .vertical
        infoStack.spacing = 15
        infoStack.translatesAutoresizingMaskIntoConstraints = false
        userInfoView.addSubview(infoStack)
        
        userProperties.forEach { title, value in
            addUserProperties(to: infoStack, title: title, value: value)
        }
        
        NSLayoutConstraint.activate([
            infoStack.topAnchor.constraint(equalTo: userInfoView.topAnchor, constant: 20),
            infoStack.leadingAnchor.constraint(equalTo: userInfoView.leadingAnchor, constant: 20),
            infoStack.trailingAnchor.constraint(equalTo: userInfoView.trailingAnchor, constant: -20)
        ])
    }
    
    private func addUserProperties(to infoStack: UIStackView, title: String, value: String) {
        let rowStack = UIStackView()
        rowStack.axis = .horizontal
        rowStack.spacing = 10
        rowStack.distribution = .equalSpacing
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.textColor = .secondaryLabel
        valueLabel.textAlignment = .right
        valueLabel.setContentHuggingPriority(.defaultLow, for: .horizontal)
        
        rowStack.addArrangedSubview(titleLabel)
        rowStack.addArrangedSubview(valueLabel)
        infoStack.addArrangedSubview(rowStack)
    }
    
    @objc private func trackEventButtonTapped() {
        // Track a custom event
        UXCam.logEvent("button_tapped", withProperties: [
            "button_name": "track_event",
            "timestamp": Date().timeIntervalSince1970
        ])
        
        let alert = UIAlertController(
            title: "Event Tracked",
            message: "The user event has been logged and will be available in your analytics dashboard.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func setUserPropertyButtonTapped() {
        // Set a custom user property
        for (title, value) in userProperties {
            UXCam.setUserProperty(title, value: value)
        }
        
        let alert = UIAlertController(
            title: "Property Set",
            message: "The user property has been updated and will be reflected in your analytics.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
} 
