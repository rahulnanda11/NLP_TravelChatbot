#When your bot needs to do something smart (like call an API), it runs a Python function from here.
from typing import Any, Text, Dict, List
from rasa_sdk import Action, Tracker
from rasa_sdk.executor import CollectingDispatcher
from rasa_sdk.events import FollowupAction  # Critical for form reactivation

class ActionConfirmTrip(Action):
    # Define the action name, which matches the name in the domain.yml
    def name(self) -> Text:
        return "action_confirm_trip"

    def run(self, dispatcher: CollectingDispatcher,
            tracker: Tracker,
            domain: Dict[Text, Any]) -> List[Dict[Text, Any]]:
        
        # Retrieve slot values for 'destination' and 'departure_date'
        destination = tracker.get_slot("destination")
        date = tracker.get_slot("departure_date")

        # Check if both destination and departure date are provided
        if destination and date:
            # Confirm the trip if both slots are filled
            dispatcher.utter_message(
                text=f"✅ Your trip to **{destination.title()}** on **{date}** has been confirmed. Bon voyage! 🌍✈️"
            )
            return []  # No further actions needed if the trip is confirmed

        else:
            # Handle missing information: Check which details are missing
            missing = []
            if not destination:
                missing.append("destination")
            if not date:
                missing.append("departure date")
            
            # Ask the user to provide the missing details
            dispatcher.utter_message(
                text=f"🔍 Please provide: {', '.join(missing)}"
            )
            # Reactivate the form to gather the missing information
            return [FollowupAction("plan_trip_form")]  # Restart the form to collect missing details
