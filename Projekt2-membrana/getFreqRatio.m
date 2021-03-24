clc; clear; close all;

gridSize = 10;
% h = 1/gridSize;


% Mgrid = numgrid('D',2*gridSize);
Mgrid = shapeFourier(5*rand+0.1,rand(10,1)-0.5,rand(10,1)-0.5,gridSize);
% Mgrid = shapePolygon(rand(15,1)-0.5,rand(15,1)-0.5,gridSize, 0);
% Mgrid = shapeFourier(1,[0;0;0.3],zeros(3,1),gridSize);

[I,J] = find(Mgrid ~= 0);

A = delsq(Mgrid);   %/h^2;
[val,Mlambda] = eigs(A,12,0);
val = fliplr(val);

lambda = diag(Mlambda);
% lambda = 2*mu./(sqrt(1 + mu*h^2/2) + 1);
freqRatio = flipud(sqrt(lambda/lambda(end)));


%%

dispOpt = 0; % 0 - 2D, 1 - 3D

figure(1)
    subplot(2,3,1)
        spy(Mgrid)

x = -gridSize:gridSize;
y = -gridSize:gridSize;

colormap(jet)
for i=1:5
    u = NaN(2*gridSize+1);
    v = val(:,i);
    for k = 1:length(I)
      u(I(k),J(k)) = v(k);
    end
    subplot(2,3,i+1)
        surf(x,y,-u)
        title(num2str(freqRatio(i)))
        shading interp;
        switch dispOpt
            case 0
                view(0,270)
                axis equal
            case 1
                light;
                lighting phong;
                camlight('left');
                material metal
        end
end

save membrana
