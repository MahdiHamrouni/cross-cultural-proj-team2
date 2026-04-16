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



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
	
func mostra_risorse(lista):
	# Pulisce il contenitore
	for child in resources_container.get_children():
		child.queue_free()
	
	# Aggiunge ogni risorsa come label (o bottone)
	for testo in lista:
		if testo == "":
			var spacer = Label.new()
			spacer.text = ""
			spacer.custom_minimum_size.y = 10
			resources_container.add_child(spacer)
			continue
		
		# Controlla se la stringa contiene un link (www. o http)
		if "www." in testo or "http://" in testo or "https://" in testo or ".org" in testo or ".gov" in testo or ".net" in testo:
			# Crea un pulsante cliccabile
			var btn = Button.new()
			btn.text = testo
			btn.flat = true
			btn.alignment = HORIZONTAL_ALIGNMENT_CENTER
			btn.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			btn.add_theme_color_override("font_color", Color(0.2, 0.5, 0.8))
			
			# Estrae l'URL dalla stringa
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
			# Testo normale: usa Label
			var label = Label.new()
			label.text = testo
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			label.autowrap_mode = TextServer.AUTOWRAP_WORD
			label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
			resources_container.add_child(label)


func _on_swiss_pressed() -> void:
	mostra_risorse(swissResources)


func _on_usa_pressed() -> void:
	mostra_risorse(americanResources) 


func _on_back_home_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
