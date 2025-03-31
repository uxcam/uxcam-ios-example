import UIKit
import UXCam

class WelcomeViewController: UIViewController {
    
    private struct DemoItem {
        let title: String
        let icon: String
        let action: Selector
    }
    
    private let demoItems: [DemoItem] = [
        DemoItem(title: "Session Replay", icon: "play.circle.fill", action: #selector(showSessionReplay)),
        DemoItem(title: "Heatmaps", icon: "flame.fill", action: #selector(showHeatmaps)),
        DemoItem(title: "User Analytics", icon: "person.2.fill", action: #selector(showUserAnalytics)),
        DemoItem(title: "Video Player", icon: "video.fill", action: #selector(showVideoPlayer)),
        DemoItem(title: "SwiftUI Views", icon: "swift", action: #selector(showSwiftUIView))
    ]
    
    private let headerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to UXCam"
        label.font = .systemFont(ofSize: 32, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Mobile Analytics Demo"
        label.font = .systemFont(ofSize: 18)
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .appLogo
        imageView.tintColor = .systemBlue
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "DemoCell")
        table.isScrollEnabled = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Setup header
        view.addSubview(headerStackView)
        headerStackView.addArrangedSubview(iconImageView)
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(subtitleLabel)
        
        // Setup table view
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            headerStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            headerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            headerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            iconImageView.heightAnchor.constraint(equalToConstant: 80),
            iconImageView.widthAnchor.constraint(equalToConstant: 80),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            
            subtitleLabel.leadingAnchor.constraint(equalTo: headerStackView.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: headerStackView.trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 40),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func showSessionReplay() {
        let vc = SessionReplayViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showHeatmaps() {
        let vc = HeatmapsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showUserAnalytics() {
        let vc = UserAnalyticsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showVideoPlayer() {
        let vc = VideoPlayerViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func showSwiftUIView() {
        let vc = SwiftUIController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITableViewDelegate & UITableViewDataSource
extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demoItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DemoCell", for: indexPath)
        let item = demoItems[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = item.title
        
        // Configure image
        let image = UIImage(systemName: item.icon)?
            .withConfiguration(UIImage.SymbolConfiguration(weight: .medium))
        config.image = image
        config.imageProperties.tintColor = .systemBlue
        
        cell.contentConfiguration = config
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = demoItems[indexPath.row]
        perform(item.action)
    }
} 
