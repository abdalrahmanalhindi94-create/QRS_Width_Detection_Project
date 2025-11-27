% Create a new figure
figure;

% Plotting the original ECG signal with noise
subplot(5, 2, 1);
plot(Data.ECG);
title('Original ECG Signal with Noise');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Plotting the relaxation phase of ECG signal
subplot(5, 2, 2);
plot(ecg_relax);
title('Relaxation Phase ECG Signal');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Plotting the exercise phase of ECG signal
subplot(5, 2, 3);
plot(ecg_exercise);
title('Exercise Phase ECG Signal');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Plotting the rehabilitation phase of ECG signal
subplot(5, 2, 4);
plot(ecg_rehab);
title('Rehabilitation Phase ECG Signal');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Bandpass filter for noise cancellation of other sampling frequencies (Filtering): Pan-Tompkins
f1 = 5;  % Cutoff low frequency to get rid of baseline wander
f2 = 15;  % Cutoff frequency to discard high frequency noise
Wn = [f1 f2] * 2 / fs;  % Cutoff based on fs
N = 3;  % Order of 3 less processing
[a, b] = butter(N, Wn);  % Bandpass filtering
ecg_fi = filtfilt(a, b, ecg_rehab);
ecg_fi = ecg_fi / max(abs(ecg_fi));

% Plotting the filtered ECG signal
subplot(5, 2, 5);
plot(ecg_fi);
title('Bandpass Filtered ECG Signal');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Plotting the derivative operation result from Pan-Tompkins function
subplot(5, 2, 6);
plot(ecg_d);
title('Derivative Operation Result from Pan-Tompkins');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');

% Plotting the detected R-peaks
subplot(5, 2, 7);
plot(ecg_d);
hold on;
scatter(R_Locs, R_Peaks, 'r', 'filled');
title('Detected R-peaks');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');
legend('ECG Signal', 'R-peaks');
hold off;

% Plotting the detected Q onset peaks
subplot(5, 2, 8);
plot(ecg_d);
hold on;
scatter(Q_on_set_locs, Q_on_set_Peaks, 'r', 'filled');
title('Detected Q Onset Peaks');
xlabel('Sample[N]');
ylabel('Amplitude[mv]');
legend('ECG Derivative Signal', 'Q Onset Peaks');
hold off;

% Plotting the detected S off-set-peaks
subplot(5, 2, 9);
plot(ecg_d);
hold on;
scatter(S_off_set_Locs, S_off_set_Peaks, 'r', 'filled');
title('Detected S off-set-peaks');
xlabel('Sample[N]');
ylabel('Amplitude[mv]')
legend('ECG Signal', 'S off-set-peaks');
hold off;



% Create a new figure for frequency response plot
figure;
% Define the filter coefficients
order = 3;  % Filter order
f1 = 5;     % Lower cutoff frequency (Hz)
f2 = 15;    % Upper cutoff frequency (Hz)
fs = 250;   % Sampling frequency (Hz)

% Normalize the cutoff frequencies based on the sampling frequency
Wn = [f1 f2] * 2 / fs;  % Normalized cutoff frequencies

% Design the Butterworth bandpass filter
[b, a] = butter(order, Wn, 'bandpass');

% Plot the frequency response of the filter
freqz(b, a, 1024, fs);

% Add labels and title to the plot
title('Frequency Response of Butterworth Bandpass Filter');
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
