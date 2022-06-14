function f = ft(St,dt)

    f = length(St)*fftshift(ifft(ifftshift(St)))*dt/sqrt(2*pi);
    
return