% ROHIT IS WORKING ON THIS.

function [ forward_transform_matrix ] = Forward_Transform( q_state, base_frame, end_effector )

	Tz = [];

	Rz = [];

	Rx = [];

	Tx = [];

	T = Tz * Rz * Rx * Tx;

	forward_transform_matrix = T;
	return forward_transform_matrix;
end