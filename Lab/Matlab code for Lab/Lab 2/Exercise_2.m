%% create a QPSK modulator object. 
hMod = modem.pskmod('M', 8, 'PhaseOffset', pi/4);
%% create an upsampling filter
Rup = 16; % up sampling rate
hFilDesign = fdesign.pulseshaping(Rup, 'Raised Cosine','Nsym,Beta', Rup,0.50);
hFil = design(hFilDesign);
%% create the transimit signal
d = randi([0 hMod.M-1], 100, 1); % Generate data symbols
sym = modulate(hMod, d); % Generate modulated symbols
xmt = filter(hFil, upsample(sym, Rup));
%% create a scatter plot and set the samples per symbol to ghe upsampling rate
hScope = commscope.ScatterPlot
grid minor
hScope.SamplesPerSymbol = Rup;
%% set the constellation value
hScope.Constellation = hMod.Constellation;
%% groupdelay
groupDelay = (hFilDesign.NumberOfSymbols/2);
hScope.MeasurementDelay = groupDelay /hScope.SymbolRate;
update(hScope, xmt)
hScope.PlotSettings.Constellation = 'on';
%% 
hFil.Numerator = hFil.Numerator / max(hFil.Numerator);
%%
xmt = filter(hFil, upsample(sym, Rup));
%%
reset(hScope)
update(hScope, xmt)
hScope.PlotSettings.SignalTrajectory = 'on';
hScope.PlotSettings.SignalTrajectoryStyle = ':m';
autoscale(hScope)
rcv = awgn(xmt, 20, 'measured'); % Add AWGN
%%
reset(hScope) 
update(hScope, rcv)
hScope.PlotSettings.SignalTrajectory = 'off';
hScope.PlotSettings.Constellation = 'on';
hold off;




