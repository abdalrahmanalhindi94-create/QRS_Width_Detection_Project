% Exercise
% Load the data

load('C:\Users\abdo2\OneDrive\سطح المكتب\QRS_detection\Data.mat');

% Extracting the main dataset and variables
ecg = Data.ECG;
hr = Data.HR;
br = Data.BR;
rr = Data.RR;

% Define phase intervals and sampling frequency
exercise_phase_start = 166655;
exercise_phase_end = 673085;


fs = 250; % Sampling frequency

% Segmenting the data into different phases
ecg_exercise = ecg(exercise_phase_start:exercise_phase_end);





% moving to excersice
[qrs_amp_raw,qrs_i_raw,ecg_d,delay]=pan_tompkin(ecg_exercise,fs,0);

ecg_d = ecg_d;


[pks_r,locs_r] = findpeaks(ecg_d, "MinPeakHeight", 0.1);

R_Peaks = [];
R_Locs = [];
Q_on_set_Peaks = [];
Q_on_set_locs = [];
S_off_set_Peaks = [];
S_off_set_Locs = [];



threshold = 0.6 * max(ecg_d);

% Loop over each peak to check its height and store accordingly
for i = 1:length(pks_r)
    if pks_r(i) > threshold
        % Store peak value in R_Peaks
        R_Peaks(end+1) = pks_r(i);
        % Store peak location in R_Locs
        R_Locs(end+1) = locs_r(i);
        
        Q_on_set_Peaks(end+1) = pks_r(i-1); % Store i-1 value in Q_Peaks
        Q_on_set_locs(end+1) = locs_r(i-1); % Store i-1 location in Q_Locs
        S_off_set_Peaks(end+1) = pks_r(i+1); % Store i-1 value in Q_Peaks
        S_off_set_Locs(end+1) = locs_r(i+1); % Store i-1 location in Q_Locs
    end
end

k=1.6; % Expermental Factor
QRS_duration_E = (S_off_set_Locs - Q_on_set_locs) / (k*fs) * 1000; % in ms

average_QRS = mean(QRS_duration_E); % Average of all beats
std_QRS = std(QRS_duration_E); % STD of all beats
num_QRS_complexes = length(R_Locs); % Count the number of QRS complexes

disp('average QRS')
disp(average_QRS)
disp('STD QRS')
disp(std_QRS)
disp('Number of QRS complexes:')
disp(num_QRS_complexes)

