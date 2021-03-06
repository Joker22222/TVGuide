//
//  ShowsDetailVC.swift
//  TVGuide
//
//  Created by Fernando on 23/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit
import AVFoundation
import youtube_ios_player_helper_swift

class ShowsDetailVC: UIViewController, ShowsDetailVCDelegate {
    
    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblVoteAvarage: UILabel!
    @IBOutlet weak var lblVoteCount: UILabel!
    @IBOutlet weak var imgShow: UIImageView!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var loadingMovieIndicator: UIActivityIndicatorView!
    @IBOutlet weak var btnPlayPause: UIButton!
    
    private var ctrler: ShowsDetailCtrler!
    var show: ShowsVM?

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        ctrler = ShowsDetailCtrler(self, contextManager: appDelegate.contextManager, apiClient: APIClient())
        ctrler.getVideos(forShow: show!)
        if let image = show!.backdropImage {
            imgShow.image = image
        } else {
            ctrler.getImageForShow(show: show!)
        }
        setUpViews()
    }
    
    func setUpViews(){
        lblTitle.text = show?.name
        lblVoteCount.text = "\(show?.voteCount ?? 0)"
        lblVoteAvarage.text = String(format:"%.1f", show?.voteAverage ?? 0.0)
        imgShow.image = show?.backdropImage ?? #imageLiteral(resourceName: "placeholder")
        lblDescription.text = show?.overview ?? ""
    }
    
    func networkError(error:Error) {
        let dialog = DialogViewController.dialogWithTitle(title: "Network Error", message: error.localizedDescription, cancelTitle: "Ok")
        dialog.show()
    }
 
     func loadVideo(videoId:String) {
        let playerVars:[String: Any] = [
            "controls" : "0",
            "showinfo" : "0",
            "autoplay": "0",
            "rel": "0",
            "modestbranding": "0",
            "iv_load_policy" : "3",
            "fs": "0",
            "playsinline" : "1"
        ]
        playerView.delegate = self
        _ = playerView.load(videoId: videoId, playerVars: playerVars)
        playerView.isUserInteractionEnabled = false
        //updateTime()
    }
    
    func updateImage(image:UIImage) {
        imgShow.image = image
    }
    
    @IBAction func playPause(_ sender: Any) {
        if playerView.playerState == .playing {
            playerView.pauseVideo()
            btnPlayPause.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 0.5104880137)
            btnPlayPause.setImage(UIImage(named:"play_icon"), for:.normal)
        } else {
            playerView.playVideo()
            btnPlayPause.backgroundColor = UIColor.clear
            btnPlayPause.setImage(nil, for:.normal)
        }
    }
    
}

extension ShowsDetailVC: YTPlayerViewDelegate {
    func playerViewDidBecomeReady(_ playerView: YTPlayerView){
        loadingMovieIndicator.stopAnimating()
        btnPlayPause.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 0.5104880137)
        btnPlayPause.setImage(UIImage(named:"play_icon"), for:.normal)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState){

    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality){

    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        print(error)
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float){

    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor{
        return UIColor.black
    }
    
    func playerViewPreferredInitialLoadingView(_ playerView: YTPlayerView) -> UIView?{
        return UIImageView(image:UIImage(named:"video_not_found"))
    }
}
