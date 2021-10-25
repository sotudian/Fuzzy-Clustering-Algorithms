function w = PCM_Weights (X, U, V, m, K)
c = size (V, 1);
w = zeros (c, 1);

mf = U.^m;

% Calculate weights, Eq. 2.9a, P-19, [BezKKP99]
dist = Distance (V, X);
dist = dist .^ 2;
w = sum((mf.*dist)') ./ sum(mf');
