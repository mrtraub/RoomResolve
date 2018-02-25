%trying a more basic signal

%basic info
Fs = 48000;
Ts = 1/Fs;
t = 0:Ts:1;

%create frequency array
fstep = Fs/length(t);
f = -Fs/2:fstep:Fs/2 - fstep;
w = 2*f/Fs;
wpos = w(end/2:end);

%carrier frequency 
fc = 1000;

%testing 
y = sin(2*pi*fc*t);
Hy = fftshift(fft(y));
HyPos = Hy(end/2:end);

%plot test signal time and freq
figure(1)
subplot(211)
plot(t,y)
xlabel('Seconds')
axis([0 0.001 -1 1])
subplot(212)
plot(wpos,db(abs(HyPos)))
axis tight

white = wgn(length(y),1,0);
white = white/max(white);
Hw = fftshift(fft(white));
HwPos = Hw(end/2:end);

figure(2)
subplot(211)
plot(t,white)
xlabel('Second')
axis tight
subplot(212)
plot(wpos,db(abs(HwPos)))
axis tight

%generate the octave bands
octaves = [31.25 62.5 125 250 500 1000 2000 4000 8000 16000];
fp = zeros(2,10);

for i = 1:2:20
    fp(i) = octaves(round(i/2))/sqrt(2);
    fp(i+1) = octaves(round(i/2))*sqrt(2);
    disp(i)
    disp(fp)
end

%normlize fp
fp = fp/Fs;

c = zeros(2,10);
index = zeros(2,10);

%can now find the average across the bands
for i = 1:20
    [c(i), index(i)] = min(abs(w-fp(i)));
end

avgHy = zeros(1,10);
avgHw = zeros(1,10);

for k = 1:10
   avgHy(k) = mean(db(abs(Hy(index(2*k-1):index(2*k)))));
   avgHw(k) = mean(db(abs(Hw(index(2*k-1):index(2*k)))));
end

%heck yea. I got the average of the white noise (Hw)
%and the average of the signal (Hy)
%now I can band pass filter at each band according to the difference 
%between the averages in dB

diffGain = zeros(1,10);

for j=1:10
    diffGain(j) = avgHw(j) - avgHy(j);
end

%try and get coefficients 

b1 = fir1(50,[fp(1) fp(2)], 'stop');
y1 = filter(b1,1,y);
% b2
% b3
% b4
% b5
% b6
% b7
% b8
% b9
% b10

figure(3)
plot(f,y1)



