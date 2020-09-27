# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "es", condition: "",                   message: "Bienvenido. Por favor, indique su ubicación.")
BotResponse.create(identifier: "call_type",               seq: 12,   lang: "ds", condition: "skip",               message: "The mission type %%CALL_TYPE_SHORT%% was recognized.")
BotResponse.create(identifier: "address_check",           seq: 20,   lang: "es", condition: "address_invalid",    message: "Por favor, confirme de nuevo su dirección, porque las indicaciones geográficas no coinciden con los datos proporcionados.")
BotResponse.create(identifier: "calltype_check",          seq: 30,   lang: "es", condition: "calltype_missing",   message: "Indique su emergencia.")
BotResponse.create(identifier: "calltype_request_1",      seq: 35,   lang: "es", condition: "calltype_unclear",   message: "¿Debemos enviarle una ambulancia, los bomberos o la policía?")
BotResponse.create(identifier: "calltype_request_2",      seq: 36,   lang: "es", condition: "calltype_unclear",   message: "Sus datos no fueron reconocidos. ¿Debemos enviarle una ambulancia, los bomberos o la policia?")
BotResponse.create(identifier: "calltype_request_3",      seq: 37,   lang: "es", condition: "calltype_unclear",   message: "Nuevamente, sus datos no fueron reconocidos. ¡Por favor, ingrese 'ambulancia', 'bomberos' o 'policia'!")
BotResponse.create(identifier: "health_service",          seq: 40,   lang: "es", condition: "health_response",    message: "El tipo de emergencia 'ambulancia' fue reconocido. ¿La persona está plenamente consciente?")
BotResponse.create(identifier: "health_service_breath",   seq: 41,   lang: "es", condition: "awake_response",     message: "¿La persona está respirando?")
BotResponse.create(identifier: "health_service_location", seq: 42,   lang: "es", condition: "health_response",    message: "¿Dónde exactamente se encuentra el paciente?")
BotResponse.create(identifier: "health_service_bleed",    seq: 43,   lang: "es", condition: "health_response",    message: "¿La persona está sangrando mucho?")
BotResponse.create(identifier: "fire_service",            seq: 50,   lang: "es", condition: "fire_response",      message: "El tipo de emergencia 'bomberos' fue reconocido. ¿Todas las personas están a salvo y fuera de peligro?")
BotResponse.create(identifier: "police_service",          seq: 60,   lang: "es", condition: "police_response",    message: "El tipo de emergencia 'policía' fue reconocido. ¿Cuántas personas están con usted?")
BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "es", condition: "",                   message: "¡Muchas gracias por usar Chatbot de DEC112! ¿Podemos usar sus datos para fines de entrenamiento en la central? En este enlace encontrará una descripción detallada de cómo serán usados sus datos: http://dec112.eu/chatbot?language=es")
BotResponse.create(identifier: "confirm",                 seq: 91,   lang: "es", condition: "data_confirmed",     message: "Usted ha consentido que sus datos sean usados para fines de entrenamiento. ¿Podemos ponernos en contacto con usted para hablar sobre el chat? Consienta con 'sí' o indique su correo electrónico. El chat cerrará en dos minutos automáticamente. ¡Hasta pronto!")
BotResponse.create(identifier: "contact",                 seq: 92,   lang: "es", condition: "data_not_confirmed", message: "¿Podemos ponernos en contacto con usted por correo electrónico para hablar sobre el chat? Consienta con 'sí' o indique su correo electrónico. El chat cerrará en dos minutos automáticamente. ¡Hasta pronto!")
BotResponse.create(identifier: "contact_answer",          seq: 95,   lang: "es", condition: "contact_confirmed",  message: "Nos vamos a poner en contacto con usted en los siguientes días. El chat se cierra automáticamente en 10 segundos.")

# Mappings
BotResponse.create(identifier: "police",                  seq: 1000, lang: "es", condition: "",                   message: "policía, crimen, violencia, tiroteo")
BotResponse.create(identifier: "health",                  seq: 1001, lang: "es", condition: "",                   message: "ambulancia, herido, sangrando, fractura")
BotResponse.create(identifier: "fire",                    seq: 1002, lang: "es", condition: "",                   message: "bomberos, fuego, algo se quema")
BotResponse.create(identifier: "true",                    seq: 1100, lang: "es", condition: "",                   message: "sí, consentimiento")
BotResponse.create(identifier: "false",                   seq: 1101, lang: "es", condition: "",                   message: "no, rechazo")

# URI Mapping
BotResponse.create(identifier: "police",                  seq: 2000, lang: "",   condition: "",                   message: "133, pinger")
BotResponse.create(identifier: "health",                  seq: 2001, lang: "",   condition: "",                   message: "144")
BotResponse.create(identifier: "fire",                    seq: 2002, lang: "",   condition: "",                   message: "122")

# Translations
BotResponse.create(identifier: "police",                  seq: 5000, lang: "es", condition: "",                   message: "policía")
BotResponse.create(identifier: "fire",                    seq: 5001, lang: "es", condition: "",                   message: "bomberos")
BotResponse.create(identifier: "health",                  seq: 5002, lang: "es", condition: "",                   message: "ambulancia")
