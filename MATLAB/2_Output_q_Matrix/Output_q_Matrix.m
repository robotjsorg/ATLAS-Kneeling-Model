% JOE IS WORKING ON THIS.

function( q_matrix ) = Output_q_Matrix( q_state_start, q_state_final )
	% rfoot step
		% First find where the right foot is now
		lfoot_to_rfoot = Forward_Transform( q_state_start, "lfoot", "lfoot" );
		
		q_matrix_rfoot_step = [];

		% Check that the CoM is above the left foot the whole time
		for q_state in q_matrix_rfoot_step.rows() {
			if Is_Above_LFoot( Center_of_Mass( q_state ) )

			end
		}

	% pelvis shift weight
		lfoot_to_pelvis = Forward_Transform( q_state, "lfoot", "pelvis" );
		lfoot_from_pelvis = Inverse_Transform( q_state_final, "lfoot", "pelvis" );

		q_matrix_pelvis_shift_weight = [];

	% pelvis lower 1

		q_matrix_pelvis_lower_1 = [];

	% rknee lower 1

		q_matrix_rknee_lower_1 = [];

	% pelvis lower 2

		q_matrix_pelvis_lower_2 = [];

	% rknee lower 2

		q_matrix_rknee_lower_2 = [];

	% pelvis lower 3

		q_matrix_pelvis_lower_3 = [];

	% rknee make contact

		q_matrix_rknee_make_contact = [];

	% combined q_matrix
		return q_matrix = [ q_matrix_rfoot_step;
							q_matrix_pelvis_shift_weight;
							q_matrix_pelvis_lower_1;
							q_matrix_rknee_lower_1;
							q_matrix_pelvis_lower_2;
							q_matrix_rknee_lower_2;
							q_matrix_pelvis_lower_3;
							q_matrix_rknee_make_contact
		];
end