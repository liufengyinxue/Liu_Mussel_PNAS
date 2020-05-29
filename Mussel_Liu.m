%%%
%This is the code of mussel pattern 
%Liu, Q.-X. et al. Phase separation explains a new class of self-organized 
%spatial patterns in ecological systems. PNAS 110, 11905¨C11910 (2013).
% 
%Copyright: Zhenpeng Ge, Quanxing Liu, East China Normal University.
%Licence: MIT Licence
%%%

N = 128 ;
T = 50000 ;
Beta = 1.8 ;
D = 1 ;
K = 0.1 ;
dx = 1 ;
dy = 1 ;
dt = 0.1 ;
kernel = [0,1/(dx*dx),0;1/(dy*dy),-2/(dx*dx)-2/(dy*dy),1/(dy*dy);0,1/(dx*dx),0] ;

P = 1 + 0.1*(rand(N)*2 - 1) ;
% P = rand(N) ;
%Pmass = zeros(T,1) ;
%varP = zeros(T,1) ;


F1 = figure('position',[200 20 600 600]) ;
%F2 = figure('position',[300 50 800 800]) ;
Videoname1 = ['Mussel_Liu' num2str(N) 'T' num2str(T)] ;
V1 = VideoWriter(Videoname1,'MPEG-4') ; %'MPEG-4'
V1.FrameRate = 30 ;
V1.Quality = 100 ;
open(V1) ;
for i = 1:T
    if rem(i,1000) == 0
        figure(F1) ;
    %   subplot(1,2,1) ;
    %   imshow(Stone < mean(Stone(:))) ;
        imagesc(P) ;
        axis equal
        xlim([0 N]) ;
        ylim([0 N]) ;
        colorbar
        Frame = getframe(gcf) ;
        writeVideo(V1,Frame) ;
    end
    Ptemp = 3/5*P.^5 - 5/4*Beta*P.^4 + (4 + 2*Beta^2)/3*P.^3 - 3/2*Beta*P.^2 + P - K*imfilter(P,kernel,'circular') ;
    Pi = D*imfilter(Ptemp,kernel,'circular') ;
    P = P + dt*Pi ;
 %   Pmass(i) = sum(P(:)) ;
 %   varP(i) = var(P(:)) ;
end
close(V1);