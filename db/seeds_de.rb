# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "de", condition: "",                   message: "Notruf-Chatbot%%CALL_TYPE%%. Bitte nennen sie uns ihren Standort.")
BotResponse.create(identifier: "call_type",               seq: 12,   lang: "de", condition: "skip",               message: "Der Einsatztype %%CALL_TYPE_SHORT%% wurde erkannt.")
BotResponse.create(identifier: "address_check",           seq: 20,   lang: "de", condition: "address_invalid",    message: "Bestätigen sie bitte noch einmal ihre Adresse, da die automatisch bereitgestellten Ortsdaten nicht übereinstimmen.")
BotResponse.create(identifier: "calltype_check",          seq: 30,   lang: "de", condition: "calltype_missing",   message: "Nennen sie uns ihren Notfall.")
BotResponse.create(identifier: "calltype_request_1",      seq: 35,   lang: "de", condition: "calltype_unclear",   message: "Sollen wir Rettung, Feuerwehr oder Polizei zu ihnen schicken?")
BotResponse.create(identifier: "calltype_request_2",      seq: 36,   lang: "de", condition: "calltype_unclear",   message: "Die Eingabe wurde nicht erkannt. Sollen wir Rettung, Feuerwehr oder Polizei zu ihnen schicken?")
BotResponse.create(identifier: "calltype_request_3",      seq: 37,   lang: "de", condition: "calltype_unclear",   message: "Die Eingabe wurde wieder nicht erkannt. Bitte schreiben sie 'Rettung', 'Feuerwehr' oder 'Polizei'!")
BotResponse.create(identifier: "health_service",          seq: 40,   lang: "de", condition: "health_response",    message: "Der Einsatztype Rettung wurde erkannt. Ist die Person vollkommen wach?")
BotResponse.create(identifier: "health_service_breath",   seq: 41,   lang: "de", condition: "awake_response",     message: "Atmet die Person?")
BotResponse.create(identifier: "health_service_location", seq: 42,   lang: "de", condition: "health_response",    message: "Wo befindet sich der Patient genau?")
BotResponse.create(identifier: "health_service_bleed",    seq: 43,   lang: "de", condition: "health_response",    message: "Blutet die Person stark?")
BotResponse.create(identifier: "fire_service",            seq: 50,   lang: "de", condition: "fire_response",      message: "Der Einsatztype Feuerwehr wurde erkannt. Sind alle Personen in Sicherheit und außer Gefahr?")
BotResponse.create(identifier: "police_service",          seq: 60,   lang: "de", condition: "police_response",    message: "Der Einsatztype Polizei wurde erkannt. Wie viele Personen sind bei ihnen?")
BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "de", condition: "",                   message: "Vielen Dank, dass sie den Chatbot von DEC112 verwendet haben! Dürfen wir ihren Eingaben zu Trainingszwecken in Einsatzleitzentralen verwenden? Unter diesem Link finden sie eine genaue Beschreibung, wie ihre Daten verwendet werden: http://dec112.eu/chatbot?language=de")
BotResponse.create(identifier: "confirm",                 seq: 91,   lang: "de", condition: "data_confirmed",     message: "Sie haben der Verwendung ihrer Einaben zu Trainingszwecken in Leitzentralen zugestimmt. Dürfen wir sie per Email%%EMAIL_ADDRESS%% zu diesem Chatverlauf kontaktieren? Stimmen sie mit 'Ja' zu oder geben sie eine Emailadresse ein. Der Chat wird in 2 Minuten automatisch beendet. Auf Wiedersehen.")
BotResponse.create(identifier: "contact",                 seq: 92,   lang: "de", condition: "data_not_confirmed", message: "Dürfen wir sie per Email%%EMAIL_ADDRESS%% zu diesem Chatverlauf kontaktieren? Stimmen sie mit 'Ja' zu oder geben sie eine Emailadresse ein. Der Chat wird in 2 Minuten automatisch beendet. Auf Wiedersehen.")
BotResponse.create(identifier: "contact_answer",          seq: 95,   lang: "de", condition: "contact_confirmed",  message: "Wir werden sie in den nächsten Tagen kontaktieren. Der Chat wird in 10 Sekunden automatisch beendet.")

# Mappings
BotResponse.create(identifier: "police",                  seq: 1000, lang: "de", condition: "",                   message: "polizei,verbrechen,gewalt,schießerei")
BotResponse.create(identifier: "health",                  seq: 1001, lang: "de", condition: "",                   message: "rettung,verletzt,blutet,gebrochen,atemnot")
BotResponse.create(identifier: "fire",                    seq: 1002, lang: "de", condition: "",                   message: "feuerwehr,feuer,brennt")
BotResponse.create(identifier: "true",                    seq: 1100, lang: "de", condition: "",                   message: "ja")
BotResponse.create(identifier: "false",                   seq: 1101, lang: "de", condition: "",                   message: "nein,nicht")

# URI Mapping
BotResponse.create(identifier: "police",                  seq: 2000, lang: "",   condition: "",                   message: "133")
BotResponse.create(identifier: "health",                  seq: 2001, lang: "",   condition: "",                   message: "144")
BotResponse.create(identifier: "fire",                    seq: 2002, lang: "",   condition: "",                   message: "122")

# Translations
BotResponse.create(identifier: "police",                  seq: 5000, lang: "de", condition: "",                   message: "Polizei")
BotResponse.create(identifier: "fire",                    seq: 5001, lang: "de", condition: "",                   message: "Feuerwehr")
BotResponse.create(identifier: "health",                  seq: 5002, lang: "de", condition: "",                   message: "Rettung")
