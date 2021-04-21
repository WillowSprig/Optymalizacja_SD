function out = shapeAssess(r_vec)
%% wersja pierwszza 
%     window = 10;
%     ov = .5;
%     step = window - floor(window*ov);
%     
%     kk = 1;
%     for k = 1 : step : length(r_vec.rl) - step - 1
%         slice = r_vec.rl(k : k + step - 1);
%         par(kk) = max(slice) - min(slice);
%         kk = kk + 1;
%     end
%     rest = step - (length(r_vec.rl) - k);
%     slice = [r_vec.rl(k : end) r_vec.rl(1 : rest)];
%     par(kk) = max(slice) - min(slice);
%     
%     out = max(par);
%     
    
%% wersja druga - wariancja 
%     
%       out=var(r_vec.rl);

%% wersja trzecia - druga pochodna 
% 
% out = gradient(gradient(r_vec.rl));
% out = min(abs(out));

%% wersja czwarta - miesjca zerowe i powierzchnia

% nz = Nzerocross(gradient(r_vec.rl));
% s = trapz(r_vec.rl+1);
% out = s * nz;

%% wersja pi¹ta
a = max(r_vec.rl)-min(r_vec.rl);
s = trapz(r_vec.rl+r_vec.a0);
out =100* a^2 / s;




end