//
//  ViewController.swift
//  Hitsujichan
//
//  Created by 酒井みな実 on 2025/05/11.
//

import UIKit
import AVFoundation // ← 追加！

class ViewController: UIViewController {
    
    var number: Int = 0
    var sheepStack: [UIImageView] = []
    let sheepSize = CGSize(width: 100, height: 100)
    let stackStartY: CGFloat = 10100
    let stackCenterX: CGFloat = UIScreen.main.bounds.width / 2
    
    let contentView = UIView()
    
    var player: AVAudioPlayer? // ← 音声プレイヤーの変数
    let drumSoundPlayer = try!AVAudioPlayer(data: NSDataAsset (name: "sheep_sound" )!.data)
    //bgmを追加
    let bgmPlayer = try!AVAudioPlayer(data: NSDataAsset (name: "朝の訪れ" )!.data)
    
    @IBOutlet var label: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    //    @IBOutlet var stackView:UIStackView!
    
    private var blackOverlayView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.alwaysBounceVertical = true
//        scrollView.center.x = self.view.center.x
        contentView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: stackStartY) //
//        高さは十分大きくしておく
        contentView.center.x = self.view.center.x
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.frame.size
        //⬇️背景gradationもできるよ（一旦コメントアウト）
        let gradationLayer = CAGradientLayer()
        gradationLayer.colors = [UIColor.black.cgColor,UIColor.systemIndigo.cgColor,UIColor.blue.cgColor,UIColor.cyan.cgColor]
        gradationLayer.startPoint = CGPoint(x: 0, y: 1)
        gradationLayer.endPoint = CGPoint(x: 0, y: 0)
        gradationLayer.frame.size = contentView.frame.size
        gradationLayer.frame.size.width = contentView.frame.width
        gradationLayer.bounds.origin.x = contentView.frame.width / 2
        contentView.layer.insertSublayer(gradationLayer, at: 0)
        scrollView.setContentOffset(CGPoint(x: 0, y: stackStartY - self.view.frame.height), animated: false)
        
        //スタート地点に月の画像を追加
        let moonUIImageView = UIImageView()
        moonUIImageView.frame = CGRect(x: 0, y: stackStartY - 300, width: contentView.frame.width * 2, height: 400)
        moonUIImageView.image = UIImage(named: "moon_surface_clip")
        moonUIImageView.contentMode = .scaleAspectFit
        moonUIImageView.center.x = stackCenterX + 100
        contentView.addSubview(moonUIImageView)
        
        //ゴール地点に地球の画像を追加
        let earthUIImageView = UIImageView()
        earthUIImageView.frame.size = CGSize(width: contentView.frame.width * 2, height: contentView.frame.width * 2)
        earthUIImageView.image = UIImage(named: "chikyuu")
        earthUIImageView.contentMode = .scaleAspectFit
        earthUIImageView.center = CGPoint(x: self.view.frame.width / 2, y: 0)
        contentView.addSubview(earthUIImageView)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: stackStartY - 200), animated: false)
        
        //bgmを再生
        bgmPlayer.currentTime = 0
        bgmPlayer.play()
    }

    
    @IBAction func plus() {
        switch number {
        case 0 ..< 30:
            self.view.backgroundColor = UIColor.cyan
        case 30 ..< 60:
            self.view.backgroundColor = UIColor.blue
        case 60 ..< 90:
            self.view.backgroundColor = UIColor.systemIndigo
        case 90 ..< 101:
            self.view.backgroundColor = UIColor.black
            
        default:
            break
            
        }
        
 
        
        
        //羊の音声を再生
        drumSoundPlayer.currentTime = 0
        drumSoundPlayer.play()
        
        //羊を表示するuiimageviewを作成
        let sheepImageView = UIImageView(image: UIImage(named: "hitsuji"))
        sheepImageView.frame.size = sheepSize
        let stackHeight = CGFloat(sheepStack.count) * sheepSize.height
        sheepImageView.center = CGPoint(x: stackCenterX , y: stackStartY - 100 - stackHeight)
        
        let chooseInt = Int.random(in: 1...3)
        if chooseInt == 1{
            //画像を高度によって変更
            var thingImage:UIImage?
            switch number {
            case 0 ..< 30:
                thingImage = UIImage(named: "rocket")
            case 30 ..< 60:
                thingImage = UIImage(named:"star")
            case 60 ..< 101:
                thingImage = UIImage(named:"cloud")
            default: break
            }
            print(thingImage)
            let grassNumber = Int.random(in: 1...5)
            let grassImage = {
                switch grassNumber{
                case 1:return UIImage(named: "grass1")
                case 2:return UIImage(named: "grass2")
                case 3:return UIImage(named: "grass3")
                case 4:return UIImage(named: "grass4")
                case 5:return UIImage(named: "grass5")
                default: break
                }
                
                return UIImage(named: "grass1")
            }()
            let flag = Bool.random()
            let flagDelection = Bool.random()
            //ものの画像を生成
            let thingImageView = {
                if flag{
                    return UIImageView(image: thingImage)
                    
                }else{
                    return UIImageView(image: grassImage)
                }
            }()
            
            let checkInt = Int.random(in: 3...6)
            thingImageView.frame.size = sheepSize
            let thingStackHeight = stackStartY - CGFloat(sheepStack.count) * sheepSize.height  - CGFloat(100 * checkInt)
            thingImageView.center = CGPoint(x: (flagDelection ? stackCenterX / 2 : stackCenterX / 2 * 3) , y: thingStackHeight)
            contentView.addSubview(thingImageView)
        }
        
        //羊をcontentviewに追加して見えるように
        contentView.addSubview(sheepImageView)
        sheepStack.append(sheepImageView)
        
        number += 1
        label.text = String(number)
        
        if number >= 100 {
            //bgmを停止
            bgmPlayer.stop()
            //終了画面へ遷移
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let resultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
                resultViewController.modalPresentationStyle = .fullScreen
                self.present(resultViewController, animated: true, completion: nil)
            }
        }
        
        //最も高い羊が画面中央に来るようにするコード
        //⬇️新しく追加した羊のcontentviewにおける高さ(originは中央の値)
        let sheepY = sheepImageView.frame.origin.y
        //⬇️スクロールバーを移動させる高さの決定(これが画面中央にくるらしい)
        let centerY = sheepY - (view.frame.height / 2)
        //⬇️安全対策!contentview外までスクロールさせないようにする
        let maxOffset = contentView.frame.height - scrollView.frame.height
        //⬇️スクロールする位置を決定する
        let targetOffset = min(max(centerY, 0), maxOffset)
        //⬇️スクロールバーをcontentviewの指定した位置に移動させる
        scrollView.setContentOffset(CGPoint(x: 0, y: targetOffset), animated: true)
//        scrollView.contentInsetAdjustmentBehavior
    }
    
    func playSheepSound() {
        guard let soundURL = Bundle.main.url(forResource: "sheep_sound", withExtension: "mp3") else {
            print("音声ファイルが見つかりません")
            return
        }
        
        do {
            player = try AVAudioPlayer(contentsOf: soundURL)
            player?.play()
        } catch {
            print("音声の再生に失敗しました: \(error.localizedDescription)")
        }
    }
}

class TestView: UIView {
    
    let scroll = UIScrollView()
    let outline = UIView()
    
    let testButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("テストテストテスト", for: .normal)
        return button
    }()
    let testText: UILabel = {
        let text = UILabel()
        text.text = "隣の柿はよく柿食う客だ隣の柿はよく柿食う客だ隣の柿はよく柿食う客だ隣の柿はよく柿食う客だ"
        text.textColor = .white
        text.numberOfLines = 0
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .systemGray
        setComponent()
        scrollConstraint()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setComponent(){
        [scroll, outline, testButton, testText].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        addSubview(scroll)
        scroll.addSubview(outline)
        [testButton, testText].forEach{
            outline.addSubview($0)
        }
    }
    
    private func scrollConstraint(){
        NSLayoutConstraint.activate([
            scroll.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            scroll.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
            scroll.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            outline.topAnchor.constraint(equalTo: self.scroll.topAnchor),
            outline.bottomAnchor.constraint(equalTo: self.scroll.bottomAnchor),
            outline.widthAnchor.constraint(equalTo: self.scroll.widthAnchor),
            outline.leadingAnchor.constraint(equalTo: self.scroll.leadingAnchor),
            outline.trailingAnchor.constraint(equalTo: self.scroll.trailingAnchor),
        ])
    }
    
    private func setConstraint(){
        NSLayoutConstraint.activate([
            testButton.topAnchor.constraint(equalTo: self.outline.topAnchor, constant: 50),
            testButton.leadingAnchor.constraint(equalTo: self.outline.leadingAnchor, constant: 20),
            testButton.trailingAnchor.constraint(equalTo: self.outline.trailingAnchor, constant: -20),
            testButton.heightAnchor.constraint(equalToConstant: 40),
            
            testText.topAnchor.constraint(equalTo: self.testButton.bottomAnchor, constant: 400),
            testText.bottomAnchor.constraint(equalTo: self.outline.bottomAnchor, constant: -50),
            testText.leadingAnchor.constraint(equalTo: self.outline.leadingAnchor, constant: 20),
            testText.trailingAnchor.constraint(equalTo: self.outline.trailingAnchor, constant: -20),
        ])
    }
    // テストtestどうですか
}
