%**************************************************************
% Sequential filters for 2D adaptive enhancement
% 
%    q1 = g1 * f1   0 deg
%    q2 = g1 * f2   45 deg
%    q3 = g3 * f2   90 deg
%    q4 = g4 * f4   135 deg
%
%  f and g are `more or less' 1-d filters, g are real while 
%  and f are complex
%
%   by matsa 9808
%**************************************************************
%clear all;

sz_F = [45,45];            

%u0 = pi/(2*sqrt(2));       % centerfreq of lognorm filter
u0 = 2*pi/3;
bw = 2;                    % bandwidth of lognorm filter

dir1   = [ 1  0 0 0];      % filter directions 
dir2   = [ 1  -1 0 0];      % the sign of the y-axis is altered
dir3   = [ 0  -1 0 0];      % using conv2 in matlab 
dir4   = [-1  -1 0 0];                                   

sz_f1 =  7;                % spatial size of filter
sz_f2 =  7;
sz_f5 =  9;
sz_g1 =  5;
sz_g2 =  5;
sz_g5 =  9;

itcnt = 9;                % number of iterations in seq opt


%**************************************************************
% ideal filters
%**************************************************************
Fi1 = quadlogcos(sz_F,u0,bw,dir1);
Fi2 = quadlogcos(sz_F,u0,bw,dir2);
fi1 = real(idft(getdata(Fi1)));
fi2 = real(idft(getdata(Fi2)));
Fi1 = putdata(Fi1,dft(fi1));
figure(1);wamesh(Fi1,-12)
Fi2 = putdata(Fi2,dft(fi2));
figure(2);wamesh(Fi2,-12)
%**************************************************************
% Frequency weight
%**************************************************************
rexp    =  -1;
cosexp  =  2;
epsilon = 0.2;
alpha = 0.2/sz_F(1);
Fw = powrbook(sz_F,1,rexp,cosexp,alpha,epsilon);

%**************************************************************
% spatial masks
%**************************************************************

msk_g1 = ones(wa([1,sz_g1],0));
msk_f1 = ones(wa([sz_f1,1],0));

msk_g2 = pole([sz_g2,sz_g2],dir4,sz_g2*1.42,0.5);
msk_f2 = pole([sz_f2,sz_f2],dir2,sz_f2*1.42,2.13);

%**************************************************************
% optimize
%**************************************************************
F1 = ones(wa(sz_F,1));
figure(1), rotate3d on
for k = 1:itcnt
    g1 = optimize(Fi1,Fw,msk_g1,F1);
    G1 = dft(g1,sz_F);
    
    f1 = optimize(Fi1,Fw,msk_f1,G1);
    F1 = dft(f1,sz_F);
    Q1 = F1.*G1;
    
    wamesh(Q1)
    [Edis, Sdis] = distortion(F1.*G1,Fi1,Fw);  %distortion
    s1 = sprintf(' Q1  wdist = %2.1f%%',Sdis{7});
    s2 = sprintf(' uwdist = %2.1f%% \n', Sdis{6});
    s=[s1,s2;];
    my_title(s),drawnow
end


F2 = ones(wa(sz_F,1));
figure(2), rotate3d on
for k = 1:itcnt
    g2 = optimize(Fi2,Fw,msk_g2,F2);
    G2 = dft(g2,sz_F);
    
    f2 = optimize(Fi2,Fw,msk_f2,G2);
    F2 = dft(f2,sz_F);

    Q2 = F2.*G2;

    wamesh(Q2)
    [Edis, Sdis] = distortion(F2.*G2,Fi2,Fw);  %distortion
    s1 = sprintf(' Q2  wdist = %2.1f%%',Sdis{7});
    s2 = sprintf(' uwdist = %2.1f%% \n', Sdis{6});
    s=[s1,s2;];
    my_title(s),drawnow
end

%**************************************************************
% normalize filters
% (keep the total norm, while making the individual
% filters more similar in size)
%**************************************************************
mg1 = max(abs(getdata(g1)));
mf1 = max(abs(getdata(f1)));
norm1 = sqrt(mg1*mf1);
g1 = g1.*(mf1/norm1);
f1 = f1.*(mg1/norm1);
G1 = dft(real(g1),sz_F);
F1 = dft(real(f1),sz_F);
Q1 = G1.*F1;


mg2 = max(max(abs(getdata(g2))));
mf2 = max(max(abs(getdata(f2))));
norm2 = sqrt(mg2*mf2);
g2 = g2.*(mf2/norm2);
f2 = f2.*(mg2/norm2);
G2 = dft(real(g2),sz_F);
F2 = dft(real(f2),sz_F);
Q2 = G2.*F2;


%**************************************************************
% compute q3 and q4 by transposing and mirroring
%**************************************************************

f3 = wa([1,sz_f1],0);
g3 = wa([sz_g1,1],0);

f4 = wa([sz_f2,sz_f2],0);
g4 = wa([sz_g2,sz_g2],0);

g3 = putdata(g3,rot90(getdata(g1),1));
f3 = putdata(f3,rot90(getdata(f1),1));

g4 = putdata(g4,rot90(getdata(g2),1));
f4 = putdata(f4,rot90(getdata(f2),1));

G3 = dft(real(g3),sz_F);
F3 = dft(real(f3),sz_F);
G4 = dft(real(g4),sz_F);
F4 = dft(real(f4),sz_F);

Q3 = F3.*G3;
Q4 = F4.*G4;
!rm logseqquad2D
diary logseqquad2D
format long

fprintf('g1 \n'), real(getdata(g1))
fprintf('real f1 \n'), real(getdata(f1))
fprintf('imag f1 \n'), imag(getdata(f1))

fprintf('g2 \n'), real(getdata(g2))
fprintf('real f2 \n'), real(getdata(f2))
fprintf('imag f2 \n'), imag(getdata(f2))

fprintf('g3 \n'), real(getdata(g3))
fprintf('real f3 \n'), real(getdata(f3))
fprintf('imag f3 \n'), imag(getdata(f3))

fprintf('g4 \n'), real(getdata(g4))
fprintf('real f4 \n'), real(getdata(f4))
fprintf('imag f4 \n'), imag(getdata(f4))

format short
diary off


tmp1 = getdata(Q1+Q2+Q3+Q4);
%tmp2 = flipud(fliplr(tmp1));
tmp = tmp1; %+tmp2;
figure(3), rotate3d on
wamesh(tmp,-12)

coeffs=sum(msk_g1) + sum(msk_f1);
coeffs=coeffs + sum(sum(msk_g2)) + sum(sum(msk_f2));
coeffs = coeffs*2;

s = sprintf('Frequency responce using  %d real coeffs',coeffs)
my_title(s)

figure(4), rotate3d on
%Optimize low-pass with respect to the optimized high-pass
idlp=idealLP(sz_F,u0,1);
Fi5=(1-tmp).*idlp;
%Optimize low-pass with respect to the ideal high-pass
%FiSum=Fi1+Fi2;
%Temp=getdata(FiSum);
%Temp=Temp+rot90(Temp);
%FiSum=putdata(FiSum,Temp);
%Fi5=(1-FiSum).*idlp;

wamesh(Fi5,-12)
my_title('Desired low-pass');

%**************************************************************
% spatial masks
%**************************************************************

msk_g5 = ones(wa([1,sz_g5],0));
msk_f5 = ones(wa([sz_f5,1],0));

%**************************************************************
% optimize
%**************************************************************
F5 = ones(wa(sz_F,1));
figure(5), rotate3d on
for k = 1:itcnt
    g5 = optimize(Fi5,Fw,msk_g5,F5);
    G5 = dft(g5,sz_F);
    
    f5 = optimize(Fi5,Fw,msk_f5,G5);
    F5 = dft(f5,sz_F);
    S5 = F5.*G5;
    
    wamesh(S5)
    [Edis, Sdis] = distortion(F5.*G5,Fi5,Fw);  %distortion
    s1 = sprintf(' Q1  wdist = %2.1f%%',Sdis{7});
    s2 = sprintf(' uwdist = %2.1f%% \n', Sdis{6});
    s=[s1,s2;];
    my_title(s),drawnow
end

figure(6), rotate3d on
tmp2=tmp+S5;
wamesh(tmp2,-12);
my_title('Sum of low-pass and high pass filters');

coeffs=coeffs + sum(sum(msk_g5)) + sum(sum(msk_f5));
specs = [u0 bw coeffs];