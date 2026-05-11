extends Control

@onready var resources_container = $VBoxContainer/ScrollContainer/contents

var swissResources = [
	"EMERGENCY & CRISIS SUPPORT",
	"Emergency Numbers: 144 — Medical Emergency",
	"112 — European Emergency Number",
	"147 — Youth Helpline (free, confidential)",
	"143 — Die Dargebotene Hand / La Main Tendue (24/7 emotional support)",
	"SOS Suicide (French-speaking regions): +41 22 327 55 55",
	"Psychiatric Emergency Services: Contact your canton's psychiatric services",
	"Inselspital Emergency Psychiatry (Bern): 031 632 24 24",
	"",
	"TALK TO SOMEONE — HELPLINES",
	"143 — The Helping Hand: www.143.ch",
	"147 — Youth Support Line: www.147.ch",
	"Swiss Red Cross Counseling: www.redcross.ch",
	"SOS-Chat: www.sos-chat.ch",
	"",
	"LEARN ABOUT MENTAL HEALTH",
	"Pro Mente Sana: www.promentesana.ch",
	"Health Promotion Switzerland: gesundheitsfoerderung.ch",
	"Swiss Red Cross Mental Health: redcross.ch/themen/gesundheit/psychische-gesundheit",
	"World Health Organization — Mental Health: who.int/health-topics/mental-health",
	"",
	"HOW TO FIND PROFESSIONAL HELP",
	"Find a Psychologist — FSP: www.psy.ch",
	"Find a Psychotherapist — ASP: www.psychotherapie.ch",
	"Canton Psychiatric Services: Search 'Psychiatrische Dienste + [your canton]'",
	"",
	"INSURANCE COVERAGE",
	"Does basic (LAMal/KVG) insurance cover therapy? Yes — if prescribed by GP and provided by recognized psychotherapist.",
	"To check your policy: visit insurer's benefits page or call the number on your insurance card.",
	"Ask: 'Does my policy cover psychotherapy under the new regulations?', 'How many sessions are included?', 'Do I need a GP prescription?'",
	"Popular insurers: CSS (www.css.ch), Helsana (www.helsana.ch), Sanitas (www.sanitas.com), Swica (www.swica.ch)",
	"",
	"COMMUNITY & SELF-HELP GROUPS",
	"Self-help Switzerland: www.selbsthilfeschweiz.ch",
	"Zürich Self-help Network: www.kontaktstelle.ch",
	"Swiss Addiction Support: www.suchtschweiz.ch",
	"",
	"YOU MATTER — This space is here for you — supportive, safe, and judgment-free."
]

var americanResources = [
	"EMERGENCY & CRISIS SUPPORT",
	"911 — Medical, fire, or police emergency",
	"988 — Suicide & Crisis Lifeline (phone, text, chat; 24/7)",
	"1-800-273-8255 — Veterans Crisis Line (press 1)",
	"Crisis Text Line: Text HOME to 741741",
	"Trevor Project (LGBTQ+ youth): Call 1-866-488-7386 or text START to 678678",
	"SAMHSA National Helpline: 1-800-662-HELP (4357) (substance use + mental health)",
	"",
	"TALK TO SOMEONE - HELPLINES",
	"988 Suicide & Crisis Lifeline: 988lifeline.org",
	"Crisis Text Line: crisistextline.org",
	"SAMHSA Treatment Helpline: samhsa.gov/find-help/national-helpline",
	"NAMI HelpLine (National Alliance on Mental Illness): nami.org/help",
	"Veterans Crisis Line: veteranscrisisline.net",
	"Trevor Project (LGBTQ+ Youth): thetrevorproject.org",
	"Trans Lifeline: translifeline.org",
	"",
	"LEARN ABOUT MENTAL HEALTH",
	"National Institute of Mental Health (NIMH): nimh.nih.gov",
	"NAMI Mental Health Education: nami.org",
	"MentalHealth.gov: mentalhealth.gov",
	"American Psychological Association (APA): apa.org/topics",
	"Mayo Clinic Mental Health Guides: mayoclinic.org",
	"",
	"HOW TO FIND PROFESSIONAL HELP",
	"Psychology Today Therapist Finder: psychologytoday.com/us/therapists",
	"SAMHSA Treatment Locator: findtreatment.gov",
	"American Psychological Association Psychologist Locator: locator.apa.org",
	"Your insurance provider's online directory (search 'Behavioral Health' or 'Mental Health Providers')",
	"Community mental health centers (county-level services)",
	"University counseling centers",
	"Local non-profits offering low-cost therapy",
	"",
	"INSURANCE COVERAGE",
	"Many U.S. plans include mental health coverage due to federal parity laws.",
	"To check your coverage: log into insurer's portal or call number on your card.",
	"Ask: 'What is my mental health coverage?', 'Do I need pre-authorization?', 'What providers are in-network?', 'Do I have teletherapy coverage?', 'What is my copay or deductible?'",
	"Major insurers: Blue Cross Blue Shield (bcbs.com), UnitedHealthcare (uhc.com), Aetna (aetna.com), Cigna (cigna.com), Kaiser Permanente (kp.org)",
	"If you don't have insurance: healthcare.gov for low-cost options; sliding-scale clinics via Open Path Collective (openpathcollective.org)",
	"",
	"US VETERANS & ACTIVE-DUTY SERVICE MEMBERS",
	"Veterans Crisis Line: 988, press 1",
	"VA Mental Health Services: mentalhealth.va.gov",
	"Vet Centers (free counseling for combat vets, family, survivors): vetcenter.va.gov",
	"Military OneSource (active duty & families): militaryonesource.mil",
	"",
	"COMMUNITY & SUPPORT GROUPS",
	"NAMI Support Groups: nami.org/supportgroups",
	"Alcoholics Anonymous (AA): aa.org",
	"Narcotics Anonymous (NA): na.org",
	"Depression & Bipolar Support Alliance (DBSA): dbsalliance.org",
	"Local community mental health centers (county websites list them)",
	"",
	"YOU MATTER — Whether you're learning, reaching out, or seeking professional help, this space was made for you — supportive, safe, and judgment-free."
]

var swissResources_it = [
	"EMERGENZA E SUPPORTO IN CRISI",
	"Numeri di emergenza: 144 — Emergenza medica",
	"112 — Numero europeo di emergenza",
	"147 — Linea giovani (gratuita, confidenziale)",
	"143 — Die Dargebotene Hand / La Main Tendue (supporto emotivo 24/7)",
	"SOS Suicidio (regioni francofone): +41 22 327 55 55",
	"Servizi psichiatrici di emergenza: Contatta i servizi psichiatrici del tuo cantone",
	"Psichiatria d'urgenza Inselspital (Berna): 031 632 24 24",
	"",
	"PARLA CON QUALCUNO — LINEE DI SUPPORTO",
	"143 — La Mano Tesa: www.143.ch",
	"147 — Linea di supporto giovani: www.147.ch",
	"Consulenza Croce Rossa Svizzera: www.redcross.ch",
	"SOS-Chat: www.sos-chat.ch",
	"",
	"IMPARA SULLA SALUTE MENTALE",
	"Pro Mente Sana: www.promentesana.ch",
	"Promozione Salute Svizzera: gesundheitsfoerderung.ch",
	"Croce Rossa Svizzera — Salute Mentale: redcross.ch/themen/gesundheit/psychische-gesundheit",
	"Organizzazione Mondiale della Sanità — Salute Mentale: who.int/health-topics/mental-health",
	"",
	"COME TROVARE AIUTO PROFESSIONALE",
	"Trova uno psicologo — FSP: www.psy.ch",
	"Trova uno psicoterapeuta — ASP: www.psychotherapie.ch",
	"Servizi psichiatrici cantonali: Cerca 'Psychiatrische Dienste + [tuo cantone]'",
	"",
	"COPERTURA ASSICURATIVA",
	"L'assicurazione base (LAMal/KVG) copre la terapia? Sì — se prescritta dal medico di base e fornita da uno psicoterapeuta riconosciuto.",
	"Per verificare la tua polizza: visita la pagina delle prestazioni dell'assicuratore o chiama il numero sul tuo tesserino.",
	"Chiedi: 'La mia polizza copre la psicoterapia secondo le nuove normative?', 'Quante sessioni sono incluse?', 'Ho bisogno di una prescrizione del medico di base?'",
	"Assicuratori principali: CSS (www.css.ch), Helsana (www.helsana.ch), Sanitas (www.sanitas.com), Swica (www.swica.ch)",
	"",
	"COMUNITÀ E GRUPPI DI AUTO-AIUTO",
	"Auto-aiuto Svizzera: www.selbsthilfeschweiz.ch",
	"Rete di auto-aiuto Zurigo: www.kontaktstelle.ch",
	"Supporto dipendenze Svizzera: www.suchtschweiz.ch",
	"",
	"SEI IMPORTANTE — Questo spazio è qui per te — solidale, sicuro e senza giudizi."
]

var americanResources_it = [
	"EMERGENZA E SUPPORTO IN CRISI",
	"911 — Emergenza medica, antincendio o polizia",
	"988 — Linea per suicidio e crisi (telefono, SMS, chat; 24/7)",
	"1-800-273-8255 — Linea di crisi per veterani (premi 1)",
	"Crisis Text Line: Scrivi HOME al 741741",
	"Trevor Project (giovani LGBTQ+): Chiama 1-866-488-7386 o scrivi START al 678678",
	"SAMHSA National Helpline: 1-800-662-HELP (4357) (dipendenze e salute mentale)",
	"",
	"PARLA CON QUALCUNO — LINEE DI SUPPORTO",
	"988 Linea per suicidio e crisi: 988lifeline.org",
	"Crisis Text Line: crisistextline.org",
	"SAMHSA Treatment Helpline: samhsa.gov/find-help/national-helpline",
	"NAMI HelpLine (Alleanza nazionale per la malattia mentale): nami.org/help",
	"Linea di crisi per veterani: veteranscrisisline.net",
	"Trevor Project (giovani LGBTQ+): thetrevorproject.org",
	"Trans Lifeline: translifeline.org",
	"",
	"IMPARA SULLA SALUTE MENTALE",
	"Istituto Nazionale della Salute Mentale (NIMH): nimh.nih.gov",
	"NAMI educazione sulla salute mentale: nami.org",
	"MentalHealth.gov: mentalhealth.gov",
	"American Psychological Association (APA): apa.org/topics",
	"Guide sulla salute mentale Mayo Clinic: mayoclinic.org",
	"",
	"COME TROVARE AIUTO PROFESSIONALE",
	"Psychology Today — Trova un terapeuta: psychologytoday.com/us/therapists",
	"SAMHSA Treatment Locator: findtreatment.gov",
	"APA Psychologist Locator: locator.apa.org",
	"Directory online del tuo assicuratore (cerca 'Behavioral Health' o 'Mental Health Providers')",
	"Centri di salute mentale comunitari (servizi a livello di contea)",
	"Centri di consulenza universitari",
	"Organizzazioni non profit locali che offrono terapia a basso costo",
	"",
	"COPERTURA ASSICURATIVA",
	"Molti piani americani includono la copertura per la salute mentale grazie alle leggi federali sulla parità.",
	"Per verificare la tua copertura: accedi al portale dell'assicuratore o chiama il numero sul tuo tesserino.",
	"Chiedi: 'Qual è la mia copertura per la salute mentale?', 'Ho bisogno di pre-autorizzazione?', 'Quali fornitori sono in-network?', 'Ho copertura per la teleterapia?', 'Qual è il mio copay o franchigia?'",
	"Assicuratori principali: Blue Cross Blue Shield (bcbs.com), UnitedHealthcare (uhc.com), Aetna (aetna.com), Cigna (cigna.com), Kaiser Permanente (kp.org)",
	"Se non hai assicurazione: healthcare.gov per opzioni a basso costo; cliniche a scala scorrevole tramite Open Path Collective (openpathcollective.org)",
	"",
	"VETERANI USA E MILITARI IN SERVIZIO ATTIVO",
	"Linea di crisi per veterani: 988, premi 1",
	"Servizi di salute mentale VA: mentalhealth.va.gov",
	"Vet Centers (consulenza gratuita per veterani di combattimento, famiglie, sopravvissuti): vetcenter.va.gov",
	"Military OneSource (servizio attivo e famiglie): militaryonesource.mil",
	"",
	"COMUNITÀ E GRUPPI DI SUPPORTO",
	"Gruppi di supporto NAMI: nami.org/supportgroups",
	"Alcolisti Anonimi (AA): aa.org",
	"Narcotici Anonimi (NA): na.org",
	"Depression & Bipolar Support Alliance (DBSA): dbsalliance.org",
	"Centri locali di salute mentale comunitari (i siti delle contee li elencano)",
	"",
	"SEI IMPORTANTE — Che tu stia imparando, chiedendo aiuto o cercando supporto professionale, questo spazio è stato creato per te — solidale, sicuro e senza giudizi."
]

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass

func _get_lang() -> String:
	return TranslationServer.get_locale().substr(0, 2)

func mostra_risorse(lista):
	for child in resources_container.get_children():
		child.queue_free()

	for testo in lista:
		if testo == "":
			var spacer = Label.new()
			spacer.text = ""
			spacer.custom_minimum_size.y = 10
			resources_container.add_child(spacer)
			continue

		if "www." in testo or "http://" in testo or "https://" in testo or ".org" in testo or ".gov" in testo or ".net" in testo:
			var btn = Button.new()
			btn.text = testo
			btn.flat = true
			btn.alignment = HORIZONTAL_ALIGNMENT_CENTER
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.add_theme_color_override("font_color", Color(0.2, 0.5, 0.8))

			var words = testo.split(" ")
			var url_index = -1
			for i in range(words.size()):
				var w = words[i]
				if "www." in w or "http" in w or ".org" in w or ".gov" in w or ".net" in w or ".ch" in w or ".com" in w:
					url_index = i
					break
			if url_index >= 0:
				var link = words[url_index]
				if not link.begins_with("http"):
					link = "https://" + link
				btn.pressed.connect(func(): OS.shell_open(link))
			else:
				btn.pressed.connect(func(): OS.shell_open("https://" + testo))

			resources_container.add_child(btn)
		else:
			var label = Label.new()
			label.text = testo
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			resources_container.add_child(label)

func _on_swiss_pressed() -> void:
	if _get_lang() == "it":
		mostra_risorse(swissResources_it)
	else:
		mostra_risorse(swissResources)

func _on_usa_pressed() -> void:
	if _get_lang() == "it":
		mostra_risorse(americanResources_it)
	else:
		mostra_risorse(americanResources)

func _on_back_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
