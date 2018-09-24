//
//  AccommodationDetailsViewController.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 24.02.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

import UIKit
import MapKit
import SVProgressHUD

class AccommodationDetailsViewController: UIViewController, MKMapViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    let imagesReuseIdentifier = "imageCell" // also enter this string as the cell identifier in the storyboard
    let featuresReuseIdentifier = "featuresCell"
    
    var accommodationProperties = [String]()
    var selectedAccommodationId: String = ""
    var selectedAccommodationType: String = ""
    var picturesURLArray = [String]()
    var largePicturesURLArray = [String]()
    
    var featutesFilesArray = [String]()
    var advantagesFilesArray = [String]()
    
    let mapType = MKMapType.standard
    var selectedPicture: Int = 0
    
    var gpsLat: Double = 0.0
    var gpsLng: Double = 0.0
    var pinTitle: String = ""
    var pinSubtitle: String = ""

    @IBOutlet var mainView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var phoneTextView: UITextView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!   
    @IBOutlet weak var prizeUnitLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var phoneTextViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var featuresCollectionView: UICollectionView!
    
    @IBOutlet weak var featuresSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var imageCollectionViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var accommodationPropertiesCollectionViewHeightContraint: NSLayoutConstraint!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }

    lazy var viewModel: AccommodationDetailsViewModel = {
        return AccommodationDetailsViewModel()
    }()
    
    // init view model
    
    func initViewModel () {
        
        let dispatchGroup = DispatchGroup()
        
        viewModel.updateGalleryViewClosure = {
            DispatchQueue.main.async {
                let accomodationGalleryModel = self.viewModel.getAccommodationGallery()
                
                if let pictures = accomodationGalleryModel {
                    if (pictures.mainImgMini.count != 0) {
                        self.picturesURLArray.append(pictures.dirMainPicture + pictures.mainImgMini)
                        self.largePicturesURLArray.append(pictures.dirMainPicture + pictures.mainImgFull)
                    }
                    
                    for picture in pictures.arrayOfPictures {
                        self.picturesURLArray.append(pictures.dirMiniPictures + picture)
                        self.largePicturesURLArray.append(pictures.dirLargePictures + picture)
                    }
                    
                    self.imageCollectionViewHeightContraint.constant = ImageCollectionViewHeight.large.rawValue
                    self.imageCollectionView.reloadData()
                    self.view.updateLayoutWithAnimation(andDuration: 0.5)
                }
                else {
                    print ("No pictures to show")
                }
                dispatchGroup.leave()
            }
        }
        
        viewModel.updateDetailViewClosure = {
            DispatchQueue.main.async {
                let accommodationDetailsModel = self.viewModel.getAccommodationDetailsModel()
                
                if let details = accommodationDetailsModel {
                    self.gpsLat = details.gpsLat
                    self.gpsLng = details.gpsLng
                    self.pinTitle = details.name
                    self.pinSubtitle = details.phone
                    
                    self.mapView.fillMap(details.gpsLat, details.gpsLng, details.name, details.phone, self.mapType)
                    
                    self.nameLabel.text = details.name
                    self.priceLabel.text = details.price
                    self.phoneTextView.text = details.phone.replacingOccurrences(of: "<br>", with: "\n")
                    
                    self.phoneTextView.updateHeight(of: self.phoneTextViewHeightContraint)
                    self.view.updateLayoutWithAnimation(andDuration: 0.5)
                    self.headerView.isHidden = false
                    
                    // remove all html tags
                    
                    let detailsStripped = details.description.removeHTMLTags()
                    self.descriptionTextView.text = detailsStripped
                }
                else {
                    print ("No accommodation details to show")
                }
                dispatchGroup.leave()

            }
        }
        
        viewModel.updatePropertiesViewClosure = {
            DispatchQueue.main.async {
                let accommodationPropertiesModel = self.viewModel.getAccommodationProperties()
                
                if let properties = accommodationPropertiesModel {
                    
                    self.featutesFilesArray = properties.features
                    self.advantagesFilesArray = properties.advantages
                    
                    // accommodationProperties will store features or advantages
                    // depends on user demand. Default is features
                    
                    self.accommodationProperties = self.featutesFilesArray
                    
                    // reload and update collection view height
                    
                    self.accommodationPropertiesPostProcessOperations(focusOnTheBottomOfScrollView: false)
                }
                else {
                    print ("No properties to save")
                }
                dispatchGroup.leave()
            }
        }
        
        // Use GCD to synchronize the network tasks
        
        dispatchGroup.enter()
        self.viewModel.fetchAccommodationDetails(for: self.selectedAccommodationId, accommodationType: self.selectedAccommodationType)
        
        dispatchGroup.enter()
        self.viewModel.fetchAccommodationGallery(for: self.selectedAccommodationId)
        
        dispatchGroup.enter()
        self.viewModel.fetchAccommodationProperties(for: self.selectedAccommodationId)

        // call closure when the group's task count reaches 0
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            SVProgressHUD.dismiss()
            self?.scrollView.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // hide everything while loading
        
        self.scrollView.isHidden = true
        self.headerView.isHidden = true
        
        // hide images collection view (since we don't know if there are any images at all)
        
        self.imageCollectionViewHeightContraint.constant = ImageCollectionViewHeight.small.rawValue // left small row for better user experience
        
        // header
        
        self.headerView.backgroundColor = UIColor(patternImage: UIImage(named:"background_blue")!)
        self.headerView.addBlurSubview(at: 0)
        
        // the whole view
        
        self.mainView.backgroundColor = UIColor(patternImage: UIImage(named:"background_gradient2")!)
        self.mainView.addBlurSubview(at: 0)

        print("selected accommodation id: \(self.selectedAccommodationId)");
        
        SVProgressHUD.show()
        
        initViewModel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UICollectionViewDataSource protocol
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == self.imageCollectionView) {
            return self.picturesURLArray.count
        }
        else {
            return self.accommodationProperties.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if (collectionView == self.imageCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: imagesReuseIdentifier, for: indexPath as IndexPath) as! ImageCell
            
            cell.imageView.downloadImageAsync(self.picturesURLArray[indexPath.row])
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: featuresReuseIdentifier, for: indexPath as IndexPath) as! FeaturesCell
            
            let featureImage = UIImage(named: self.accommodationProperties[indexPath.row])
            cell.featureImageView.image = featureImage
            
            return cell
        }
    }
    
    // MARK: - UICollectionViewDelegate protocol
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
       // self.selectedPicture = indexPath.item
        
    }
    
    func accommodationPropertiesPostProcessOperations(focusOnTheBottomOfScrollView focus: Bool) {
        let queue = OperationQueue()
        
        let reloadCollectionView = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                self.featuresCollectionView.reloadData()
                self.featuresCollectionView.layoutIfNeeded()
                
            })
        })
        
        queue.addOperation(reloadCollectionView)
        
        let updateCollectionViewHeightContraint = BlockOperation(block: {
            
            OperationQueue.main.addOperation({
                self.accommodationPropertiesCollectionViewHeightContraint.constant = self.featuresCollectionView.contentSize.height
                
                self.view.updateLayoutWithAnimation(andDuration: 0.5)
            })
        })
        
        updateCollectionViewHeightContraint.addDependency(reloadCollectionView)
        queue.addOperation(updateCollectionViewHeightContraint)
        
        if(focus) {
            let focusOnTheBottomOfScrollView = BlockOperation(block: {
                
                OperationQueue.main.addOperation({
                    let contentSizeHeight = self.scrollView.contentSize.height;
                    let boundsSizeHeight = self.scrollView.bounds.size.height;
                    
                    // if contentSizeHeight is larger than boundsSizeHeight (f.e. iPad in portrait mode)
                    // we should not touch content offset at all
                    
                    if (boundsSizeHeight < contentSizeHeight) {
                        let bottomOffset = CGPoint(x: 0, y: contentSizeHeight - boundsSizeHeight)
                        self.scrollView.setContentOffset(bottomOffset, animated: true)
                    }
                })
            })
            
            focusOnTheBottomOfScrollView.addDependency(updateCollectionViewHeightContraint)
            queue.addOperation(focusOnTheBottomOfScrollView)
        }
    }
    
    @IBAction func featuresIndexChanged(_ sender: Any) {
        switch featuresSegmentedControl.selectedSegmentIndex
        {
        case 0:
             self.accommodationProperties = self.featutesFilesArray
        case 1:
            self.accommodationProperties = self.advantagesFilesArray
        default:
            break; 
        }
        
        // reload, update collection view height, focus on the bottom of scrollview
        
        self.accommodationPropertiesPostProcessOperations(focusOnTheBottomOfScrollView: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

            if segue.identifier == "showAccommodationMap" {
                let controller = segue.destination as! AccommodationMapViewController
                controller.gpsLat = self.gpsLat
                controller.gpsLng = self.gpsLng
                controller.pinTitle = self.pinTitle
                controller.pinSubtitle = self.pinSubtitle
            }
        
            if segue.identifier == "showAccommodationGallery" {
                let controller = segue.destination as! AccommodationGalleryPageViewController
                
                // The sender argument will be the cell so we can get the indexPath from the cell,
                
                let cell = sender as! ImageCell
                let indexPaths = self.imageCollectionView!.indexPath(for: cell)
                controller.selectedPictureIndex = (indexPaths?.last)! as Int
                controller.picturesURLArray = self.largePicturesURLArray
                
        }
    }
    
}
