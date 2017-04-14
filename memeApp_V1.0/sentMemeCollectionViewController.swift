//
//  sentMemeCollectionViewController.swift
//  memeApp_V1.0
//
//  Created by arora_72 on 14/04/17.
//  Copyright © 2017 indresh arora. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
var indexPathPassed:Int = 0

class sentMemeCollectionViewController: UICollectionViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       collectionView?.reloadData()
        
        
    }
    
    @IBAction func reloadData(_ sender: Any) {
        collectionView?.reloadData()
     
    
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "sent memes"
        let space:CGFloat = 3.0
        let dimension = (self.view.frame.width - (2 * space))/3.0
        
        flowLayout.minimumLineSpacing = space
        flowLayout.minimumInteritemSpacing = space
        flowLayout.itemSize = CGSize(width: dimension, height: dimension)
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
       
    }


        override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return appDelegate.memes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! sentMemeCollectionViewCell
    
        let meme = appDelegate.memes[indexPath.row]
        
        // Configure the cell
        cell.memeImage?.image = meme.memedImage
        cell.memeImage?.layer.borderWidth = 1.0
        cell.memeImage?.layer.borderColor = UIColor.black.cgColor
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let selectedMeme = appDelegate.memes[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detail = storyboard.instantiateViewController(withIdentifier: "memeDetailViewController") as! memeDetailViewController
       detail.memeSelected = selectedMeme
        navigationController?.pushViewController(detail, animated: true)

   
}
}
