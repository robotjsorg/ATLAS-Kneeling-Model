function( q_matrix ) = Generate_Path( q_state_start, q_state_final )
	// 1. Take a step
	// Should start at start state
	lfoot_to_rfoot = Forward_Transform( q_state, "lfoot", "lfoot" );

	// 2. Lower the butt
	lfoot_to_pelvis = Forward_Transform( q_state, "lfoot", "pelvis" );
	lfoot_from_pelvis = Inverse_Transform( q_state, "lfoot", "pelvis" );

	// 3. Bend the knees

	// 4. Balance on the knee
	// Should finish at final state

	return q_matrix = [];
end