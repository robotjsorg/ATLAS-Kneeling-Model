% JOE IS WORKING ON THIS.

function( q_matrix ) = Output_q_Matrix( q_state_start, q_state_final )
	% rfoot step
		% First find where the right foot is now
		lfoot_to_rfoot = Forward_Transform_From_LFoot( q_state_start, "rfoot" );
		display( lfoot_to_rfoot );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_rfoot_step = RFoot_Step( q_state_start, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rfoot_step );

	% pelvis shift weight
		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_pelvis_shift_weight = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_shift_weight );

	% pelvis lower 1

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_1 = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_1 );

	% rknee lower 1

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_rknee_lower_1 = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_lower_1 );

	% pelvis lower 2

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_2 = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_2 );

	% rknee lower 2

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_rknee_lower_2 = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_lower_2 );

	% pelvis lower 3

		% First find where the pelvis is now
		lfoot_to_pelvis = Forward_Transform_From_LFoot( q_state_current, "pelvis" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_pelvis_lower_3 = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_pelvis_lower_3 );

	% rknee make contact

		% First find where the right knee is now
		lfoot_to_rknee = Forward_Transform_From_LFoot( q_state_current, "rknee" );

		% And then try to get it to go where you want
		q_state_desired = [];
		
		% And then generate the corresponding q matrix
		q_matrix_rknee_make_contact = RFoot_Step( q_state_current, q_state_desired);

		% Update the current q state
		q_state_current = last( q_matrix_rknee_make_contact );

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