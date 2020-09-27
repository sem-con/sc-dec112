# ruby encoding: utf-8
BotResponse.destroy_all

BotResponse.create(identifier: "welcome",                 seq: 10,   lang: "de", condition: "",                     message: "Corona-Chatprogramm. Welche Informationen benötigen sie?<br>" + 
                                                                                                                             "1: Ich bin krank - Verdacht Coronainfektion<br>" +
                                                                                                                             "2: Ich möchte über Coronavirus sprechen<br>" + 
                                                                                                                             "3: Ich brauche Informationen über Coronavirus<br>" + 
                                                                                                                             "4: Ausgangsbeschränkungen - was ist verboten, was ist erlaubt?<br>" + 
                                                                                                                             "9: Chat beenden")
BotResponse.create(identifier: "suspect",                 seq: 20,   lang: "de", condition: "input:1,verdacht, krank",
                                                                                                                    message: "Bei Symptomen einer Covid-19 Erkrankung melden sie sich bitte umgehend bei der Gehörlosenambulanz Wien. Sie erreichen diese über die Nummer <a href='sms:+436646212449' target='_blank'>0664 621 24 49</a> via SMS, WhatsApp, SignalApp oder Videotelefonie Mo, Di, Mi und Fr 8:00 - 13:00 Uhr, sowie Do 15:00-19:00 Uhr.<br>0: Menü, 9: Chat beenden")
BotResponse.create(identifier: "talk",                    seq: 30,   lang: "de", condition: "input:2,sprechen",     message: "Sie erreichen die Gehörlosenambulanz Wien über die Nummer <a href='sms:+436646212449' target='_blank'>0664 621 24 49</a> via SMS, WhatsApp, SignalApp oder Videotelefonie Mo, Di, Mi und Fr 8:00 - 13:00 Uhr, sowie Do 15:00-19:00 Uhr.<br>0: Menü, 9: Chat beenden")
BotResponse.create(identifier: "info",                    seq: 40,   lang: "de", condition: "input:3,info",         message: "Informationen in Gebärdensprache finden Sie hier:<br>" +
                                                                                                                             "<a href='https://coronavirus.wien.gv.at/site/informationen-zu-corona-fuer-gehoerlose/' target='_blank'>https://coronavirus.wien.gv.at/site/informationen-zu-corona-fuer-gehoerlose/</a><br>0: Menü, 9: Chat beenden")
BotResponse.create(identifier: "restrictions",            seq: 50,   lang: "de", condition: "input:4,beschränkung", message: "Nutzen sie den Chatbot der Stadt Wien unter:<br>" +
                                                                                                                             "<a href='https://coronavirus.wien.gv.at' target='_blank'>https://coronavirus.wien.gv.at</a><br>0: Menü, 9: Chat beenden")
BotResponse.create(identifier: "menu",                    seq: 60,   lang: "de", condition: "input:0,menü",         message: "Welche Informationen benötigen sie?<br>" + 
                                                                                                                             "1: Ich bin krank - Verdacht Coronainfektion<br>" +
                                                                                                                             "2: Ich möchte über Coronavirus sprechen<br>" + 
                                                                                                                             "3: Ich brauche Informationen über Coronavirus<br>" + 
                                                                                                                             "4: Ausgangsbeschränkungen - was ist verboten, was ist erlaubt?<br>" + 
                                                                                                                             "9: Chat beenden")

BotResponse.create(identifier: "fallback",                seq: 70,   lang: "de", condition: "invalid_input",        message: "Ihre Eingabe wurde nicht erkannt. Welche Informationen benötigen sie?<br>" + 
                                                                                                                             "1: Ich bin krank - Verdacht Coronainfektion<br>" +
                                                                                                                             "2: Ich möchte über Coronavirus sprechen<br>" + 
                                                                                                                             "3: Ich brauche Informationen über Coronavirus<br>" + 
                                                                                                                             "4: Ausgangsbeschränkungen - was ist verboten, was ist erlaubt?<br>" + 
                                                                                                                             "9: Chat beenden")

BotResponse.create(identifier: "chat_end",                seq: 90,   lang: "de", condition: "input:9,ende",         message: "Vielen Dank, dass sie den Chatbot von DEC112 verwendet haben! Dürfen wir ihre Eingaben für statistische Auswertungen verwenden (<a href='https://www.dec112.at/chatbot/' target='_blank'>weitere Infos</a>)?<br>0: Nein, 1: Ja")
BotResponse.create(identifier: "confirm",                 seq: 92,   lang: "de", condition: "input:1,ja",           message: "Sie haben der Verwendung ihrer Eingaben für statistische Zwecke zugestimmt. Auf Wiedersehen.")
BotResponse.create(identifier: "contact",                 seq: 94,   lang: "de", condition: "invalid_confirm",      message: "Ihre Eingaben werden nicht verwendet. Auf Wiedersehen.")

