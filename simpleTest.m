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

%testing - brown noise
cn = dsp.ColoredNoise('Color','brown','SamplesPerFrame',length(w));
y = cn();
Hy = fftshift(fft(y));
Hy = Hy;
HyPos = Hy(end/2:end);
fpos = linspace(0, Fs/2, length(y)/2 + 1);

%plot test signal time and freq
figure(1)
subplot(211)
plot(t,y), title('test signal')
xlabel('Seconds')
axis([0 0.001 -1 1])
subplot(212)
semilogx(fpos,db(abs(HyPos))), title('Freq Response')
axis tight, xlabel('Frequency')

white = wgn(length(y),1,0);
white = white/max(white);
Hw = fft(white);
%Hw = fftshift(Hw);
HwPos = Hw(end/2:end);
HwPosAvg = zeros(1,length(HwPos));
Avg = sum(HwPos)/length(HwPos);
HwPosAvg(1:end) = Avg;

figure(2)
subplot(211)
plot(t,white), title('Noise')
xlabel('Second')
axis tight
subplot(212)
HwMag = mag2db(abs(HwPos));
plot(fpos,HwMag);
semilogx(fpos,db(abs(HwPos))), title('Freq Response')
axis([20 20000 -10 40]), xlabel('Frequency')
hold on, plot(fpos,20*log10(HwPosAvg),'k','LineWidth',2)

%generate the octave bands
octaves = [31.25 62.5 125 250 500 1000 2000 4000 8000 16000];
fp = zeros(2,10);

for i = 1:2:20
    fp(i) = octaves(round(i/2))/sqrt(2);
    fp(i+1) = octaves(round(i/2))*sqrt(2);
    disp(i)
    disp(fp)
end

c = zeros(2,10);
index = zeros(2,10);

%can now find the average across the bands
for i = 1:20
    [c(i), index(i)] = min(abs(f-fp(i)));
end

avgHy = zeros(1,10); %1 row and 10 columns 
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

%SEE WILL'S BOOK PAGE 186/192 FOR BPF/BSF EQUATIONS AND METHOD
%SHOULD USE GENERIC BI-QUAD STRUCTURE

%b1 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(1),fp(2),Fs);

finalSig = whiteNoiseFix(y,diffGain,fp, Fs);

%y1 = filter(b1,1,white);
%Hb1 = design(b1,'butter');
%y1 = filter(Hb1,y);

figure(3)
subplot(211)
plot(t,20*log10(finalSig)), title('Resulting Signal')
xlabel('seconds'), ylabel('dB')
finalSpectrum = fft(finalSig,length(fpos));
subplot(212)
semilogx(fpos,db(abs(finalSpectrum))), title('Frequency Response')
xlabel('Frequency'), ylabel('dB'), axis([20 20000 -10 40])
hold on
semilogx(fpos,db(abs(HyPos)))
