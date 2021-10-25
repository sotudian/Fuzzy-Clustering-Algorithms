function [V, T, E] = PCM_One_Step(X, V, w, c, m)
n = size(X, 1);
p = size(X, 2);

% Fill the distance matrix
dist = Distance (V, X);

% Claculate new T
w = w(:);
tmp = (dist .^ 2) ./ ( w * ones (1, n));
tmp = tmp.^(1/(m-1));
T = 1 ./ (1 + tmp);

% For the situation of "singularity" (one of the data points is
% exactly the same as one of the cluster centers) T will be one.

V_old = V;

mf = T.^m; % MF matrix after exponential modification
V = mf*X./((ones(p, 1)*sum(mf'))'); % new center

E = norm (V - V_old, 1);
