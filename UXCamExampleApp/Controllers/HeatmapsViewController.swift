import UIKit

class HeatmapsViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Heatmaps Demo"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This screen demonstrates how UXCam generates heatmaps to visualize user interaction patterns."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let gridView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let generateHeatmapButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Generate Heatmap", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "Heatmaps"
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(gridView)
        stackView.addArrangedSubview(generateHeatmapButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            gridView.heightAnchor.constraint(equalToConstant: 300),
            generateHeatmapButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        generateHeatmapButton.addTarget(self, action: #selector(generateHeatmapButtonTapped), for: .touchUpInside)
        
        // Add interactive elements to grid view
        setupGridView()
    }
    
    private func setupGridView() {
        let buttonSize: CGFloat = 60
        let spacing: CGFloat = 20
        let columns = 3
        
        for i in 0..<6 {
            let button = UIButton(type: .system)
            button.backgroundColor = .systemBlue
            button.setTitleColor(.white, for: .normal)
            button.layer.cornerRadius = buttonSize / 2
            button.translatesAutoresizingMaskIntoConstraints = false
            gridView.addSubview(button)
            
            let row = i / columns
            let column = i % columns
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: buttonSize),
                button.heightAnchor.constraint(equalToConstant: buttonSize),
                button.centerXAnchor.constraint(equalTo: gridView.leadingAnchor, constant: (CGFloat(column) + 0.5) * (buttonSize + spacing)),
                button.centerYAnchor.constraint(equalTo: gridView.topAnchor, constant: (CGFloat(row) + 0.5) * (buttonSize + spacing))
            ])
            
            button.addTarget(self, action: #selector(gridButtonTapped), for: .touchUpInside)
        }
    }
    
    @objc private func gridButtonTapped() {
        // Simulate user interaction for heatmap data
    }
    
    @objc private func generateHeatmapButtonTapped() {
        let alert = UIAlertController(
            title: "Heatmap Generated",
            message: "The heatmap data has been collected and will be available in your UXCam dashboard.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
} 
