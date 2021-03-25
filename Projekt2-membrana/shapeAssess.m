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
    
      out=var(r_vec.rl);
end