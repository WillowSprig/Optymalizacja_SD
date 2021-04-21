dane = OUT.PSet(2,:);


gridSize = 100;
% h = 1/gridSize;

% R_0=0.5;
hf= floor(length(dane)/2) + 1;
R_0=dane(1);
a1=dane(2:hf);
b1=dane(hf+1:end);
% sin_max=10; % maksymalna liczba sinusów
% a_max=0.0;
% b_max=0.0;

harm_max=10;
[Mgrid, r_vec] = shapeFourier(R_0,a1,b1,gridSize);

figure(100)
hold on
plot(r_vec.rl+r_vec.a0)