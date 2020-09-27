# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "en", condition: "",                   message: "Emergency chatbot%%CALL_TYPE%%. Please tell us your location.")
BotResponse.create(identifier: "call_type",               seq: 12,   lang: "de", condition: "skip",               message: "The mission type %%CALL_TYPE_SHORT%% was recognized.")
BotResponse.create(identifier: "address_check",           seq: 20,   lang: "en", condition: "address_invalid",    message: "Please confirm your address because the automatically provided location data does not match.")
BotResponse.create(identifier: "calltype_check",          seq: 30,   lang: "en", condition: "calltype_missing",   message: "Tell us your emergency.")
BotResponse.create(identifier: "calltype_request_1",      seq: 35,   lang: "en", condition: "calltype_unclear",   message: "Shall we send ambulance, fire, or police?")
BotResponse.create(identifier: "calltype_request_2",      seq: 36,   lang: "en", condition: "calltype_unclear",   message: "The entry was not recognized. Shall we send ambulance, fire, or police?")
BotResponse.create(identifier: "calltype_request_3",      seq: 37,   lang: "en", condition: "calltype_unclear",   message: "The entry was again not recognized. Please write 'ambulance', 'fire', or 'police'!")
BotResponse.create(identifier: "health_service",          seq: 40,   lang: "en", condition: "health_response",    message: "The mission type ambulance was recognized. Is the person fully awake?")
BotResponse.create(identifier: "health_service_breath",   seq: 41,   lang: "en", condition: "awake_response",     message: "Is the person breathing?")
BotResponse.create(identifier: "health_service_location", seq: 42,   lang: "en", condition: "health_response",    message: "Where exactly is the patient located?")
BotResponse.create(identifier: "health_service_bleed",    seq: 43,   lang: "en", condition: "health_response",    message: "Is the person bleeding heavily?")
BotResponse.create(identifier: "fire_service",            seq: 50,   lang: "en", condition: "fire_response",      message: "The mission type fire was recognized. Are all people safe and out of danger?")
BotResponse.create(identifier: "police_service",          seq: 60,   lang: "en", condition: "police_response",    message: "The mission type police was recognized. How many people are there?")
BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "en", condition: "",                   message: "Thank you for using the DEC112 chatbot! May we use your input for training purposes in operations control centers? Under this link you will find a detailed description of how your data is used: http://dec112.eu/chatbot?language=en")
BotResponse.create(identifier: "confirm",                 seq: 91,   lang: "en", condition: "data_confirmed",     message: "You have consented to the use of your inputs for training purposes in control centers. May we contact you via email (%%EMAIL_ADDRESS%%) about this chat history? Agree with 'Yes' or enter an email address. The chat will automatically end in 2 minutes. Goodbye.")
BotResponse.create(identifier: "contact",                 seq: 92,   lang: "en", condition: "data_not_confirmed", message: "Your data will not be used. May we contact you via email (%%EMAIL_ADDRESS%%) about this chat history? Agree with 'Yes' or enter an email address. The chat will automatically end in 2 minutes. Goodbye.")
BotResponse.create(identifier: "contact_answer",          seq: 95,   lang: "en", condition: "contact_confirmed",  message: "We will contact you in the next few days. The chat will automatically end in 10 seconds.")

# Mappings
BotResponse.create(identifier: "police",                  seq: 1000, lang: "en", condition: "",                   message: "police, crime, violence, shoot")
BotResponse.create(identifier: "health",                  seq: 1001, lang: "en", condition: "",                   message: "rescue, ambulance, injured, bleeding, broken, breath")
BotResponse.create(identifier: "fire",                    seq: 1002, lang: "en", condition: "",                   message: "fire, brigade, burns")
BotResponse.create(identifier: "true",                    seq: 1100, lang: "en", condition: "",                   message: "yes, consent")
BotResponse.create(identifier: "false",                   seq: 1101, lang: "en", condition: "",                   message: "no, reject")

# URI Mapping
BotResponse.create(identifier: "police",                  seq: 2000, lang: "",   condition: "",                   message: "133, pinger")
BotResponse.create(identifier: "health",                  seq: 2001, lang: "",   condition: "",                   message: "144")
BotResponse.create(identifier: "fire",                    seq: 2002, lang: "",   condition: "",                   message: "122")

# Translations
BotResponse.create(identifier: "police",                  seq: 5000, lang: "en", condition: "",                   message: "police")
BotResponse.create(identifier: "fire",                    seq: 5001, lang: "en", condition: "",                   message: "fire")
BotResponse.create(identifier: "health",                  seq: 5002, lang: "en", condition: "",                   message: "ambulance")
