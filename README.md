# ✈️ NLP-based Travel Chatbot
An academic project developed using **Flutter** and **Rasa** that serves as an AI-powered travel assistant. This chatbot interacts with users through natural language, providing flight details and travel information in a conversational format.

## 📚 Project Overview
This project demonstrates the integration of Natural Language Processing (NLP) with mobile app development. The chatbot is capable of understanding user queries like "Find me a flight to Paris" or "Show me travel options," and responds with relevant travel data.
Built as part of an academic submission, this project showcases core concepts in NLP, conversational AI, and cross-platform mobile app development.

## 🧠 Features
- Intent recognition using Rasa NLU  
- Custom actions for flight and travel-related queries  
- Real-time conversation interface  
- Clean Flutter-based mobile frontend  
- Easily extendable with external APIs (e.g., flight price, hotel info)

## 🗂️ Project Structure
TravelChatbot/
├── rasa-backend/                     # Rasa NLU + Core backend (Python)
│   ├── data/                         # Training data directory
│   │   ├── nlu.md                    # NLU training data
│   │   ├── rules.yml                 # Rules configuration
│   │   └── stories.yml               # Conversation stories
│   ├── models/                       # Trained models
│   ├── actions/                      # Custom actions
│   ├── config.yml                    # NLP pipeline configuration
│   └── domain.yml                    # Intents, entities, responses
└── flutter-frontend/                 # Flutter mobile app (Dart)
    ├── lib/
    ├── assets/
    └── pubspec.yaml

## 🚀 Setup Instructions
### 🔧 Rasa Backend
```
cd rasa-backend
rasa train
rasa run actions &
rasa run --enable-api --cors "*"
rasa shell
```

## Flutter Frontend
```
cd flutter-frontend
flutter pub get
flutter run
```

## Developed By
Rahul N – Flutter App, Rasa Backend, NLP Training UI/UX, Integration

## Academic Context
This chatbot was created as part of a course project on Artificial Intelligence and Natural Language Processing. It is intended to demonstrate practical skills in AI-driven conversational interfaces and mobile application development.

## License
This project is licensed under the MIT License.
