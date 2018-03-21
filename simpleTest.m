%% Simple Aglorithmic Test
clear, clc

% basic info
Fs = 48000;
Ts = 1/Fs;
t = 0:Ts:1;

% create frequency array
fstep = Fs/length(t);
f = -Fs/2:fstep:Fs/2 - fstep;
w = 2*f/Fs;
wpos = w(end/2:end);
% carrier frequency 
fc = 1000;


% TEST INPUT SIGNAL ? brown noise
cn = dsp.ColoredNoise('Color','brown','SamplesPerFrame',length(w));
y = cn();
Hy = fftshift(fft(y));

HyPos = Hy(end/2:end);
fpos = linspace(0, Fs/2, length(y)/2 + 1);

    % time & freq plots
    figure(1)
    subplot(2,3,1)
    plot(t,y), title('Test Signal ? Brown Noise')
    xlabel('Time (seconds)')
    axis([0 0.001 -1 1])
    subplot(2,3,4)
    semilogx(fpos,db(abs(HyPos))), title('Response')
    axis tight, xlabel('Frequency (Hz)')

    
    
% TEST REFERENCE SIGNAL ? WGN (flat spectrum) 
    
white = wgn(length(y),1,0);
white = white/max(white);
Hw = fft(white);
%Hw = fftshift(Hw);
HwPos = Hw(end/2:end);
HwPosAvg = zeros(1,length(HwPos));
Avg = sum(HwPos)/length(HwPos);
HwPosAvg(1:end) = Avg;

    % time & freq plots
    subplot(2,3,2)
    plot(t,white), title('Reference Signal ? WGN')
    xlabel('Time (seconds)')
    axis tight
    subplot(2,3,5)
    HwMag_dB = mag2db(abs(HwPos));
    plot(fpos,HwMag_dB);
    semilogx(fpos,db(abs(HwPos))), title('Response')
    axis([20 20000 -20 50]), xlabel('Frequency (Hz)')
    
    
    
    
% ALGORITHM (calculate voltage multiplier from dB difference from ref.)


% generate the octave bands
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

% can now find the average across the bands
for i = 1:20
    [c(i), index(i)] = min(abs(f-fp(i)));
end

avgHy_dB = zeros(1,10); % 1 row and 10 columns 
avgHw_dB = zeros(1,10);

for k = 1:10
   avgHy_dB(k) = mean(db(abs(Hy(index(2*k-1):index(2*k)))));
   avgHw_dB(k) = mean(db(abs(Hw(index(2*k-1):index(2*k)))));
end

%heck yea. I got the average of the white noise (Hw)
%and the average of the signal (Hy)
%now I can band pass filter at each band according to the difference 
%between the averages in dB

diffGain_dB = zeros(1,10);

for j=1:10
    diffGain_dB(j) = avgHw_dB(j) - avgHy_dB(j);
end

%try and get coefficients 

%SEE WILL'S BOOK PAGE 186/192 FOR BPF/BSF EQUATIONS AND METHOD
%SHOULD USE GENERIC BI-QUAD STRUCTURE

%b1 = fdesign.bandpass('N,F3dB1,F3dB2', 20,fp(1),fp(2),Fs);

% do the adjustment

finalSig = whiteNoiseFix(y,diffGain_dB,fp, Fs);

%y1 = filter(b1,1,white);
%Hb1 = design(b1,'butter');
%y1 = filter(Hb1,y);

% plot final results
subplot(2,3,3)
plot(t,db(finalSig)), title('Adjusted Signal')
xlabel('Time (seconds)'), ylabel('dB')
finalSpectrum = fft(finalSig,length(fpos));
subplot(2,3,6)
semilogx(fpos,db(abs(finalSpectrum))), title('Response')
xlabel('Frequency'), ylabel('dB'), axis('tight') %axis([20 20000 -20 50])
hold on, semilogx(fpos,db(abs(HwPos)),'LineWidth',0.2), hold on
semilogx(fpos,db(abs(HyPos)),'LineWidth',0.2)
legend('Adjusted Spect.','Ref. Spect.','Input Spect.')

