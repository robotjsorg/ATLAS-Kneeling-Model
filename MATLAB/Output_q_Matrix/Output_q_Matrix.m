% JOE IS WORKING ON THIS.

function( q_matrix ) = Output_q_Matrix( q_state_start, q_state_final )
	% pelvis shift to lfoot
		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = []; % maybe move it to lfoot + [ -0.500, 0, 0]

		% And then generate the corresponding q matrix
		q_matrix_pelvis_shift_weight_left = Pelvis_Shift_Left( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_shift_weight_left );

	% rfoot step
		% First find where the right foot is now
		lfoot_to_rfoot = Forward_Transform_From_LFoot( q_state_start, "rfoot" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_rfoot_step = RFoot_Step( q_state_start, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rfoot_step );

	% pelvis shift to rfoot
		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_pelvis_shift_right = Pelvis_Shift_Right( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_shift_right );

	% pelvis lower 1

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_1 = Pelvis_Lower_1( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_1 );

	% rknee lower 1

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_rknee_lower_1 = RKnee_Lower_1( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_lower_1 );

	% pelvis lower 2

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_2 = Pelvis_Lower_2( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_2 );

	% rknee lower 2

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_rknee_lower_2 = RKnee_Lower_2( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_lower_2 );

	% pelvis lower 3

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];

		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_3 = Pelvis_Lower_3( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_3 );

	% rknee make contact

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then generate the corresponding q matrix
		q_matrix_rknee_make_contact = RKnee_Make_Contact( q_state_current, q_state_final);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_make_contact );

	% combined q_matrix
		return q_matrix = [ q_matrix_pelvis_shift_left;
							q_matrix_rfoot_step;
							q_matrix_pelvis_shift_right;
							q_matrix_pelvis_lower_1;
							q_matrix_rknee_lower_1;
							q_matrix_pelvis_lower_2;
							q_matrix_rknee_lower_2;
							q_matrix_pelvis_lower_3;
							q_matrix_rknee_make_contact
		];
end