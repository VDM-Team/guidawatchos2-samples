//
//  WeatherInterfaceController.swift
//  WatchMeteo
//
//  Created by Francesco Ingrassia on 20/02/16.
//  Copyright © 2016 Guida alla programmazione su watchOS 2. All rights reserved.
//

import WatchKit
import Foundation


class WeatherInterfaceController: WKInterfaceController {

	@IBOutlet var lblPlace: WKInterfaceLabel!
	@IBOutlet var lblDescription: WKInterfaceLabel!
	@IBOutlet var imgWeather: WKInterfaceImage!
	@IBOutlet var imgActivity: WKInterfaceImage!
	@IBOutlet var pckDate: WKInterfacePicker!
	
	var place: Place?
	var forecast: Forecast?
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
		self.place = context as? Place
		lblPlace.setText(place?.name)
		lblPlace.sizeToFitWidth()
		lblPlace.setHorizontalAlignment(.Center)
		imgWeather.setWidth(0)
		pckDate.setHidden(true)
	}
	
	override func willActivate() {
		super.willActivate()
		imgActivity.setImageNamed("Activity")
		imgActivity.startAnimatingWithImagesInRange(NSMakeRange(1, 5), duration: 1.0, repeatCount: 0)
		
		Facade.getForecastForPlace((place?.name)!) { (forecast, error) -> Void in
			if error != nil {
				let closeAction = WKAlertAction(title: "Chiudi", style: .Default,
					handler: { () -> Void in
						self.popToRootController()
				})
				self.presentAlertControllerWithTitle("Attenzione", message: "Servizio al momento non disponibile", preferredStyle: .Alert, actions:[closeAction])
			} else {
				self.forecast = forecast
				var items = [WKPickerItem]()
				let dateFormatter = NSDateFormatter()
				dateFormatter.timeStyle = .NoStyle
				dateFormatter.dateFormat = "EEE dd MMM"
				for w in (forecast?.list)! {
					let weather = w as! Weather
					let item: WKPickerItem = WKPickerItem()
					item.title = dateFormatter.stringFromDate(weather.date)
					item.accessoryImage = WKImage(imageName:weather.icon)
					items.append(item)
				}
				self.pckDate.setItems(items)
				self.pckDate.setHidden(false)
				self.refresh()
			}
		}
	}

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	func refresh() {
		let todayWeather = forecast?.list.first as! Weather
		lblDescription.setText(todayWeather.longDescription)
		self.animateWithDuration(1.5) { () -> Void in
			self.imgActivity.setHidden(true)
			self.imgWeather.setImageNamed(todayWeather.icon)
			self.lblPlace.setRelativeWidth(1.0, withAdjustment: -50)
			self.imgWeather.setWidth(50)
		}
	}
	
	@IBAction func pckDateValueDidChange(value: Int) {
		let weather = (forecast?.list[value]) as! Weather
		lblDescription.setText(weather.longDescription)
		imgWeather.setImageNamed(weather.icon)
	}

}