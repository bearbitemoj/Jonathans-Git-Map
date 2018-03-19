function cH = calcHarris(T,k)
cH = T(:,:,1).*T(:,:,3)-T(:,:,2).^2-k.*(T(:,:,1)+T(:,:,3)).^2;
end

