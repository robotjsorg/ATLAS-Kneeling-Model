q_state = [ q1 q2 q3 q4 q5 q6 q7 q8 q9 q10 q11 q12 q13 q14 q15 q16 q17 q18 q19 q20 q21 ];

num_row = 1000;
q_matrix = zeros( length( q_state ), num_row );

for i in num_row {
	q_matrix(i) = q_state;
}

// OUTPUT Q MATRIX
display(q_matrix);