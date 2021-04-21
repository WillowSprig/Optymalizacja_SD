function [r, r_out] = radius(theta,a0,a,b)
    
    r = a0*ones(size(theta));   % a0
    r = r+a(1)*sin(theta);      % a1
    %        obliczenia sprawdzające, żeby narysować
%     sobie obwód membrany
    thetal=0:pi/180:2*pi; 
    r_out.a0=a0;              %promie� podstawowy
    rl=a0+a(1)*sin(thetal);


    for i = 2:length(a)         % a2-an, b2-bn
        r = r + a(i)*sin(i*theta + b(i)*2*pi); 
        rl = rl + a(i)*sin(i*thetal + b(i)*2*pi); 
%             r = r + a(i)*sin((i)*theta) + b(i-1)*cos((i)*theta); 
    end
%  polar(thetal,rl)
    r_out.rl=rl-min(rl)+a0;
    r=r-min(min(r))+a0;  %żeby funkcja dawała zawsze dodatnie wartości