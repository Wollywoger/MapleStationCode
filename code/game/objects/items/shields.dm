#define BATON_BASH_COOLDOWN (3 SECONDS)

/obj/item/shield
	name = "shield"
	icon = 'icons/obj/weapons/shields.dmi'
	lefthand_file = 'icons/mob/inhands/equipment/shields_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/shields_righthand.dmi'
	block_chance = 50
	slot_flags = ITEM_SLOT_BACK
	force = 10
	throwforce = 5
	throw_speed = 2
	throw_range = 3
	w_class = WEIGHT_CLASS_BULKY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	armor_type = /datum/armor/item_shield
	block_sound = 'sound/weapons/block_shield.ogg'
	drop_sound = 'maplestation_modules/sound/items/drop/metal_drop.ogg'
	pickup_sound = 'maplestation_modules/sound/items/pickup/metalweapon.ogg'

	/// makes beam projectiles pass through the shield
	var/transparent = FALSE
	/// if the shield will break by sustaining damage
	var/breakable_by_damage = TRUE
	/// what the shield leaves behind when it breaks
	var/shield_break_leftover = /obj/item/stack/sheet/mineral/wood
	/// sound the shield makes when it breaks
	var/shield_break_sound = 'sound/effects/bang.ogg'
	/// baton bash cooldown
	COOLDOWN_DECLARE(baton_bash)

/datum/armor/item_shield
	melee = 50
	bullet = 50
	laser = 50
	bomb = 30
	fire = 80
	acid = 70

/obj/item/shield/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/disarm_attack)

/obj/item/shield/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(transparent && (hitby.pass_flags & PASSGLASS))
		return FALSE
	if(attack_type == THROWN_PROJECTILE_ATTACK)
		final_block_chance += 30
	if(attack_type == LEAP_ATTACK)
		final_block_chance = 100
	. = ..()
	if(.)
		on_shield_block(owner, hitby, attack_text, damage, attack_type, damage_type)

/obj/item/shield/examine(mob/user)
	. = ..()
	var/healthpercent = round((atom_integrity/max_integrity) * 100, 1)
	switch(healthpercent)
		if(50 to 99)
			. += span_info("It looks slightly damaged.")
		if(25 to 50)
			. += span_info("It appears heavily damaged.")
		if(0 to 25)
			. += span_warning("It's falling apart!")

/obj/item/shield/proc/on_shield_block(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!breakable_by_damage || (damage_type != BRUTE && damage_type != BURN))
		return TRUE
	var/penetration = 0
	var/armor_flag = MELEE
	if(isprojectile(hitby))
		var/obj/projectile/bang_bang = hitby
		armor_flag = bang_bang.armor_flag
		penetration = bang_bang.armour_penetration
	else if(isitem(hitby))
		var/obj/item/weapon = hitby
		penetration = weapon.armour_penetration
	else if(isanimal(hitby))
		var/mob/living/simple_animal/critter = hitby
		penetration = critter.armour_penetration
	else if(isbasicmob(hitby))
		var/mob/living/basic/critter = hitby
		penetration = critter.armour_penetration
	take_damage(damage, damage_type, armor_flag, armour_penetration = penetration)

/obj/item/shield/atom_destruction(damage_flag)
	playsound(src, shield_break_sound, 50)
	new shield_break_leftover(get_turf(src))
	if(isliving(loc))
		loc.balloon_alert(loc, "shield broken!")
	return ..()

/obj/item/shield/buckler
	name = "wooden buckler"
	desc = "A medieval wooden buckler."
	icon_state = "buckler"
	inhand_icon_state = "buckler"
	custom_materials = list(/datum/material/wood = SHEET_MATERIAL_AMOUNT * 10)
	resistance_flags = FLAMMABLE
	block_chance = 30
	max_integrity = 55
	w_class = WEIGHT_CLASS_NORMAL
	drop_sound = 'maplestation_modules/sound/items/drop/wooden.ogg'
	pickup_sound = 'maplestation_modules/sound/items/pickup/wooden.ogg'

/obj/item/shield/roman
	name = "\improper Roman shield"
	desc = "Bears an inscription on the inside: <i>\"Romanes venio domus\"</i>."
	icon_state = "roman_shield"
	inhand_icon_state = "roman_shield"
	custom_materials = list(/datum/material/iron = SHEET_MATERIAL_AMOUNT * 4.25)
	max_integrity = 65
	shield_break_sound = 'sound/effects/grillehit.ogg'
	shield_break_leftover = /obj/item/stack/sheet/iron

/obj/item/shield/roman/fake
	desc = "Bears an inscription on the inside: <i>\"Romanes venio domus\"</i>. It appears to be a bit flimsy."
	block_chance = 0
	armor_type = /datum/armor/none
	max_integrity = 30

/datum/armor/item_shield/riot
	melee = 80
	bullet = 20
	laser = 20

/obj/item/shield/riot
	name = "riot shield"
	desc = "A shield adept at blocking blunt objects from connecting with the torso of the shield wielder, less so bullets and laser beams."
	icon_state = "riot"
	inhand_icon_state = "riot"
	custom_materials = list(/datum/material/glass= SHEET_MATERIAL_AMOUNT * 3.75, /datum/material/iron= HALF_SHEET_MATERIAL_AMOUNT)
	transparent = TRUE
	max_integrity = 75
	shield_break_sound = 'sound/effects/glassbr3.ogg'
	shield_break_leftover = /obj/item/shard
	armor_type = /datum/armor/item_shield/riot

/obj/item/shield/riot/Initialize(mapload)
	. = ..()
	var/static/list/slapcraft_recipe_list = list(/datum/crafting_recipe/strobeshield)

	AddComponent(
		/datum/component/slapcrafting,\
		slapcraft_recipes = slapcraft_recipe_list,\
	)

/obj/item/shield/riot/attackby(obj/item/attackby_item, mob/user, params)
	if(istype(attackby_item, /obj/item/melee/baton))
		if(!COOLDOWN_FINISHED(src, baton_bash))
			return
		user.visible_message(span_warning("[user] bashes [src] with [attackby_item]!"))
		playsound(user.loc, 'sound/effects/shieldbash.ogg', 50, TRUE)
		COOLDOWN_START(src, baton_bash, BATON_BASH_COOLDOWN)
		return
	if(istype(attackby_item, /obj/item/stack/sheet/mineral/titanium))
		if (atom_integrity >= max_integrity)
			to_chat(user, span_warning("[src] is already in perfect condition."))
			return
		var/obj/item/stack/sheet/mineral/titanium/titanium_sheet = attackby_item
		titanium_sheet.use(1)
		atom_integrity = max_integrity
		to_chat(user, span_notice("You repair [src] with [titanium_sheet]."))
		return
	return ..()

/obj/item/shield/riot/flash
	name = "strobe shield"
	desc = "A shield with a built in, high intensity light capable of blinding and disorienting suspects. Takes regular handheld flashes as bulbs."
	icon_state = "flashshield"
	inhand_icon_state = "flashshield"
	var/obj/item/assembly/flash/handheld/embedded_flash = /obj/item/assembly/flash/handheld

/obj/item/shield/riot/flash/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/update_icon_updates_onmob)
	if(embedded_flash)
		embedded_flash = new(src)
		embedded_flash.set_light_flags(embedded_flash.light_flags | LIGHT_ATTACHED)
		update_appearance(UPDATE_ICON)

/obj/item/shield/riot/flash/Entered(atom/movable/arrived, atom/old_loc, list/atom/old_locs)
	if(istype(arrived, /obj/item/assembly/flash/handheld))
		embedded_flash = arrived
		embedded_flash.set_light_flags(embedded_flash.light_flags | LIGHT_ATTACHED)
		update_appearance(UPDATE_ICON)
	return ..()

/obj/item/shield/riot/flash/Exited(atom/movable/gone, direction)
	if(gone == embedded_flash)
		embedded_flash.set_light_flags(embedded_flash.light_flags & ~LIGHT_ATTACHED)
		embedded_flash = null
		update_appearance(UPDATE_ICON)
	return ..()

/obj/item/shield/riot/flash/vv_edit_var(vname, vval)
	. = ..()
	if(vname == NAMEOF(src, embedded_flash))
		update_appearance(UPDATE_ICON)

/obj/item/shield/riot/flash/Destroy(force)
	QDEL_NULL(embedded_flash)
	return ..()

/obj/item/shield/riot/flash/attack(mob/living/target_mob, mob/living/user)
	if(user.combat_mode)
		return ..()
	flash_away(user, target_mob)

/obj/item/shield/riot/flash/attack_self(mob/living/carbon/user)
	flash_away(user)

/obj/item/shield/riot/flash/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK)
	. = ..()
	if(.)
		flash_away(owner)

///Handles calls for the actual flash object + plays the flashing animations.
/obj/item/shield/riot/flash/proc/flash_away(mob/owner, mob/target, animation_only)
	if(QDELETED(embedded_flash) || (embedded_flash.burnt_out && !animation_only))
		return
	var/flick = animation_only ? TRUE : (target ? embedded_flash.attack(target, owner) : embedded_flash.AOE_flash(user = owner))
	if(!flick && !embedded_flash.burnt_out)
		return
	flick("flashshield_flash", src)
	inhand_icon_state = "flashshield_flash"
	owner?.update_held_items()
	addtimer(CALLBACK(src, TYPE_PROC_REF(/atom, update_appearance)), 0.5 SECONDS, (TIMER_UNIQUE|TIMER_OVERRIDE)) //.5 second delay so the inhands sprite finishes its anim since inhands don't support flick().

/obj/item/shield/riot/flash/attackby(obj/item/attackby_item, mob/user)
	if(istype(attackby_item, /obj/item/assembly/flash/handheld))
		var/obj/item/assembly/flash/handheld/flash = attackby_item
		if(flash.burnt_out)
			to_chat(user, span_warning("No sense replacing it with a broken bulb!"))
			return
		else
			to_chat(user, span_notice("You begin to replace the bulb..."))
			if(do_after(user, 2 SECONDS, target = user))
				if(QDELETED(flash) || flash.burnt_out)
					return
				playsound(src, 'sound/items/deconstruct.ogg', 50, TRUE)
				qdel(embedded_flash)
				flash.forceMove(src)
				return
	return ..()

/obj/item/shield/riot/flash/emp_act(severity)
	. = ..()
	if(QDELETED(embedded_flash) || embedded_flash.burnt_out)
		return
	embedded_flash.emp_act(severity)
	if(embedded_flash.burnt_out) // a little hacky but no good way to check otherwise.
		flash_away((ismob(loc) ? loc : null), animation_only = TRUE)

/obj/item/shield/riot/flash/update_icon_state()
	if(QDELETED(embedded_flash) || embedded_flash.burnt_out)
		icon_state = "riot"
		inhand_icon_state = "riot"
	else
		icon_state = "flashshield"
		inhand_icon_state = "flashshield"
	return ..()

/obj/item/shield/riot/flash/examine(mob/user)
	. = ..()
	if (embedded_flash?.burnt_out)
		. += span_info("The mounted bulb has burnt out. You can try replacing it with a new <b>flash</b>.")

/obj/item/shield/energy
	name = "combat energy shield"
	desc = "A hardlight shield capable of reflecting blocked energy projectiles, as well las providing well-rounded defense from most all other attacks."
	icon_state = "eshield"
	inhand_icon_state = "eshield"
	w_class = WEIGHT_CLASS_TINY
	attack_verb_continuous = list("shoves", "bashes")
	attack_verb_simple = list("shove", "bash")
	throw_range = 5
	force = 3
	throwforce = 3
	throw_speed = 3
	breakable_by_damage = FALSE
	block_sound = 'sound/weapons/block_blade.ogg'
	/// Force of the shield when active.
	var/active_force = 10
	/// Throwforce of the shield when active.
	var/active_throwforce = 8
	/// Throwspeed of ethe shield when active.
	var/active_throw_speed = 2
	/// Whether clumsy people can transform this without side effects.
	var/can_clumsy_use = FALSE
	/// The chance for projectiles to be reflected by the shield
	var/reflection_probability = 50

/obj/item/shield/energy/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = active_force, \
		throwforce_on = active_throwforce, \
		throw_speed_on = active_throw_speed, \
		hitsound_on = hitsound, \
		clumsy_check = !can_clumsy_use, \
	)
	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	RegisterSignal(src, COMSIG_ITEM_CAN_DISARM_ATTACK, PROC_REF(can_disarm_attack))

/obj/item/shield/energy/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return FALSE

	if(attack_type == PROJECTILE_ATTACK)
		var/obj/projectile/our_projectile = hitby

		if(our_projectile.reflectable) //We handle this via IsReflect() instead.
			final_block_chance = 0

	return ..()

/obj/item/shield/energy/IsReflect()
	return HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE) && prob(reflection_probability)

/*
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 */
/obj/item/shield/energy/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	if(user)
		balloon_alert(user, active ? "activated" : "deactivated")
	playsound(src, active ? 'sound/weapons/saberon.ogg' : 'sound/weapons/saberoff.ogg', 35, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/shield/energy/proc/can_disarm_attack(datum/source, mob/living/victim, mob/living/user, send_message = TRUE)
	SIGNAL_HANDLER
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		if(send_message)
			balloon_alert(user, "activate it first!")
		return COMPONENT_BLOCK_ITEM_DISARM_ATTACK

/obj/item/shield/energy/advanced
	name = "advanced combat energy shield"
	desc = "A hardlight shield capable of reflecting all energy projectiles, as well las providing well-rounded defense from most all other attacks. \
		Often employed by Nanotrasen deathsquads."
	icon_state = "advanced_eshield"
	inhand_icon_state = "advanced_eshield"
	reflection_probability = 100 //Guaranteed reflection

/obj/item/shield/riot/tele
	name = "telescopic shield"
	desc = "An advanced riot shield made of lightweight materials that collapses for easy storage."
	icon_state = "teleriot"
	inhand_icon_state = "teleriot"
	worn_icon_state = "teleriot"
	custom_materials = list(/datum/material/iron = HALF_SHEET_MATERIAL_AMOUNT * 3.6, /datum/material/glass = HALF_SHEET_MATERIAL_AMOUNT * 3.6, /datum/material/silver = SMALL_MATERIAL_AMOUNT * 2.7, /datum/material/titanium = SMALL_MATERIAL_AMOUNT * 1.8)
	slot_flags = null
	force = 3
	throwforce = 3
	throw_speed = 3
	throw_range = 4
	w_class = WEIGHT_CLASS_NORMAL

/obj/item/shield/riot/tele/Initialize(mapload)
	. = ..()
	AddComponent( \
		/datum/component/transforming, \
		force_on = 8, \
		throwforce_on = 5, \
		throw_speed_on = 2, \
		hitsound_on = hitsound, \
		w_class_on = WEIGHT_CLASS_BULKY, \
		attack_verb_continuous_on = list("smacks", "strikes", "cracks", "beats"), \
		attack_verb_simple_on = list("smack", "strike", "crack", "beat"), \
	)

	RegisterSignal(src, COMSIG_TRANSFORMING_ON_TRANSFORM, PROC_REF(on_transform))
	RegisterSignal(src, COMSIG_ITEM_CAN_DISARM_ATTACK, PROC_REF(can_disarm_attack))

/obj/item/shield/riot/tele/hit_reaction(mob/living/carbon/human/owner, atom/movable/hitby, attack_text = "the attack", final_block_chance = 0, damage = 0, attack_type = MELEE_ATTACK, damage_type = BRUTE)
	if(HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		return ..()
	return FALSE

/**
 * Signal proc for [COMSIG_TRANSFORMING_ON_TRANSFORM].
 *
 * Allows it to be placed on back slot when active.
 */
/obj/item/shield/riot/tele/proc/on_transform(obj/item/source, mob/user, active)
	SIGNAL_HANDLER

	slot_flags = active ? ITEM_SLOT_BACK : null
	if(user)
		balloon_alert(user, active ? "extended" : "collapsed")
	playsound(src, 'sound/weapons/batonextend.ogg', 50, TRUE)
	return COMPONENT_NO_DEFAULT_MESSAGE

/obj/item/shield/riot/tele/proc/can_disarm_attack(datum/source, mob/living/victim, mob/living/user, send_message = TRUE)
	SIGNAL_HANDLER
	if(!HAS_TRAIT(src, TRAIT_TRANSFORM_ACTIVE))
		if(send_message)
			balloon_alert(user, "extend it first!")
		return COMPONENT_BLOCK_ITEM_DISARM_ATTACK

#undef BATON_BASH_COOLDOWN
