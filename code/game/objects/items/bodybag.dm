
/obj/item/bodybag
	name = "body bag"
	desc = "A folded bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "bodybag_folded"
	w_class = WEIGHT_CLASS_SMALL
	drop_sound = 'sound/items/handling/cloth_drop.ogg'
	pickup_sound = 'sound/items/handling/cloth_pickup.ogg'
	///Stored path we use for spawning a new body bag entity when unfolded.
	var/unfoldedbag_path = /obj/structure/closet/body_bag

/obj/item/bodybag/attack_self(mob/user)
	if(user.is_holding(src))
		deploy_bodybag(user, get_turf(user))
	else
		deploy_bodybag(user, get_turf(src))

/obj/item/bodybag/interact_with_atom(atom/interacting_with, mob/living/user, flags)
	if(isopenturf(interacting_with))
		deploy_bodybag(user, interacting_with)
		return ITEM_INTERACT_SUCCESS
	return NONE

/obj/item/bodybag/attempt_pickup(mob/user)
	// can't pick ourselves up if we are inside of the bodybag, else very weird things may happen
	if(contains(user))
		return TRUE
	return ..()

/**
 * Creates a new body bag item when unfolded, at the provided location, replacing the body bag item.
 * * mob/user: User opening the body bag.
 * * atom/location: the place/entity/mob where the body bag is being deployed from.
 */
/obj/item/bodybag/proc/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/item_bag = new unfoldedbag_path(location)
	item_bag.open(user)
	item_bag.add_fingerprint(user)
	item_bag.foldedbag_instance = src
	moveToNullspace()
	return item_bag

/obj/item/bodybag/suicide_act(mob/living/user)
	if(isopenturf(user.loc))
		user.visible_message(span_suicide("[user] is crawling into [src]! It looks like [user.p_theyre()] trying to commit suicide!"))
		var/obj/structure/closet/body_bag/R = new unfoldedbag_path(user.loc)
		R.add_fingerprint(user)
		qdel(src)
		user.forceMove(R)
		playsound(src, 'sound/items/zip.ogg', 15, TRUE, -3)
		return OXYLOSS

// Bluespace bodybag

/obj/item/bodybag/bluespace
	name = "bluespace body bag"
	desc = "A folded bluespace body bag designed for the storage and transportation of cadavers."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "bluebodybag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/bluespace
	w_class = WEIGHT_CLASS_SMALL
	item_flags = NO_MAT_REDEMPTION
	/// Tracks the air from the bodybag
	var/datum/gas_mixture/internal_air

/obj/item/bodybag/bluespace/return_air()
	return internal_air || ..()

/obj/item/bodybag/bluespace/return_analyzable_air()
	return internal_air || ..()

/obj/item/bodybag/bluespace/assume_air(datum/gas_mixture/giver)
	return internal_air ? internal_air.merge(giver) : ..()

/obj/item/bodybag/bluespace/remove_air(amount)
	return internal_air ? internal_air.remove(amount) : ..()

/obj/item/bodybag/bluespace/examine(mob/user)
	. = ..()
	if(length(contents))
		. += span_notice("You can make out the shape of [length(contents)] object\s through the fabric.")

/obj/item/bodybag/bluespace/atom_deconstruct(disassembled)
	for(var/atom/movable/inside in src)
		inside.forceMove(get_turf(src))
		if(isliving(inside))
			to_chat(inside, span_notice("You suddenly feel the space around you torn apart! You're free!"))

/obj/item/bodybag/bluespace/Destroy()
	for(var/mob/living/leftover in src)
		stack_trace("Bluespace Bodybag qdeleted before dumping mobs!")
		leftover.forceMove(get_turf(src))
	QDEL_NULL(internal_air)
	return ..()

/obj/item/bodybag/bluespace/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/item_bag = new unfoldedbag_path(location)
	if(internal_air)
		// get rid of any air it might have collected in init
		if(item_bag.internal_air)
			location.assume_air(item_bag.internal_air)
		// replace it with our air
		item_bag.internal_air = internal_air
		internal_air = null

	for(var/atom/movable/inside in src)
		inside.forceMove(item_bag)
		if(isliving(inside))
			to_chat(inside, span_notice("You suddenly feel air around you! You're free!"))
	item_bag.open(user)
	item_bag.add_fingerprint(user)
	item_bag.foldedbag_instance = src
	moveToNullspace()
	return item_bag

/obj/item/bodybag/bluespace/container_resist_act(mob/living/user)
	if(user.incapacitated())
		to_chat(user, span_warning("You can't get out while you're restrained like this!"))
		return
	user.changeNext_move(CLICK_CD_BREAKOUT)
	user.last_special = world.time + CLICK_CD_BREAKOUT
	to_chat(user, span_notice("You claw at the fabric of [src], trying to tear it open..."))
	to_chat(loc, span_warning("Someone starts trying to break free of [src]!"))
	if(!do_after(user, 12 SECONDS, src, timed_action_flags = (IGNORE_TARGET_LOC_CHANGE|IGNORE_HELD_ITEM)))
		return
	// you are still in the bag? time to go unless you KO'd, honey!
	// if they escape during this time and you rebag them the timer is still clocking down and does NOT reset so they can very easily get out.
	if(user.incapacitated())
		to_chat(loc, span_warning("The pressure subsides. It seems that they've stopped resisting..."))
		return
	loc.visible_message(span_warning("[user] suddenly appears in front of [loc]!"), span_userdanger("[user] breaks free of [src]!"))
	qdel(src)

/obj/item/bodybag/environmental
	name = "environmental protection bag"
	desc = "A folded, reinforced bag designed to protect against exoplanetary environmental storms."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "envirobag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental
	w_class = WEIGHT_CLASS_NORMAL //It's reinforced and insulated, like a beefed-up sleeping bag, so it has a higher bulkiness than regular bodybag
	resistance_flags = ACID_PROOF | FIRE_PROOF | FREEZE_PROOF

/obj/item/bodybag/environmental/nanotrasen
	name = "elite environmental protection bag"
	desc = "A folded, heavily reinforced, and insulated bag, capable of fully isolating its contents from external factors."
	icon_state = "ntenvirobag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/nanotrasen
	resistance_flags = ACID_PROOF | FIRE_PROOF | FREEZE_PROOF | LAVA_PROOF

/obj/item/bodybag/environmental/prisoner
	name = "prisoner transport bag"
	desc = "Intended for transport of prisoners through hazardous environments, this folded environmental protection bag comes with straps to keep an occupant secure."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "prisonerenvirobag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/prisoner

/obj/item/bodybag/environmental/prisoner/pressurized
	name = "pressurized prisoner transport bag"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/prisoner

/obj/item/bodybag/environmental/prisoner/syndicate
	name = "syndicate prisoner transport bag"
	desc = "An alteration of Nanotrasen's environmental protection bag which has been used in several high-profile kidnappings. Designed to keep a victim unconscious, alive, and secured until they are transported to a required location."
	icon = 'icons/obj/medical/bodybag.dmi'
	icon_state = "syndieenvirobag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/prisoner/syndicate
	resistance_flags = ACID_PROOF | FIRE_PROOF | FREEZE_PROOF | LAVA_PROOF

// NON-MODULE CHANGE / addition
/obj/item/bodybag/stasis
	name = /obj/structure/closet/body_bag/environmental/stasis::name
	desc = /obj/structure/closet/body_bag/environmental/stasis::desc
	max_integrity = /obj/structure/closet/body_bag/environmental/stasis::max_integrity
	icon = 'maplestation_modules/icons/obj/bodybag.dmi'
	icon_state = "stasis_bag_folded"
	unfoldedbag_path = /obj/structure/closet/body_bag/environmental/stasis

/obj/item/bodybag/stasis/deploy_bodybag(mob/user, atom/location)
	var/obj/structure/closet/body_bag/environmental/stasis/bag = ..()
	bag.last_filter_update = -1
	bag.update_integrity(get_integrity())
	return bag
