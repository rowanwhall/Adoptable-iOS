//
//  SearchArgumentMapper.swift
//  Adoptable
//
//  Created by Rowan Hall on 2/25/21.
//  Copyright © 2021 Rowan Hall. All rights reserved.
//

import Foundation

class SearchArgumentMapper {
    
    static func animalTypeFromIndex(index: Int) -> String? {
        switch index {
        case 1:
            return "dog"
        case 2:
            return "cat"
        case 3:
            return "bird"
        case 4:
            return "scales-fins-other"
        case 5:
            return "small-furry"
        case 6:
            return "horse"
        case 7:
            return "rabbit"
        case 8:
            return "barnyard"
        default:
            return nil
        }
    }

    static func sizeFromIndex(index: Int) -> String? {
        switch index {
        case 1:
            return "small"
        case 2:
            return "medium"
        case 3:
            return "large"
        case 4:
            return "xlarge"
        default:
            return nil
        }
    }
    
    static func ageFromIndex(index: Int) -> String? {
        switch index {
        case 1:
            return "baby"
        case 2:
            return "young"
        case 3:
            return "adult"
        case 4:
            return "senior"
        default:
            return nil
        }
    }
    
    static func sexFromIndex(index: Int) -> String? {
        switch index {
        case 1:
            return "male"
        case 2:
            return "female"
        default:
            return nil
        }
    }
    
}
