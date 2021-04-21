function [v_out]=membrana_pure(dane)

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

[I,J] = find(Mgrid ~= 0);

A = delsq(Mgrid);   %/h^2;
[val,Mlambda] = eigs(A,harm_max,0);
% val = fliplr(val);

lambda = diag(Mlambda);
% lambda = 2*mu./(sqrt(1 + mu*h^2/2) + 1);
freqRatio = (sqrt(lambda/lambda(1)));
% freqRatio = lambda/lambda(1);
%%
%nieharmoniczność
freqN = length(freqRatio);

disharmonicityM = zeros(freqN-1,4);
for i=2:5               % choosing base frequency
    rFreq = freqRatio(2:end)*i;
    disharmonicityM(:,i-1) = ((rFreq-round(rFreq)).^2);
end
[~,Nharm] = min(sum(disharmonicityM.*repmat((1./freqRatio(2:end)),1,4)));
% [Vharm,Nharm2] = min(sum(disharmonicityM.*repmat((1./freqRatio(2:end)),1,4)));
disharmonicity = disharmonicityM(:,Nharm)*400; 

ampS=mean(sum(abs(val(:,2:10)).*disharmonicity',2));

v_out(1) = sum(ampS);

v_out(2) = shapeAssess(r_vec);

%%

dispOpt = 2; % 0 - 2D, 1 - 3D 2 - no figure
if dispOpt==2
    return
else
figure(1)
    subplot(3,3,1)
        spy(Mgrid)

x = -gridSize:gridSize;
y = -gridSize:gridSize;

colormap(jet)
for i=1:8
    u = NaN(2*gridSize+1);
    v = val(:,i);
    for k = 1:length(I)
      u(I(k),J(k)) = v(k);
    end
    subplot(3,3,i+1)
        surf(x,y,-u)
 title(num2str(freqRatio(i)),'FontSize',15)
        shading interp;
        switch dispOpt
            case 0
                view(0,270)
                axis equal
%                 colorbar
            case 1
                light;
                lighting phong;
                camlight('left');
                material metal
        end
end

% save membrana
end