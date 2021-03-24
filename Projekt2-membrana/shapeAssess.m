function out = shapeAssess(r_vec)

    window = 10;
    ov = .5;
    step = window - floor(window*ov);
    
    kk = 1;
    for k = 1 : step : length(r_vec) - step - 1
        slice = r_vec(k : k + step - 1);
        par(kk) = max(slice) - min(slice);
        kk = kk + 1;
    end
    rest = step - (length(r_vec) - k);
    slice = [r_vec(k : end) r_vec(1 : rest)];
    par(kk) = max(slice) - min(slice);
    
    out = max(par);

end