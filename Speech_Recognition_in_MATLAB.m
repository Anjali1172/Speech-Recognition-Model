clc
Fs=44100;
N=16;
channel=2;
duration=3;
recObj = audiorecorder(Fs, N, channel);
disp('Start speaking.')
% Record in 3 seconds
recordblocking(recObj, duration);
disp('End of Recording.');
% Listen again
play(recObj);
% save sound to array
y = getaudiodata(recObj);
%save wave file with a new name
[~,~] = uiputfile('myyes1.wav','E:\');
% save file wave
audiowrite('E:\myyes1.wav',y,Fs)
%For No
recObj = audiorecorder(Fs, N, channel);
disp('Start speaking.')
% Record in 3 seconds
recordblocking(recObj, duration);
disp('End of Recording.');
% Listen again
play(recObj);
% save sound to array
y = getaudiodata(recObj);
%save wave file with a new name
[newfile,newpath] = uiputfile('myno1.wav','E:\');
% save file wave
audiowrite('E:\myno1.wav',y,Fs)
training_files_yes = dir('C:\Users\Anjali Roy\yes1.wav');
testing_files_yes = dir('E:\myyes1.wav');
training_files_no = dir('C:\Users\Anjali Roy\no1.wav');
testing_files_no = dir('E:\myno1.wav');
% read the 'yes' training files and calculate the energy of them.
data_yes = [];
for i = 1:length(training_files_yes)
file_path = strcat(training_files_yes(i).folder,'\',training_files_yes(i).name);% get the file path with name
[y,fs] = audioread(file_path); % read the audio file

energy_yes=sum(y.^2); % calculate the energy
data_yes = [data_yes energy_yes]; % append the energy with all other energies of the other files
end
energy_yes=mean(data_yes); % calculate the average energy
fprintf('The energy of yes is \n');
disp(energy_yes);

% read the 'no' training files and calculate the energy of them.
data_no = [];
for i = 1:length(training_files_no)
file_path = strcat(training_files_no(i).folder,'\',training_files_no(i).name);
[y,fs] = audioread(file_path);

energy_no=sum(y .^2);
data_no = [data_no energy_no];
end
energy_no=mean(data_no);
fprintf('The energy of no is \n');
disp(energy_no);

% Evaluation 

% read the 'yes' tesing files and calculate the energy of them.

for i = 1:length(testing_files_yes)
file_path = strcat(testing_files_yes(i).folder,'\',testing_files_yes(i).name);
[y,fs] = audioread(file_path);

y_energy  = sum(y.^2);
 % test if the energy of this file is closer to YES or NO average energies
    if(abs(y_energy-energy_yes) < abs(y_energy-energy_no)) 
        fprintf('Test file [yes] #%d classified as yes ,E=%d\n',i,y_energy);
    else
        fprintf('Test file [yes] #%d classified as no E=%d\n',i,y_energy);
    end
end

for i = 1:length(testing_files_no)
file_path = strcat(testing_files_no(i).folder,'\',testing_files_no(i).name);
[y,fs] = audioread(file_path);

y_energy  = sum(y.^2);

    if(abs(y_energy-energy_yes) < abs(y_energy-energy_no))
        fprintf('Test file [no] #%d classify- yes ,E=%d\n',i,y_energy);
    else
        fprintf('Test file [no] #%d classify- no ,E=%d\n',i,y_energy);
    end
end

