function Mgrid = shapeFourier(a0, a, b, gridSize)
   
    [X,Y] = meshgrid(-gridSize:gridSize,-gridSize:gridSize);
    [theta,r] = cart2pol(X,Y);
    R = radius(theta,a0,a,b);
    R = 0.99*R*gridSize/max(max(R));
    Mgrid = double(r<=R);
    
    [I,J] = find(Mgrid ~= 0);
    for i=1:length(I)
        Mgrid(I(i),J(i)) = i;
    end
            

 