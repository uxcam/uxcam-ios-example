import UIKit
import AVKit

class VideoPlayerViewController: UIViewController {
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    private var playerControlsVC: PlayerControlsViewController?
    private var timeObserverToken: Any?
    private let seekDuration: Double = 10 // 10 seconds for forward/backward
    
    private lazy var playerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .black
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var fullscreenButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.up.left.and.arrow.down.right"), for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(fullscreenButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPlayer()
        setupPlayerControls()
        addPeriodicTimeObserver()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        playerLayer?.frame = playerView.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removePeriodicTimeObserver()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // Add views
        view.addSubview(playerView)
        playerView.addSubview(thumbnailImageView)
        playerView.addSubview(fullscreenButton)
        view.addSubview(containerView)
        
        // Setup constraints
        NSLayoutConstraint.activate([
            playerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            playerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5),
            
            thumbnailImageView.topAnchor.constraint(equalTo: playerView.topAnchor),
            thumbnailImageView.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            thumbnailImageView.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            thumbnailImageView.bottomAnchor.constraint(equalTo: playerView.bottomAnchor),
            
            fullscreenButton.topAnchor.constraint(equalTo: playerView.topAnchor, constant: 16),
            fullscreenButton.trailingAnchor.constraint(equalTo: playerView.trailingAnchor, constant: -16),
            fullscreenButton.widthAnchor.constraint(equalToConstant: 44),
            fullscreenButton.heightAnchor.constraint(equalToConstant: 44),
            
            containerView.topAnchor.constraint(equalTo: playerView.bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupPlayer() {
        // For testing, let's use a sample video URL
        guard let url = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4") else { return }
        
        // Generate thumbnail
        generateThumbnail(from: url) { [weak self] image in
            DispatchQueue.main.async {
                self?.thumbnailImageView.image = image
            }
        }
        
        player = AVPlayer(url: url)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer?.videoGravity = .resizeAspect
        
        if let playerLayer = playerLayer {
            playerView.layer.addSublayer(playerLayer)
        }
        
        // Hide thumbnail when video starts playing
        NotificationCenter.default.addObserver(self,
                                             selector: #selector(playerDidStartPlaying),
                                               name: AVPlayerItem.timeJumpedNotification,
                                             object: player?.currentItem)
    }
    
    private func generateThumbnail(from url: URL, completion: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .userInitiated).async {
            let asset = AVAsset(url: url)
            let imageGenerator = AVAssetImageGenerator(asset: asset)
            imageGenerator.appliesPreferredTrackTransform = true
            
            // Get thumbnail at 0 seconds
            let time = CMTime(seconds: 0, preferredTimescale: 600)
            
            do {
                let cgImage = try imageGenerator.copyCGImage(at: time, actualTime: nil)
                let thumbnail = UIImage(cgImage: cgImage)
                completion(thumbnail)
            } catch {
                print("Error generating thumbnail: \(error)")
                completion(nil)
            }
        }
    }
    
    @objc private func playerDidStartPlaying() {
        UIView.animate(withDuration: 0.3) {
            self.thumbnailImageView.alpha = 0
        }
    }
    
    private func setupPlayerControls() {
        playerControlsVC = PlayerControlsViewController()
        playerControlsVC?.delegate = self
        
        if let playerControlsVC = playerControlsVC {
            addChild(playerControlsVC)
            containerView.addSubview(playerControlsVC.view)
            playerControlsVC.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                playerControlsVC.view.topAnchor.constraint(equalTo: containerView.topAnchor),
                playerControlsVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                playerControlsVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                playerControlsVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
            ])
            
            playerControlsVC.didMove(toParent: self)
        }
    }
    
    private func addPeriodicTimeObserver() {
        // Notify every half second
        let timeScale = CMTimeScale(NSEC_PER_SEC)
        let time = CMTime(seconds: 0.5, preferredTimescale: timeScale)
        
        timeObserverToken = player?.addPeriodicTimeObserver(forInterval: time, queue: .main) { [weak self] time in
            guard let self = self,
                  let currentItem = self.player?.currentItem else { return }
            
            let currentTime = Float(CMTimeGetSeconds(time))
            let duration = CMTimeGetSeconds(currentItem.duration)
            
            if duration.isFinite && duration > 0 {
                self.playerControlsVC?.updateProgress(currentTime: currentTime, totalTime: Float(duration))
            }
            
        }
    }
    
    private func removePeriodicTimeObserver() {
        if let timeObserverToken = timeObserverToken {
            player?.removeTimeObserver(timeObserverToken)
            self.timeObserverToken = nil
        }
    }
    
    private func seekVideo(by seconds: Double) {
        guard let player = player,
              let duration = player.currentItem?.duration else { return }
        
        let currentTime = CMTimeGetSeconds(player.currentTime())
        let newTime = currentTime + seconds
        
        // Ensure we don't seek beyond the video duration or before the start
        let seekTime = max(0, min(newTime, CMTimeGetSeconds(duration)))
        let time = CMTime(seconds: seekTime, preferredTimescale: 600)
        player.seek(to: time)
    }
    
    @objc private func fullscreenButtonTapped() {
        // Pause inline video if playing
        if player?.rate != 0 {
            player?.pause()
            playerControlsVC?.updatePlayPauseButton(isPlaying: false)
        }
        
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.allowsPictureInPicturePlayback = false
        playerViewController.canStartPictureInPictureAutomaticallyFromInline = false
        playerViewController.showsPlaybackControls = true
        present(playerViewController, animated: true) {
            self.player?.play()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - PlayerControlsDelegate
extension VideoPlayerViewController: PlayerControlsDelegate {
    func didTapPlayPause() {
        if player?.rate == 0 {
            player?.play()
            playerControlsVC?.updatePlayPauseButton(isPlaying: true)
            UIView.animate(withDuration: 0.3) {
                self.thumbnailImageView.alpha = 0
            }
        } else {
            player?.pause()
            playerControlsVC?.updatePlayPauseButton(isPlaying: false)
        }
    }
    
    func didSliderValueChanged(_ value: Float) {
        guard let duration = player?.currentItem?.duration else { return }
        let totalSeconds = CMTimeGetSeconds(duration)
        let seekTime = CMTime(seconds: Double(value) * totalSeconds, preferredTimescale: 600)
        player?.seek(to: seekTime)
    }
    
    func didTapForward() {
        seekVideo(by: seekDuration)
    }
    
    func didTapBackward() {
        seekVideo(by: -seekDuration)
    }
}
