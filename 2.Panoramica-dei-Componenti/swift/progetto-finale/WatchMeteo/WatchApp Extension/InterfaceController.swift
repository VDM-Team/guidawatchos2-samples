//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Francesco Ingrassia on 20/02/16.
//  Copyright © 2016 Guida alla programmazione su watchOS 2. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
	
	@IBOutlet var tblPlaces: WKInterfaceTable!
	
	var forecast:Forecast?
	
	override func awakeWithContext(context: AnyObject?) {
		super.awakeWithContext(context)
		let places = DataManager.sharedInstance().places()
		tblPlaces.setNumberOfRows(places.count, withRowType: "PlaceRow")
		for (var i=0; i<places.count; i++) {
			let row: PlaceRowController = tblPlaces.rowControllerAtIndex(i) as!
			PlaceRowController
			let place: Place = places[i] as! Place
			row.lblPlace.setText(place.name)
		}
	}
	
	
	override func willActivate() {
		// This method is called when watch view controller is about to be visible to user
		super.willActivate()
	}
	
	override func didDeactivate() {
		// This method is called when watch view controller is no longer visible
		super.didDeactivate()
	}
	
	@IBAction func btnSearchPressed() {
		self.presentTextInputControllerWithSuggestions(["Milano", "Roma", "Napoli"],
		allowedInputMode: .Plain) { (result: [AnyObject]?) -> Void in
			if let res = result?.first {
			self.handleSearchForKey(res as! String)
			}
		}
	}

	override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
		let place: Place = DataManager.sharedInstance().places()[rowIndex] as! Place
		self.pushControllerWithName("WeatherInterfaceController", context: place)
	}
	
	func handleSearchForKey(key: String) {
		
		Facade.getForecastForPlace(key) { (forecast, error) -> Void in
			if error != nil {
				//show error
			} else {
				self.forecast = forecast
				self.refresh()
	
			}
		}
	}
	
	func refresh() {
		let todayWeather:Weather = forecast?.list.first as! Weather
		DataManager.sharedInstance().addPlace(todayWeather.place!)
		let indexSet: NSIndexSet = NSIndexSet(index: 0)
		self.tblPlaces.insertRowsAtIndexes(indexSet, withRowType: "PlaceRow")
		let row: PlaceRowController = self.tblPlaces.rowControllerAtIndex(0) as! PlaceRowController
		row.lblPlace.setText(todayWeather.place?.name)
		
	}
}
