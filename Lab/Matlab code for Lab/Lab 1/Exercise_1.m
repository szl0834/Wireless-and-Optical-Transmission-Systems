% Typing by Changgnag Zheng

%% Define parameters

M = 16;
k = log2(M);
n = 3e4;
nsamp = 1;
iMin = 0;
iMax = 1;
x = randi([iMin,iMax],1,n);
EX1_plot1 = figure;
stem(x(1:40),'.','filled','LineWidth',1.5,'color',[1,0.5,0.5]);
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value')
grid minor
set(EX1_plot1, 'PaperPosition', [0.05 0.05 9 7]);
set(EX1_plot1, 'PaperSize', [9.05 7.05]);
saveas(EX1_plot1,['EX1_plot1.pdf'],'pdf')


%% Bit to symbol mapping
xsym = bi2de(reshape(x,k,length(x)/k).','left-msb');
EX1_plot2 = figure;
stem(xsym(1:10),'.','filled','LineWidth',1.5,'color',[1,0.5,0.5]);
title('Rabdom Symbols');
xlabel('Symbol Index');
ylabel('Integer Value')
grid minor
set(EX1_plot2, 'PaperPosition', [0.05 0.05 9 7]);
set(EX1_plot2, 'PaperSize', [9.05 7.05]);
saveas(EX1_plot2,['EX1_plot2.pdf'],'pdf')

%% Modulation 
y = modulate(modem.qammod(M), xsym); % using the 16 QAM

%% Transmissitted Signal
ytx = y;

%% Channel
% Send signal over an AEGN channel
EbNo = 9;
snr = EbNo + 10*log10(k) - 10*log10(nsamp);
ynoisy = awgn(ytx,snr,'measured');

%% Receive channel
yrx = ynoisy;

%% Scatter plot

h = scatterplot(yrx(1:nsamp*5e3),nsamp, 0,'.');
hold on;
EX1_plot3 = scatterplot(ytx(1:5e3),1,0,'+',h);
title('Received Signal')
legend('Received Signal','Signal Constellation');
axis([-5 5 -5 5]);
grid minor
set(EX1_plot3, 'PaperPosition', [0.05 0.05 9 7]);
set(EX1_plot3, 'PaperSize', [9.05 7.05]);
saveas(EX1_plot3,['EX1_plot3.pdf'],'pdf')
hold off;

%% Demodulation
% Demodulate signal using 16-QAM.
zsym = demodulate(modem.qamdemod(M), yrx);


%% Symbol-to-Bit Mapping
% Undo the bit-to-symbol mapping performed earlier.
z = de2bi(zsym, 'left-msb'); % Convert integers to bits.
% Convert z from a matrix to a vector.
z = reshape(z.', prod(size(z)),1);

%% BER Computation
% Compare x and z to obtain the number of errors and the bit
% error rate.
[number_of_errors, bit_error_rate] = biterr(x, z.')
