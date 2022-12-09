//
//  LoadingAnimation.swift
//  TheRickAndMorty
//
//  Created by Gabriel Mendonca de Sousa Goncalves on 20/08/22.
//

import Lottie
import UIKit

class LoadingAnimation: UIView{
    
    private var animationLoadingView: LottieAnimationView?
    private var nameJson: String
    private var animationSpeed: CGFloat
    private var contentModeAnimation: UIView.ContentMode
    private var loopMode: LottieLoopMode
    
    private var animationHeight: Double
    private var animationWidht: Double
    
    init(nameJson: String, animationSpeed: CGFloat = 1,animationHeight: Double, animationWidht: Double, contentModeAnimation: UIView.ContentMode = .scaleAspectFit, loopMode: LottieLoopMode = .loop) {
        self.nameJson = nameJson
        self.animationSpeed = animationSpeed
        self.contentModeAnimation = contentModeAnimation
        self.loopMode = loopMode
        self.animationHeight = animationHeight
        self.animationWidht = animationWidht
        
        super.init(frame: .zero)
        configureLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLoading() {
        animationLoadingView = LottieAnimationView(name: nameJson)
        animationLoadingView?.frame = CGRect(x: 0, y: 0, width: animationWidht, height: animationHeight)
        animationLoadingView?.animationSpeed = animationSpeed
        animationLoadingView?.contentMode = contentModeAnimation
        animationLoadingView?.loopMode = loopMode
        self.addSubview(animationLoadingView!)
    }
    
    internal func startProgressLoading() {
        animationLoadingView?.play()
    }
    
    internal func pauseProgressLoading() {
        animationLoadingView?.pause()
    }
    
    internal func endProgressLoading() {
        animationLoadingView?.stop()
    }
}

