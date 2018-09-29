/obj/effect/proc_holder/changeling/transform
	name = "Transform"
	desc = "We take on the appearance and voice of one we have absorbed."
	chemical_cost = 5
	dna_cost = 0
	req_dna = 1
	req_human = 1
	max_genetic_damage = 3

//Change our DNA to that of somebody we've absorbed.
/obj/effect/proc_holder/changeling/transform/sting_action(var/mob/living/carbon/human/user)
	var/datum/changeling/changeling = user.mind.changeling
	var/datum/dna/chosen_dna = changeling.select_dna("Select the target DNA: ", "Target DNA")

	if(!chosen_dna)
		return
	
	transform_dna(user,chosen_dna)

	user.changeling_update_languages(changeling.absorbed_languages)

	feedback_add_details("changeling_powers","TR")
	return 1

/datum/changeling/proc/select_dna(var/prompt, var/title)
	var/list/names = list()
	for(var/datum/dna/DNA in (absorbed_dna+protected_dna))
		names += "[DNA.real_name]"

	var/chosen_name = input(prompt, title, null) as null|anything in names
	if(!chosen_name)
		return
	var/datum/dna/chosen_dna = GetDNA(chosen_name)
	return chosen_dna