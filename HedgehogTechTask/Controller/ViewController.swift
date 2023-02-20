//
//  ViewController.swift
//  HedgehogTechTask
//
//  Created by Azik on 15.02.2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    var imagesResults: [ImagesResult] = []
    var images = [UIImage]()
    var selectedItem : Int = 0
    var sourceURL = String()
    var networkManager = NetworkManager()

    private var imageURL: [ImagesResult]? {
        didSet {
            self.imagesResults = imageURL!
            self.networkManager.loadImage(array: self.imagesResults) { [weak self] image in
                self?.image = image
            }
        }
    }

    
    private var image: UIImage? {
        didSet {
            images.append(image!)
            hideLoadingProcess()
            didRecieveSearchResult()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        collectionView.dataSource = self
        collectionView.delegate = self
        let collectionViewCellNib = UINib(nibName: "CollectionViewCell", bundle: nil)
        collectionView.register(collectionViewCellNib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    private func showLoadingProcess() {
        collectionView.isHidden = true
    }

    private func didRecieveSearchResult() {
        collectionView.reloadData()
    }

    private func hideLoadingProcess() {
        collectionView.isHidden = false
    }


}

extension ViewController : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configure(image: images[indexPath.row])
        cell.isSelected = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = indexPath.row
        sourceURL = imagesResults[indexPath.row].link
        print(sourceURL)
        performSegue(withIdentifier: "goToSecond", sender: selectedCell)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecond" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.images = self.images
            secondVC.selectedImage = self.selectedItem
            secondVC.sourceURL = self.sourceURL
        }
    }
    
    
    
}

extension ViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let text = searchBar.text?.replacingOccurrences(of: " ", with: "%20") {
            imagesResults = []
            images = []
            networkManager.fetchPhotos(query: text) { [weak self] jsonResult in
                self?.imageURL = jsonResult
            }
            didRecieveSearchResult()
            showLoadingProcess()
        }
    }

}

