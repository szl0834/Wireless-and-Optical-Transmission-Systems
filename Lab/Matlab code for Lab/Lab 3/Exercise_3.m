% input bertool in the commond line
%% constellation for 16-psk
M = 16;
x = [0:M-1];

EX3_plot1 = scatterplot(modulate(modem.pskmod(M), x)); 
grid minor
set(EX3_plot1, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot1, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot1,['EX3_plot1.pdf'],'pdf')
%% constellation for 32-QAM
M = 32;
x = [0:M-1];
y = modulate(modem.qammod(M), x);
scale = modnorm(y, 'peakpow', 1);
y = scale*y; % Scale the constellation.

EX3_plot2 = scatterplot(y); % Plot the scaled constellation.
% Include text annotations that number the points.
hold on; % Make sure the annotations go in the same figure.
for jj=1:length(y)
text(real(y(jj)), imag(y(jj)), [' ' num2str(jj-1)]);
end
hold off;
grid minor
set(EX3_plot2, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot2, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot2,['EX3_plot2.pdf'],'pdf')


%% gray-coded signal constellation
M = 8;
x = [0:M-1];
y = modulate(modem.qammod('M', M, 'SymbolOrder', 'Gray'), x);
% Plot the Gray-coded constellation.
EX3_plot3 = scatterplot(y, 1, 0, 'b.'); % Dots for points.
% Include text annotations that number the points in binary.
hold on; % Make sure the annotations go in the same figure.
annot = dec2bin([0:length(y)-1], log2(M));
text(real(y)+0.15, imag(y), annot);
axis([-4 4 -4 4]);
title('Constellation for Gray-Coded 8-QAM');
hold off;
grid minor
set(EX3_plot3, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot3, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot3,['EX3_plot3.pdf'],'pdf')
%% customised constellation 1 for QAM
% Describe constellation.

inphase = [0 -2 0 2 0 -3 -2 -1];
quadr = [3 2 2 2 1 0 0 0];
inphase = [inphase; -inphase];
inphase = inphase(:);
quadr = [quadr; -quadr];

quadr = quadr(:);
const = inphase + j*quadr;
% Plot constellation.
EX3_plot4 = scatterplot(const, 1, 0, 'o');
hold on;
axis([-4 4 -4 4]);
title('Customised Constellation for QAM');
hold off;
grid minor
set(EX3_plot4, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot4, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot4,['EX3_plot4.pdf'],'pdf')


%% customised constellation 2 for QAM
inphase = [0 1 2 sqrt(2)];
quadr = [1 0 0 sqrt(2)];
inphase = [inphase; -inphase];
inphase = inphase(:);
quadr = [quadr; -quadr];

quadr = quadr(:);
const = inphase + j*quadr;
% Plot constellation.
EX3_plot5 = scatterplot(const, 1, 0, 'o');
hold on;
axis([-4 4 -4 4]);
title('Customised Constellation for QAM');
hold off;
grid minor
set(EX3_plot5, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot5, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot5,['EX3_plot5.pdf'],'pdf')



%% Manual constellation. 
inphase = [1/2 -1/2 1 0 3/2 -3/2 1 -1]; 
quadr = [1 1 0 2 1 1 2 2];
inphase = [inphase; -inphase]; inphase = inphase(:); 
quadr = [quadr; -quadr]; quadr = quadr(:); 
const = inphase + 1i*quadr; 

% Plot constellation. 
EX3_plot6 = scatterplot(const, 1, 0, 'o'); 
hold on; 
axis([-3 3 -3 3]); 
title('Customised Constellation for QAM'); 
hold off; 

grid minor
set(EX3_plot6, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot6, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot6,['EX3_plot6.pdf'],'pdf')

%% old
%{
M = 16;
%x = [0:M-1]; 
x = (0:M-1); 
% scatterplot(modulate(modem.pskmod(M), x)); 

EX3_plot1 = scatterplot(pskmod(x,M)); 
grid minor
set(EX3_plot1, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot1, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot1,['EX3_plot1.pdf'],'pdf')

%%
M = 32; 
x = (0:M-1); 
y = qammod(x,M); 
scale = modnorm(y, 'peakpow', 1);
y = scale*y; % Scale the constellation
EX3_plot2 = scatterplot(y); % Plot the scaled constellation. 
% Include text annotations that number the points. 
hold on; % Make sure the annotations go in the same figure. 
for jj=1:length(y) 
    text(real(y(jj)), imag(y(jj)), [' ' num2str(jj-1)]); 
end   
hold off; 

grid minor
set(EX3_plot2, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot2, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot2,['EX3_plot2.pdf'],'pdf')



%%
M = 8; 
x = (0:M-1); 
%y = modulate(modem.qammod('M', M, 'SymbolOrder', 'Gray'), x); 
y = qammod(x, M, 'Gray'); 
%y = qammod(x,['M', M, 'SymbolOrder', 'Gray']); 
% Plot the Gray-coded constellation.
EX3_plot3 = scatterplot(y, 1, 0, 'b.'); % Dots for points. 
% Include text annotations that number the points in binary. 
hold on; % Make sure the annotations go in the same figure. 
annot = dec2bin([0:length(y)-1], log2(M)); 
text(real(y)+0.15, imag(y), annot);
axis([-4 4 -4 4]); 
title('Constellation for Gray-Coded 8-QAM'); 
hold off; 

grid minor
set(EX3_plot3, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot3, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot3,['EX3_plot3.pdf'],'pdf')

%% Describe constellation. 
inphase = [1/2 -1/2 1 0 3/2 -3/2 1 -1]; 
quadr = [1 1 0 2 1 1 2 2];
inphase = [inphase; -inphase]; inphase = inphase(:); 
quadr = [quadr; -quadr]; quadr = quadr(:); 
const = inphase + 1i*quadr; 

% Plot constellation. 
EX3_plot4 = scatterplot(const, 1, 0, 'o'); 
hold on; 
axis([-3 3 -3 3]); 
title('Customised Constellation for QAM'); 
hold off; 

grid minor
set(EX3_plot4, 'PaperPosition', [0.05 0.05 9 7]);
set(EX3_plot4, 'PaperSize', [9.05 7.05]);
saveas(EX3_plot4,['EX3_plot4.pdf'],'pdf')
%}