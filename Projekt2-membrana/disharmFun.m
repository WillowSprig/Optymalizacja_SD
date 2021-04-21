function [disharmonicity] = disharmFun(lambda)

freqRatio = (sqrt(lambda/lambda(1)));
%%
%nieharmoniczność
freqN = length(freqRatio);

disharmonicityM = zeros(freqN-1,4);
for i=1:4               % choosing base frequency
    rFreq = freqRatio(2:end)*i;
    disharmonicityM(:,i) = ((rFreq-round(rFreq)).^2);
end
[~,Nharm] = min(sum(disharmonicityM.*repmat((1./freqRatio(2:end)),1,4)));
% [Vharm,Nharm2] = min(sum(disharmonicityM.*repmat((1./freqRatio(2:end)),1,4)));
disharmonicity = disharmonicityM(:,Nharm)*400; 

%ampS=mean(sum(abs(disharmonicity',2)));

end

