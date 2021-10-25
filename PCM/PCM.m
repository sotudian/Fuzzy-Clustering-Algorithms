function [V, T, E] = PCM (X, c, w, options, init_V)

n = size(X, 1);
p = size(X, 2);
default_options = [2;	% weighting exponent (m)
		100;	% max. number of iteration
		1e-3;	% termination threshold
		1;      % info display during iteration 
        0];     % use provided init_V 
m = options(1);	        	% Weighting exponent
max_iter = options(2);		% Max. iteration
term_thr = options(3);		% Termination threshold
display = options(4);		% Display info or not
use_init_V = options(5);    % use provided init_V

if m <= 1,
    error('The weighting exponent should be greater than 1!');
end

E = zeros(max_iter, 1);	% Array for termination measure values

if use_init_V,
    V = init_V;
else
    V = Yf_PCMC1_InitV (c, p); % Initial cluster centers
end

%T = zeros (c, n);

% Main loop
for i = 1:max_iter,
	[V, T, E(i)] = PCM_One_Step (X, V, w, c, m);

    if display, 
		fprintf('Iteration count = %d, Termination measure value = %f\n', i, E(i));
	end

    % check termination condition
	if E(i) <= term_thr, break; end,
end

iter_n = i;	% Actual number of iterations 
E(iter_n+1:max_iter) = [];
