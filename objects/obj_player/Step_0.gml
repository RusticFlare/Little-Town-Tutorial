/// @description Player movement

// Check keys for movement
moveRight = keyboard_check(vk_right);
moveLeft = keyboard_check(vk_left);
moveUp = keyboard_check(vk_up);
moveDown = keyboard_check(vk_down);

// Calculate movement
vx = ((moveRight - moveLeft) * walkSpeed);
vy = ((moveDown - moveUp) * walkSpeed);

// If idle
if (vx == 0 && vy == 0) {
	// Change idle sprite based on last direction
	switch dir {
		case 0: sprite_index = spr_player_idle_right; break;
		case 1: sprite_index = spr_player_idle_up; break;
		case 2: sprite_index = spr_player_idle_left; break;
		case 3: sprite_index = spr_player_idle_down; break;
	}
}

// If moving
if (vx != 0 || vy != 0) {
	if (!collision_point(x + vx, y, obj_par_environment, true, true)) {
		x += vx;
	}
	if (!collision_point(x, y + vy, obj_par_environment, true, true)) {
		y += vy;
	}
	// Change walking Sprite based on direction
	// Right
	if (vx > 0) {
		sprite_index = spr_player_walk_right;
		dir = 0;
	}
	// Left
	if (vx < 0) {
		sprite_index = spr_player_walk_left;
		dir = 2;
	}
	// Down
	if (vy > 0) {
		sprite_index = spr_player_walk_down;
		dir = 3;
	}
	// Up
	if (vy < 0) {
		sprite_index = spr_player_walk_up;
		dir = 1;
	}
	audio_listener_set_position(0, x, y, 0);
}

// Check for collisions with NPCs
nearbyNPC = collision_rectangle(x - lookRange, y - lookRange, x + lookRange, y + lookRange, obj_par_npc, false , true);
if (nearbyNPC) {
	if (!hasGreeted) {
		// Play greeting sound
		audio_play_sound(snd_greeting01, 1, false);
		hasGreeted = true;
	}
} else {
	// Reset greeting
	if (hasGreeted) {
		hasGreeted = false;
	}
}


// Depth sorting
depth = -y;
