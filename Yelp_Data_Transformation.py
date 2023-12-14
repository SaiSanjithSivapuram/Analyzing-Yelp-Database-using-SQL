import pandas as pd
import json

# Taking File Inputs from the user
businessFilePath = input("Enter path location for yelp_academic_dataset_business.json : ")
reviewFilePath = input("Enter path location for yelp_academic_dataset_review.json : ")
userFilePath = input("Enter path location for yelp_dataset/yelp_academic_dataset_user.json : ")

# Data Transformation and Pre-processing step
FilePaths = {'business': businessFilePath, 'review': reviewFilePath, 'user': userFilePath}

for file_name, path in FilePaths.items():
    Data = []
    if file_name == 'review':
        Data = open(path, 'r', encoding="utf8").readlines()[:300000]
    elif file_name == 'user':
        Data = open(path, 'r', encoding="utf8").readlines()[:1000000]
    else:
        Data = open(path, 'r', encoding="utf8").readlines()

    print("Processing", file_name)
    print("Data Length", len(Data))

    jsonData = []
    for i in Data:
        if len(i) > 0:
            jsonData.append(json.loads(i[:-1]))

    df = pd.json_normalize(jsonData)

    if file_name == 'business':
        columns_to_drop = ["hours", "hours.Monday", "hours.Tuesday", "hours.Wednesday", "hours.Thursday", "hours.Friday", "hours.Saturday", "hours.Sunday", "attributes","attributes.ByAppointmentOnly","attributes.BusinessAcceptsCreditCards","attributes.BikeParking","attributes.RestaurantsPriceRange2","attributes.CoatCheck","attributes.RestaurantsTakeOut","attributes.RestaurantsDelivery","attributes.Caters","attributes.WiFi","attributes.BusinessParking","attributes.WheelchairAccessible","attributes.HappyHour","attributes.OutdoorSeating","attributes.HasTV","attributes.RestaurantsReservations","attributes.DogsAllowed","attributes.Alcohol","attributes.GoodForKids","attributes.RestaurantsAttire","attributes.Ambience","attributes.RestaurantsTableService","attributes.RestaurantsGoodForGroups","attributes.DriveThru","attributes","attributes.NoiseLevel","attributes.GoodForMeal","attributes.BusinessAcceptsBitcoin","attributes.Smoking","attributes.Music","attributes.GoodForDancing","attributes.AcceptsInsurance","attributes.BestNights","attributes.BYOB","attributes.Corkage","attributes.BYOBCorkage","attributes.HairSpecializesIn","attributes.Open24Hours","attributes.RestaurantsCounterService","attributes.AgesAllowed","attributes.DietaryRestrictions"]
        df.drop(columns_to_drop, axis=1, inplace=True)
    if file_name == 'review':
        df.drop(['text'], axis=1, errors='ignore', inplace=True)
    if file_name == 'user':
        columns_to_drop = ['useful', 'funny', 'cool', 'fans', 'elite', 'friends','compliment_hot', 'compliment_more',
                               'compliment_profile', 'compliment_cute', 'compliment_list', 'compliment_note',
                               'compliment_plain', 'compliment_cool', 'compliment_funny', 'compliment_writer',
                               'compliment_photos']
        df.drop(columns_to_drop, axis=1, errors='ignore', inplace=True)

    print(df.head())
    df.to_csv(f"yelp_{file_name}.csv", index=False)
    print("\n\n")