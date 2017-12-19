% % Record your voice for 5 seconds.
% recObj = audiorecorder(16000, 16, 1);
% disp('Start speaking.')
% recordblocking(recObj, 3);
% disp('End of Recording.');
% 
% % Play back the recording.
% play(recObj);
% 
% % Store data in double-precision array.
% myRecording = getaudiodata(recObj);
% 
% % Plot the waveform.
% plot(myRecording);
% 
% audiowrite('DSPLab2.wav',myRecording,16000);

[y,Fs] = audioread('DSPLab2.wav');
fc = 3000; % Cut off frequency
y = [y; 0];


[b,a] = butter(6,fc/(Fs/2)); % Butterworth filter of order 6
y2 = filter(b,a,y); % Will be the filtered signal


ts=1/Fs;
T=3;
t=0:ts:T;
y3=sin(2*pi*3300*t);
y3=y3';

yscrambled = y2.*y3;

yclean = filter(b,a,yscrambled);

P2 = abs(y/48000);
P1 = P2(1:48000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(48000/2))/48000;



subplot(421)
plot(t,y);
subplot(422)
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')
subplot(423)
plot(t,yscrambled);

subplot(424)
P2 = abs(yscrambled/48000);
P1 = P2(1:48000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(48000/2))/48000;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')

subplot(425)
plot(t,yclean);

subplot(426)
P2 = abs(yclean/48000);
P1 = P2(1:48000/2+1);
P1(2:end-1) = 2*P1(2:end-1);
f = Fs*(0:(48000/2))/48000;
plot(f,P1) 
title('Single-Sided Amplitude Spectrum of X(t)')
xlabel('f (Hz)')
ylabel('|P1(f)|')


subplot(427)
error = abs(yclean-y);
powery = (norm(y)^2)/length(y);
powere = (norm(error)^2)/length(error);
snr = abs(powery./powere);
s = 10*log10(snr);
plot(10.*log10(abs(y./error)));
