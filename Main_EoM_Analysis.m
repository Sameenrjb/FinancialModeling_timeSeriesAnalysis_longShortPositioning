
% A script to analyze a time-series and output calculate the Ease-of-Movement (EoM) technical indicator

% Authour: Sameen Rajabi
% Last Update: November, 2021


%% User Setting
[file, path] = uigetfile('*.csv', 'Select the Path to Time Series Table ...');
if path(end) ~= '/'
    error('Please select a correct path to time series table ... ')
else
    input_data = readtable(fullfile(path, file));
end

n_dayMovingAverage_input = inputdlg('Enter Number of Days for EoM Moving Average');

if ~isempty(n_dayMovingAverage_input)
    n_dayMovingAverage = str2num(n_dayMovingAverage_input{1});
    
    if isempty(n_dayMovingAverage)
        error('Please input an integger for number of days for moving average ...');
    end
else   
    n_dayMovingAverage = 9;
end
% input_data = readtable('SP500_DailyOHLC_01011990_12302013.csv');
% n_dayMovingAverage = 9;

%% EoM Calculation
[EoM, EoM_movingAverage] = calculate_EoM(input_data.High, input_data.Low, ...
    input_data.Volume, n_dayMovingAverage);

%% Find Buy / Sell Signals
[buySignal_index, sellSignal_index] = find_buy_sell_signal_index(EoM_movingAverage);

%% Plots
generate_plots(input_data, EoM, EoM_movingAverage, n_dayMovingAverage, ...
    buySignal_index, sellSignal_index)

%% List of Fucntion
function [EoM, EoM_movingAverage] = calculate_EoM(highPrice, lowPrice, vol, n_dayMovingAverage)
% calcualte_EoM: calculates Ease-of-Movement for an underlying

% midpointMove
mp_move = (diff(highPrice) + diff(lowPrice)) / 2;
% box ratio
box_ratio = (vol / 10000) ./ (highPrice - lowPrice);
% EoM 
EoM = mp_move ./ box_ratio(2:end);
% EoM_movingAverage
EoM_movingAverage = movmean(EoM, n_dayMovingAverage);

end

function [buySignal_index, sellSignal_index] = find_buy_sell_signal_index(EoM_movingAverage)

signChangedHere = diff(sign(EoM_movingAverage)) / 2;
buySignal_index = find(signChangedHere > 0);
sellSignal_index = find(signChangedHere < 0);

end

function generate_plots(input_data, EoM, EoM_movingAverage, ...
    n_dayMovingAverage, buySignal_index, sellSignal_index)

h_EoM = figure();

% EoM and EoM_movingAverage vs. time
subplot(2,1,1)
plot(input_data.Date(2:end), EoM, 'r'); hold on;
plot(input_data.Date(2:end), EoM_movingAverage, 'c'); 

xlim(datetime([input_data.Date(2).Year input_data.Date(end).Year], ...
    [input_data.Date(2).Month input_data.Date(end).Month], ...
    [input_data.Date(2).Day input_data.Date(end).Day]))

ylim([min(EoM) max(EoM)])

xtickformat('MM-yyyy')
legend('EoM', ['EoM - ' num2str(n_dayMovingAverage) ' period moving average'], 'Location', 'southeast')
title('Ease of Movement')

subplot(2,1,2)
plot(input_data.Date, input_data.Close, '-k'); hold on;
plot(input_data.Date(buySignal_index), input_data.Close(buySignal_index), 'og'); hold on;
plot(input_data.Date(sellSignal_index), input_data.Close(sellSignal_index), 'or')
legend('Closing Price', 'Buy Signal', 'Sell Signal' , 'Location', 'southeast');
title('Closing Price')

set(gcf, 'Color', 'w', 'Position', [42 521 1200 374])

end


