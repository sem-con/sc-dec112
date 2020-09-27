# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "fr", condition: "",                   message: "Chatbot d'urgence%%CALL_TYPE%%. Indiquez votre position.")
BotResponse.create(identifier: "call_type",               seq: 12,   lang: "fr", condition: "skip",               message: "Le type de mission %%CALL_TYPE_SHORT%% n'a pas été reconnu.")
BotResponse.create(identifier: "address_check",           seq: 20,   lang: "fr", condition: "address_invalid",    message: "Veuillez donner votre addresse en absence de géolocalisation automatique. ")
BotResponse.create(identifier: "calltype_check",          seq: 30,   lang: "fr", condition: "calltype_missing",   message: "Quell est votre urgence?")
BotResponse.create(identifier: "calltype_request_1",      seq: 35,   lang: "fr", condition: "calltype_unclear",   message: "Avez-vous besoin d'une ambulance, des pompiers, ou de la police?")
BotResponse.create(identifier: "calltype_request_2",      seq: 36,   lang: "fr", condition: "calltype_unclear",   message: "Réponse non reconnue. Avez-vous besoin d'une ambulance, des pompiers, ou de la police?")
BotResponse.create(identifier: "calltype_request_3",      seq: 37,   lang: "fr", condition: "calltype_unclear",   message: "Réponse non reconue. Veuillez écrire 'ambulance', 'pompiers' ou 'police'!")
BotResponse.create(identifier: "health_service",          seq: 40,   lang: "fr", condition: "health_response",    message: "Vous avez besoin d'une ambulance. La personne est elle en pleine conscience?")
BotResponse.create(identifier: "health_service_breath",   seq: 41,   lang: "fr", condition: "awake_response",     message: "La personne respire-t-elle?")
BotResponse.create(identifier: "health_service_location", seq: 42,   lang: "fr", condition: "health_response",    message: "Où le patient est-il localisé?")
BotResponse.create(identifier: "health_service_bleed",    seq: 43,   lang: "fr", condition: "health_response",    message: "La personne saigne-t-elle beaucoup?")
BotResponse.create(identifier: "fire_service",            seq: 50,   lang: "fr", condition: "fire_response",      message: "Vous avez besoin d'une intervention des pompiers. Toutes les personnes sont-elles hors de danger?")
BotResponse.create(identifier: "police_service",          seq: 60,   lang: "fr", condition: "police_response",    message: "Vous avez besoin d’une intervention de la police. Combien de personnes sont concernées?")
BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "fr", condition: "",                   message: "Merci d'utiliser le chatbot DEC112 ! Acceptez-vous que vos données soient utilisées à des fins d'amélioration de nos services, dans nos centres d'opérations et de contrôle ? Vous trouverez plus d'informations sur l'usage de vos données à ce lien: http://dec112.at/chatbot?language=fr")
BotResponse.create(identifier: "confirm",                 seq: 91,   lang: "fr", condition: "data_confirmed",     message: "Vous avez accepté que vos données soient exploités par nos centres de contrôle. Peut-on vous contacter par email (%%EMAIL_ADDRESS%%) à propos de cet historique ? Donnez votre accord 'Oui' ou entrez une addresse mail. Cette discussion se termine dans 2 minutes. Au revoir.")
BotResponse.create(identifier: "contact",                 seq: 92,   lang: "fr", condition: "data_not_confirmed", message: "Vos données ne seront pas utilisées. Peut-on vous contacter par email (%%EMAIL_ADDRESS%%) à propos de cet historique ? Donnez votre accord 'Oui' ou entrez une addresse mail. Cette discussion se termine dans 2 minutes. Au revoir.")
BotResponse.create(identifier: "contact_answer",          seq: 95,   lang: "fr", condition: "contact_confirmed",  message: "Nous vous contacterons dans les prochains jours. Cette discussion terminera automatiquement dans 10 secondes.")

# Mappings
BotResponse.create(identifier: "police",                  seq: 1000, lang: "fr", condition: "",                   message: "police, crime, violence, coups de feu")
BotResponse.create(identifier: "health",                  seq: 1001, lang: "fr", condition: "",                   message: "secours, ambulance, blessé, saigne, cassé, mort")
BotResponse.create(identifier: "fire",                    seq: 1002, lang: "fr", condition: "",                   message: "feu, brigade, brulûres")
BotResponse.create(identifier: "true",                    seq: 1100, lang: "fr", condition: "",                   message: "oui, consentement")
BotResponse.create(identifier: "false",                   seq: 1101, lang: "fr", condition: "",                   message: "non, ne pas, rejetter")

# URI Mapping
BotResponse.create(identifier: "police",                  seq: 2000, lang: "fr",   condition: "",                 message: "133, pinger")
BotResponse.create(identifier: "health",                  seq: 2001, lang: "fr",   condition: "",                 message: "144")
BotResponse.create(identifier: "fire",                    seq: 2002, lang: "fr",   condition: "",                 message: "122")

# Translations
BotResponse.create(identifier: "police",                  seq: 5000, lang: "fr", condition: "",                   message: "police")
BotResponse.create(identifier: "fire",                    seq: 5001, lang: "fr", condition: "",                   message: "pompiers")
BotResponse.create(identifier: "health",                  seq: 5002, lang: "fr", condition: "",                   message: "ambulance")
