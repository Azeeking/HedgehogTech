//
//  SecondViewController.swift
//  HedgehogTechTask
//
//  Created by Azik on 16.02.2023.
//

import UIKit

class SecondViewController : UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    
    var images = [UIImage]()
    var sourceURL = String()
    var selectedImage: Int = 0
    var vc = ViewController()
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadImage()
        
    }
    
    func loadImage() {
        imageView.image = images[selectedImage]
    }

    @IBAction func nextButtonPressed(_ sender:UIButton){
        self.selectedImage += 1
        self.selectedImage = (self.selectedImage < 0) ? (self.images.count - 1):
        self.selectedImage % self.images.count
        loadImage()
        print(sourceURL)
    }
    @IBAction func prevButtonPressed(_ sender:UIButton){
        self.selectedImage -= 1
        self.selectedImage = (self.selectedImage < 0) ? (self.images.count - 1):
        self.selectedImage % self.images.count
        loadImage()
        print(sourceURL)
    }
    @IBAction func linkButtonPressed(_ sender:UIButton){
        performSegue(withIdentifier: "goToWeb", sender: self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToWeb" {
            let webVC = segue.destination as! WebViewController
            webVC.sourceURL = sourceURL
        }
    }
}

extension UIImage {
    func toPngString()->String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
    func toJpegString(compressionQuality cq:CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
