//
//  AccommodationType.swift
//  WczasyNadBialym
//
//  Created by Marek Hać on 06.11.2017.
//  Copyright © 2017 Marek Hać. All rights reserved.
//

struct AccommodationType {
    var shortName : String
    var longName : String
}

let AccommodationTypesArray = [AccommodationType(shortName: "osrodek_wypoczynkowy", longName: "Ośrodki Wypoczynkowe"),
                               AccommodationType(shortName: "pokoje", longName: "Wynajem Pokoi"),
                               AccommodationType(shortName: "hotel_pensjonat", longName: "Hotele / Pensjonaty"),
                               AccommodationType(shortName: "camping_pole", longName: "Pola Namiotowe")]

