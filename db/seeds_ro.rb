# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "ro", condition: "",                   message: "Chatbot apel de urgenta%%CALL_TYPE%%. Va rugam introduceti locatia.")
BotResponse.create(identifier: "call_type",               seq: 12,   lang: "ro", condition: "skip",               message: "Tipul interventiei %%CALL_TYPE_SHORT%% a fost identificat.")
BotResponse.create(identifier: "address_check",           seq: 20,   lang: "ro", condition: "address_invalid",    message: "Va rugam confirmati adresa, deoarece locatia furnizata automat nu corespunde cu locatia introdusa.")
BotResponse.create(identifier: "calltype_check",          seq: 30,   lang: "ro", condition: "calltype_missing",   message: "Spuneti-ne urgenta dvs.")
BotResponse.create(identifier: "calltype_request_1",      seq: 35,   lang: "ro", condition: "calltype_unclear",   message: "Trebuie sa va trimitem Salvarea, Pompierii sau Politia?")
BotResponse.create(identifier: "calltype_request_2",      seq: 36,   lang: "ro", condition: "calltype_unclear",   message: "Nu am inteles. Trebuie sa va trimitem Salvarea, Pompierii sau Politia?")
BotResponse.create(identifier: "calltype_request_3",      seq: 37,   lang: "ro", condition: "calltype_unclear",   message: "Nici acum nu am inteles. Va rugam scrieti: 'Salvare', 'Pompieri' sau 'Politie'!")
BotResponse.create(identifier: "health_service",          seq: 40,   lang: "ro", condition: "health_response",    message: "Tipul interventiei Salvare a fost identificat. Este persoana constienta?")
BotResponse.create(identifier: "health_service_breath",   seq: 41,   lang: "ro", condition: "awake_response",     message: "Persoana respira?")
BotResponse.create(identifier: "health_service_location", seq: 42,   lang: "ro", condition: "health_response",    message: "Unde se afla exact persoana?")
BotResponse.create(identifier: "health_service_bleed",    seq: 43,   lang: "ro", condition: "health_response",    message: "Persoana sangereaza puternic?")
BotResponse.create(identifier: "fire_service",            seq: 50,   lang: "ro", condition: "fire_response",      message: "Tipul interventiei Pompieri a fost identificat. Sunt toate persoanele in siguranta si in afara pericolului?")
BotResponse.create(identifier: "police_service",          seq: 60,   lang: "ro", condition: "police_response",    message: "Tipul interventiei Politie a fost identificat. Cate persoane sunt cu dvs.?")
BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "ro", condition: "",                   message: "Va multumim ca ati apelat Chatbot DEC112! Permiteti utilizarea datelor dvs. in scopuri de instruire la centrala de coordonare interventii? La linkul urmator gasiti o descriere exacta a modului de utilizare a datelor dvs.: http://dec112.eu/chatbot?language=ro")
BotResponse.create(identifier: "confirm",                 seq: 91,   lang: "ro", condition: "data_confirmed",     message: "Ati confirmat utilizarea datelor dvs. in scopuri de instruire la centrala de coordonare interventii. Permiteti sa va contactam pe email (%%EMAIL_ADDRESS%%) referitor la aceasta conversatie? Confirmati cu 'Da' sau introduceti adresa de email.")
BotResponse.create(identifier: "contact",                 seq: 92,   lang: "ro", condition: "data_not_confirmed", message: "Permiteti sa va contactam pe email (%%EMAIL_ADDRESS%%) referitor la aceasta conversatie? Confirmati cu "Da" sau introduceti adresa de email. Conversatia se va incheia automat in 2 minute. La reverdere!")
BotResponse.create(identifier: "contact_answer",          seq: 95,   lang: "ro", condition: "contact_confirmed",  message: "Va vom contacta in urmatoarele zile. Conversatia se va incheia automat in 10 secunde.")

# Mappings
BotResponse.create(identifier: "police",                  seq: 1000, lang: "ro", condition: "",                   message: "politie, crima, violenta, focuri de arma")
BotResponse.create(identifier: "health",                  seq: 1001, lang: "ro", condition: "",                   message: "salvare, ranit, hemoragie, fractura")
BotResponse.create(identifier: "fire",                    seq: 1002, lang: "ro", condition: "",                   message: "pompieri, incendiu,foc")
BotResponse.create(identifier: "true",                    seq: 1100, lang: "ro", condition: "",                   message: "da, confirm")
BotResponse.create(identifier: "false",                   seq: 1101, lang: "ro", condition: "",                   message: "nu, resping")

# URI Mapping
BotResponse.create(identifier: "police",                  seq: 2000, lang: "",   condition: "",                   message: "133, pinger")
BotResponse.create(identifier: "health",                  seq: 2001, lang: "",   condition: "",                   message: "144")
BotResponse.create(identifier: "fire",                    seq: 2002, lang: "",   condition: "",                   message: "122")

# Translations
BotResponse.create(identifier: "police",                  seq: 5000, lang: "ro", condition: "",                   message: "Politie")
BotResponse.create(identifier: "fire",                    seq: 5001, lang: "ro", condition: "",                   message: "Pompieri")
BotResponse.create(identifier: "health",                  seq: 5002, lang: "ro", condition: "",                   message: "Salvare")
