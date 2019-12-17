
hMod = modem.pskmod('M', 4, 'PhaseOffset', pi/4);
Rup = 16; % up sampling rate 
hFilDesign = fdesign.pulseshaping(Rup, 'Raised Cosine','Nsym,Beta', Rup,0.50);
hFil = design(hFilDesign); 
d = randi([0 hMod.M-1], 100, 1); % Generate data symbols 
sym = modulate(hMod, d); % Generate modulated symbols 
xmt = filter(hFil, upsample(sym, Rup)); 
hScope = comm.ConstellationDiagram
hScope.SamplesPerSymbol = Rup; 
hScope.Constellation = hMod.Constellation; 
groupDelay = (hFilDesign.NumberOfSymbols/2); 
hScope.MeasurementDelay = groupDelay /hScope.SymbolRate; 
update(hScope, xmt) 
hScope.PlotSettings.Constellation = 'on'; 
hFil.Numerator = hFil.Numerator / max(hFil.Numerator); 
xmt = filter(hFil, upsample(sym, Rup)); 
reset(hScope) 
Update(hScope, xmt) 
hScope.PlotSettings.SignalTrajectory = 'on'; 
hScope.PlotSettings.SignalTrajectoryStyle = ':m';
autoscale(hScope) 
rcv = awgn(xmt, 20, 'measured'); % Add AWGN 
reset(hScope) 
update(hScope, rcv) 
hScope.PlotSettings.SignalTrajectory = 'off'; 
hScope.PlotSettings.Constellation = 'on'; 


