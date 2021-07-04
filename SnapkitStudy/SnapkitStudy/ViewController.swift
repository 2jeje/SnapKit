//
//  ViewController.swift
//  SnapkitStudy
//
//  Created by kakao on 2021/07/04.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    lazy var yellowView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .yellow
        return v
    }()
    
    lazy var blueView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .blue
        return v
    }()
    
    lazy var blackView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .black
        return v
    }()
    
    lazy var redView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .red
        return v
    }()
    
    lazy var greenView: UIView = {
        let v = UIView(frame: .zero)
        v.backgroundColor = .green
        return v
    }()
    
    var constraintsValue = 50.0
    var isFirst = true
    var constrints: Constraint? = nil
    
    override func loadView() {
        super.loadView()
        print("loadView")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        self.view.addSubview(yellowView)
        self.view.addSubview(blueView)
        
        self.view.addSubview(blackView)
        self.view.addSubview(redView)
        redView.addSubview(greenView)
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification,
                                                                  object: nil,
                                                                  queue: .main) {
                                                                  [unowned self] notification in
            if isFirst == false {
                print("foreground")
                resetView()
                initView()
                startAnimation()
                //view.setNeedsLayout()
            }
            isFirst = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("viewDidLayoutSubviews")

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
        resetView()
        initView()
        startAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear")
    }

    func resetView() {
        yellowView.snp.removeConstraints()
        blueView.snp.removeConstraints()
        blackView.snp.removeConstraints()
        redView.snp.removeConstraints()
        greenView.snp.removeConstraints()
    }
    
    func initView() {

        yellowView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(100)
        }
        
        blueView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).inset(100)
            make.right.equalTo(self.view).inset(100)
            make.top.equalTo(yellowView.snp.bottom)
            make.height.equalTo(100)
        }

        blackView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            make.height.equalTo(100)
        }
        
        redView.snp.makeConstraints { make in
            make.top.equalTo(blueView.snp.bottom)
            make.right.equalTo(self.view)
            make.left.equalTo(self.view)
            make.bottom.equalTo(blackView.snp.top)
        }
        
        greenView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            constrints = make.edges.equalToSuperview().inset(50).constraint
        }
    }
    
    func startAnimation() {
        self.redView.layoutIfNeeded()
        self.constrints?.update(inset: 0)

        UIView.animate(withDuration: 5.0 ,delay: 0.0,options: [.repeat, .autoreverse], animations: {
            self.redView.layoutIfNeeded()
        }, completion: { _ in
            self.constrints?.update(inset: 50)
            self.greenView.layoutIfNeeded()
        })
    }
    
}

