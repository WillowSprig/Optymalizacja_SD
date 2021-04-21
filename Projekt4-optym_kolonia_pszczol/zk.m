function [z_c,k_c] = zk (model, sigma, f)
ro=1.21;
c=343;
omega=2*f.*pi;
X=(ro.*f)/sigma;
if model == "DB"
z_c=ro*c*(1+0.0571*X.^(-0.754)-1i*0.087*X.^(-0.732));
k_c=omega.*(1+0.0978*X.^(-0.7)-1i*0.189*X.^(-0.595))/c;
elseif model == "Miki"
z_c=ro*c*(1+0.07*(f./sigma).^(-0.632)-1i*0.107*(f./sigma).^(-0.632));
k_c=omega.*(1+0.109*(f./sigma).^(-0.618)-1i*0.160*(f./sigma).^(-0.618))/c;
end 
end

