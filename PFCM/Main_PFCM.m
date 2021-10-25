% Shahabeddin Sotudian
clc;
clear all;
close all;

% ----------------------------------------------------------------------

load Data_Cross.mat;
Xin = Data_Cross;

% ----------------------------------------------------------------------
% Plot input feature vectors
figure; plot(Xin(:,1),Xin(:,2),'.')
title ('Input feature vectors');

% ----------------------------------------------------------------------
% Number of clusters => nC
nC =4 ;

% ----------------------------------------------------------------------
% Options
m = 2.0;
eta = 4.0;
Cf=0.5;
Cp=0.5;
% Initial weights for PFCM
[V,U] = fcm(Xin,nC);
K=1;
w = FindWeights (Xin, U, V, m, K);
% ----------------------------------------------------------------------
% PFCM
[V,U,T,E,Objective_Function_PFCM,Objective_Function_FCM,Objective_Function_PCM] =PFCM_clustering (Xin,nC,m,eta,Cf,Cp,w);

V_FPCM = V
U_FPCM = U;
T_FPCM = T;

% ----------------------------------------------------------------------

% ----------------------------------------------------------------------
% Plot termination measure values
figure;
plot(E);
title ('Termination measure (PFCM)');
xlabel ('Iteration num.');
ylabel ('Termination measure value');

% ----------------------------------------------------------------------
cMarker = ['+' 'o' '*' '.' 'x' 's' 'd' '^' 'v' '>' '<' 'p' 'h'];
cColor =  ['r' 'g' 'b' 'm' 'c' 'y' 'k' 'r' 'g' 'b' 'm' 'c'  'y'    ];

% ----------------------------------------------------------------------
% Plot clustered feature vectors
figure;
maxU = max(U);
for c = 1:nC
    index_c = find(U(c, :) == maxU);

    line(Xin(index_c, 1), Xin(index_c, 2), 'linestyle',...
        'none','marker', cMarker(4), 'color', cColor(c));
    
    hold on
    plot(V(c,1),V(c,2),['k' cMarker(c)],'markersize',9,'LineWidth',2)
end
title ('Clustered feature vectors (PFCM)');


% ----------------------------------------------------------------------
% Plot membership functions
figure; hold on;
subplot (nC, 1, 1)
plot (U(1, :), cColor(1))
title ('Membership functions (PFCM)');
for c = 2:nC
    subplot (nC, 1, c)
    plot (U(c, :), cColor(c))
end

