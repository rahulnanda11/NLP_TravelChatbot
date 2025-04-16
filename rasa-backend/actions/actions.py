from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.forms import FormValidationAction
from rasa_sdk.types import DomainDict
from rasa_sdk.events import SlotSet
from datetime import datetime
import requests
from math import radians, cos, sin, asin, sqrt

# ───────────────────────────────────────────────────────────────
# Utility Function: Validate location using Nominatim API
def is_valid_location(location: str) -> bool:
    url = f"https://nominatim.openstreetmap.org/search?q={location}&format=json"
    headers = {"User-Agent": "rasa-travel-bot"}
    response = requests.get(url, headers=headers)
    return bool(response.json())

# ───────────────────────────────────────────────────────────────
# Custom Action: Calculate Distance Between Two Locations
class ActionGetFreeDistance(Action):
    def name(self) -> str:
        return "action_get_free_distance"

    def geocode_location(self, place: str):
        url = f"https://nominatim.openstreetmap.org/search?q={place}&format=json"
        headers = {"User-Agent": "rasa-travel-bot"}
        response = requests.get(url, headers=headers)
        data = response.json()
        if data:
            return float(data[0]["lat"]), float(data[0]["lon"])
        return None, None

    def haversine(self, lat1, lon1, lat2, lon2):
        R = 6371  # Earth radius in kilometers
        dlat = radians(lat2 - lat1)
        dlon = radians(lon2 - lon1)
        a = sin(dlat / 2)**2 + cos(radians(lat1)) * cos(radians(lat2)) * sin(dlon / 2)**2
        c = 2 * asin(sqrt(a))
        return R * c

    def run(
        self,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: Dict[str, Any]
    ) -> List[Dict[Text, Any]]:
        origin = tracker.get_slot("origin")
        destination = tracker.get_slot("destination")

        lat1, lon1 = self.geocode_location(origin)
        lat2, lon2 = self.geocode_location(destination)

        if lat1 and lat2:
            distance = round(self.haversine(lat1, lon1, lat2, lon2), 2)
            dispatcher.utter_message(text=f"The distance between {origin} and {destination} is approximately {distance} km.")
        else:
            dispatcher.utter_message(text="Sorry, I couldn't find one of the locations. Please try again.")

        return []

# ───────────────────────────────────────────────────────────────
# Form Validation: Plan Trip Form
class ValidatePlanTripForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_plan_trip_form"

    def validate_departure_date(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict
    ) -> Dict[Text, Any]:
        try:
            datetime.strptime(slot_value, "%Y-%m-%d")
            return {"departure_date": slot_value}
        except ValueError:
            dispatcher.utter_message(text="Please enter the departure date in YYYY-MM-DD format.")
            return {"departure_date": None}

# ───────────────────────────────────────────────────────────────
# Form Validation: Flight Search Form
class ValidateFlightSearchForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_flight_search_form"

    def validate_location(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict
    ) -> Dict[Text, Any]:
        if is_valid_location(slot_value):
            return {"location": slot_value}
        dispatcher.utter_message(text=f"Sorry, I couldn't recognize '{slot_value}'. Please enter a valid city or location.")
        return {"location": None}

    def validate_departure_date(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict
    ) -> Dict[Text, Any]:
        try:
            datetime.strptime(slot_value, "%Y-%m-%d")
            return {"departure_date": slot_value}
        except ValueError:
            dispatcher.utter_message(text="Please enter the departure date in YYYY-MM-DD format.")
            return {"departure_date": None}

# ───────────────────────────────────────────────────────────────
# Form Validation: Hotel Booking Form
class ValidateHotelBookingForm(FormValidationAction):
    def name(self) -> Text:
        return "validate_hotel_booking_form"

    def validate_checkin_date(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict
    ) -> Dict[Text, Any]:
        try:
            datetime.strptime(slot_value, "%Y-%m-%d")
            return {"checkin_date": slot_value}
        except ValueError:
            dispatcher.utter_message(text="Please enter the check-in date in YYYY-MM-DD format.")
            return {"checkin_date": None}

    def validate_num_nights(
        self,
        slot_value: Any,
        dispatcher: CollectingDispatcher,
        tracker: Tracker,
        domain: DomainDict
    ) -> Dict[Text, Any]:
        try:
            nights = int(slot_value)
            if nights <= 0:
                dispatcher.utter_message(text="Number of nights must be at least 1.")
                return {"num_nights": None}
            return {"num_nights": nights}
        except (ValueError, TypeError):
            dispatcher.utter_message(text="Please enter a valid number of nights.")
            return {"num_nights": None}
