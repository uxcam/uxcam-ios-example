import UIKit

protocol PlayerControlsDelegate: AnyObject {
    func didTapPlayPause()
    func didSliderValueChanged(_ value: Float)
    func didTapForward()
    func didTapBackward()
}

class PlayerControlsViewController: UIViewController {
    
    weak var delegate: PlayerControlsDelegate?
    
    private lazy var controlsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var backwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "gobackward.10"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var forwardButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "goforward.10"), for: .normal)
        button.tintColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var progressSlider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0
        slider.tintColor = .systemBlue
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        return slider
    }()
    
    private lazy var currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add subviews
        view.addSubview(controlsStackView)
        controlsStackView.addArrangedSubview(backwardButton)
        controlsStackView.addArrangedSubview(playPauseButton)
        controlsStackView.addArrangedSubview(forwardButton)
        
        view.addSubview(progressSlider)
        view.addSubview(currentTimeLabel)
        view.addSubview(totalTimeLabel)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            controlsStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            controlsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            backwardButton.widthAnchor.constraint(equalToConstant: 44),
            backwardButton.heightAnchor.constraint(equalToConstant: 44),
            
            playPauseButton.widthAnchor.constraint(equalToConstant: 44),
            playPauseButton.heightAnchor.constraint(equalToConstant: 44),
            
            forwardButton.widthAnchor.constraint(equalToConstant: 44),
            forwardButton.heightAnchor.constraint(equalToConstant: 44),
            
            currentTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            currentTimeLabel.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor),
            
            totalTimeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            totalTimeLabel.centerYAnchor.constraint(equalTo: progressSlider.centerYAnchor),
            
            progressSlider.topAnchor.constraint(equalTo: controlsStackView.bottomAnchor, constant: 20),
            progressSlider.leadingAnchor.constraint(equalTo: currentTimeLabel.trailingAnchor, constant: 10),
            progressSlider.trailingAnchor.constraint(equalTo: totalTimeLabel.leadingAnchor, constant: -10)
        ])
    }
    
    @objc private func playPauseButtonTapped() {
        delegate?.didTapPlayPause()
    }
    
    @objc private func backwardButtonTapped() {
        delegate?.didTapBackward()
    }
    
    @objc private func forwardButtonTapped() {
        delegate?.didTapForward()
    }
    
    @objc private func sliderValueChanged(_ slider: UISlider) {
        delegate?.didSliderValueChanged(slider.value)
    }
    
    func updatePlayPauseButton(isPlaying: Bool) {
        let imageName = isPlaying ? "pause.fill" : "play.fill"
        playPauseButton.setImage(UIImage(systemName: imageName), for: .normal)
    }
    
    func updateProgress(currentTime: Float, totalTime: Float) {
        progressSlider.value = currentTime / totalTime
        currentTimeLabel.text = formatTime(currentTime)
        totalTimeLabel.text = formatTime(totalTime)
    }
    
    private func formatTime(_ time: Float) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}