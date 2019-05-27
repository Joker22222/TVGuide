//
//  MoviesVC.swift
//  TVGuide
//
//  Created by Fernando on 22/5/2019.
//  Copyright © 2019 Fernando. All rights reserved.
//

import UIKit

class ShowsVC: UIViewController {
    
    private var ctrler: ShowsCtrler!
    var shows = [ShowsVM]()
    var pickerView = UIPickerView()
    var selectedShow: ShowsVM?
    var tapGesture : UITapGestureRecognizer?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        ctrler = ShowsCtrler(self, contextManager: appDelegate.contextManager, apiClient: APIClient())
        ctrler.loadShows(forModel: .popular)
        setUpNavigationBar()
        setUpPickerView()
    }
    
    override func viewDidDisappear(_ animated:Bool) {
        super.viewDidDisappear(animated)
        doneWithPickerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showShowDetailVC" {
            let nextViewController = segue.destination as! ShowsDetailVC
            nextViewController.show = selectedShow
        }
    }

    func networkError(error:Error) {
        let dialog = DialogViewController.dialogWithTitle(title: "Network Error", message: error.localizedDescription, cancelTitle: "Ok")
        dialog.show()
    }
    
    func setUpNavigationBar(){
        let rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Webp.net-resizeimage"), style: .plain, target: self, action: #selector(setMovies))
        navigationItem.rightBarButtonItem = rightBarButtonItem
        navigationItem.rightBarButtonItem?.tintColor = UIColor.white
        navigationItem.title = "Shows"
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7032574415, green: 0.1812901497, blue: 0.2108100057, alpha: 1)
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func setUpPickerView() {
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(doneWithPickerView))
        pickerView.frame = CGRect(x: 0, y: view.bounds.size.height, width: view.bounds.size.width, height: pickerView.bounds.size.height)
        view.addSubview(pickerView)
        pickerView.delegate = self
        pickerView.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    }
    
    @objc func setMovies(){
       
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.size.height - self.pickerView.bounds.size.height, width: self.view.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
        view.addGestureRecognizer(tapGesture!)
    }
    
    @objc func doneWithPickerView() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
        view.removeGestureRecognizer(tapGesture!)
    }
}

//CollectionView Delegate
extension ShowsVC: UICollectionViewDelegate, UICollectionViewDataSource {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shows.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowsCollectionViewCell", for: indexPath) as! ShowsCollectionViewCell
        cell.lblName.text = shows[indexPath.row].name
        let item = shows[indexPath.row]
        cell.imgShow.image = UIImage(named: "placeholder")
        cell.imgShow.contentMode = .scaleAspectFit
        if item.posterImage == nil && item.posterPath != nil {
            ctrler.getImageForShow(show: item, indexPath: indexPath)
        } else if item.posterImage != nil {
            cell.imgShow.image = item.posterImage
            cell.imgShow.contentMode = .scaleToFill
        }
        
        if (indexPath.row > (shows.count - 5)){
            ctrler.loadNextPageShows()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedShow = shows[indexPath.row]
        performSegue(withIdentifier: "showShowDetailVC", sender: self)
    }
}

//PickerViewDelegate Delegate
extension ShowsVC : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData: String
        if row == 0{
            titleData = "Popular"
        }else if row == 1{
            titleData = "On The Air"
        }else{
            titleData = "Top Rated"
        }
        let myTitle = NSAttributedString(string: titleData, attributes: [NSAttributedString.Key.font:UIFont(name: "Georgia", size: 15.0)!,NSAttributedString.Key.foregroundColor:UIColor.white])
        return myTitle
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.view.endEditing(true)
        if row == 0{
            ctrler.loadShows(forModel: .popular)
        }else if row == 1{
            ctrler.loadShows(forModel: .onTheAir)
        }else{
            ctrler.loadShows(forModel: .topRated)
        }
        if shows.count > 0 {
            collectionView!.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        doneWithPickerView()
    }
}

//MoviesVCDelegate Delegate
extension ShowsVC: ShowsVCDelegate {
    
    func updateImage(image: UIImage, indexPath: IndexPath) {
        shows[indexPath.row].posterImage = image
        collectionView.reloadItems(at: [indexPath])
    }
    
    func updateShows(shows: [ShowsVM]) {
        self.shows = shows
        collectionView.reloadData()
    }
}

