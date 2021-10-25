
% Shahab Sotudian - 94125091
clc;
clear all;
close all;

load Data_Cross.mat; Xin = Data_Cross;

% ----------------------------------------------------------------------
% Plot input feature vectors
figure; plot(Xin(:,1),Xin(:,2),'*')
title ('Input feature vectors');

% ----------------------------------------------------------------------
% Number of clusters => nC
nC = 4;

% ----------------------------------------------------------------------
% Options
m = 2.0;
term_thr = 0.001;

% ----------------------------------------------------------------------
% Find initial c-partition of X uing FCM clustering
% This is necessary for calculating cluster weights
init_V = Xin(1:nC, :);
[V,U] = fcm(Xin,nC);
% ----------------------------------------------------------------------
% Inits for PCM
init_V = V;
w = PCM_Weights (Xin, U, V, m, 1);

% ----------------------------------------------------------------------
% Display
w
V_FCM = V
U_FCM = U;

% ----------------------------------------------------------------------
% Call main function
[V,T,E] = PCM (Xin, nC, w, [m; 100; term_thr; 1; 1], init_V);

% ----------------------------------------------------------------------
% Display
V

% ----------------------------------------------------------------------
% Plot termination measure values
figure;
plot(E);
title ('Termination measure (PCM)');
xlabel ('Iteration num.');
ylabel ('Termination measure value');

% ----------------------------------------------------------------------
cMarker = ['+' 'o' '*' '.' 'x' 's' 'd' '^' 'v' '>' '<' 'p' 'h'];
cColor =  ['r' 'g' 'b' 'm' 'c' 'y' 'k' 'r' 'g' 'b' 'y' 'm' 'c'];

% ----------------------------------------------------------------------
% Plot clustered feature vectors
figure;
maxT = max(T);
for c = 1:nC
    index_c = find(T(c, :) == maxT);

    line(Xin(index_c, 1), Xin(index_c, 2), 'linestyle',...
        'none','marker', cMarker(c), 'color', cColor(c));
    
    hold on
    plot(V(c,1),V(c,2),['k' cMarker(c)],'markersize',11,'LineWidth',2)
end
title ('Clustered feature vectors (PCM)');

figure;
maxU = max(U_FCM);
for c = 1:nC
    index_c = find(U_FCM(c, :) == maxU);

    line(Xin(index_c, 1), Xin(index_c, 2), 'linestyle',...
        'none','marker', cMarker(c), 'color', cColor(c));
    
    hold on
    plot(V_FCM(c,1),V_FCM(c,2),['k' cMarker(c)],'markersize',11,'LineWidth',2)
end
title ('Clustered feature vectors (FCM)');

% ----------------------------------------------------------------------
% Plot membership functions
figure; hold on;
subplot (nC, 1, 1)
plot (T(1, :), cColor(1))
title ('Membership functions (PCM)');
for c = 2:nC
    subplot (nC, 1, c)
    plot (T(c, :), cColor(c))
end

figure; hold on;
subplot (nC, 1, 1)
plot (U_FCM(1, :), cColor(1))
title ('Membership functions (FCM)');
for c = 2:nC
    subplot (nC, 1, c)
    plot (U_FCM(c, :), cColor(c))
end

% ----------------------------------------------------------------------
% ----------------------------------------------------------------------
% ----------------------------------------------------------------------
