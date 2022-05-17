//
//  ViewController.swift
//  Map
//
//  Created by 윤동관 on 2022/05/17.
//

import UIKit
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet var myMap: MKMapView!
    @IBOutlet var locationInfo1: UILabel!
    @IBOutlet var locationInfo2: UILabel!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationInfo1.text = ""
        locationInfo2.text = ""
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        myMap.showsUserLocation = true
        
    }

    @IBAction func sgChangeLocation(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.locationInfo1.text = ""
            self.locationInfo2.text = ""
            locationManager.startUpdatingLocation()
        }else if sender.selectedSegmentIndex == 1{
            setAnnotation(latitudeValue: 37.751853, longitudeValue: 128.8760574, delta: 1, title: "한국폴리텍대학 강릉캠퍼스", subtitle: "강원도 강릉시 남산초교길 121")
            self.locationInfo1.text = "보고 계신 위치"
            self.locationInfo2.text = "한국폴리텍대학 강릉캠퍼스"
        }else if sender.selectedSegmentIndex == 2{
            setAnnotation(latitudeValue: 37.556876, longitudeValue: 126.914066, delta: 0.1, title: "이지스 퍼블리싱", subtitle: "서울시 마포구 잔다리로 109 이지스 빌딩")
            self.locationInfo1.text = "보고 계신 위치"
            self.locationInfo2.text = "이지스퍼블리싱 출판사"
        }
        
    }
    func setAnnotation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double, title strTitle: String, subtitle strSubtitle: String){
        let annotaion = MKPointAnnotation()
        
        annotaion.coordinate = goLocation(latitudeValue: latitudeValue, longitudeValue: longitudeValue, delta: span)
        annotaion.title = strTitle
        annotaion.subtitle = strSubtitle
        myMap.addAnnotation(annotaion)
    }
    
    func goLocation(latitudeValue: CLLocationDegrees, longitudeValue: CLLocationDegrees, delta span: Double) -> CLLocationCoordinate2D{
        let pLocation = CLLocationCoordinate2DMake(latitudeValue, longitudeValue)
        let spanValue = MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span)
        let pRegion = MKCoordinateRegion(center: pLocation, span: spanValue)
        myMap.setRegion(pRegion, animated: true)
        return pLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpateLocations locations: [CLLocation]){
        let pLocation = locations.last
        _ = goLocation(latitudeValue: (pLocation?.coordinate.latitude)!, longitudeValue: (pLocation?.coordinate.longitude)!, delta: 0.01)
        CLGeocoder().reverseGeocodeLocation(pLocation!, completionHandler: {
          (placemarks, error) -> Void in
            let pm = placemarks!.first
            let country = pm!.country
            var address: String = country!
            if pm!.locality != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            if pm!.thoroughfare != nil{
                address += " "
                address += pm!.thoroughfare!
            }
            
            self.locationInfo1.text = "현재 위치"
            self.locationInfo2.text = address
        })
        locationManager.stopUpdatingLocation()
    }

}

