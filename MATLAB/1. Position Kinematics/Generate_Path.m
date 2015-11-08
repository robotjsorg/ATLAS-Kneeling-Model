function( q_matrix ) = Generate_Path( q_state_start, q_state_final )
	% 1. Take a step
		% Should start at start state
		% First find where the right foot is now
		lfoot_to_rfoot = Forward_Transform( q_state_start, "lfoot", "lfoot" );


		q_matrix_rfoot_step = Path_1( q_state_start, )

	% 2. Lower the butt
		var q_state = [];
		lfoot_to_pelvis = Forward_Transform( q_state, "lfoot", "pelvis" );

		lfoot_from_pelvis = Inverse_Transform( q_state_final, "lfoot", "pelvis" );

		var CoM = [ x, y, z ];
		if check_CoM( CoM )

		end

	% 3. Bend the knees

	% 4. Balance on the knee
		% Should finish at final state


	% 5. Output the combined q_matrix
	return q_matrix = [ q_matrix_rfoot_step;
						q_matrix_pelvis_shift_weight;
						q_matrix_pelvis_lower_1;
						q_matrix_rknee_lower_1;
						q_matrix_pelvis_lower_2;
						q_matrix_rknee_lower_2;
						q_matrix_pelvis_lower_3;
						q_matrix_rknee_lower_3;
	];
end