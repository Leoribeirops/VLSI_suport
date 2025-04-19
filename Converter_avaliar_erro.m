clc;
clear;

load('ECG_MIT_1.mat');

% 1. Converte .mat → binário em .txt
decimal_mat_to_bin_txt('ECG_MIT_1.mat', 'ECG_MIT_1', 'ECG_MIT_1.txt', 13, 0);

% 2. Converte binário .txt → .mat novamente
bin_txt_to_mat('ECG_MIT_1.txt', 'ecg_rec.mat', 'ecg_rec', 13, 0);

% 3. Verificação
load('ECG_MIT_1.mat');
load('ecg_rec.mat');

% Comparação
erro = max(abs(ECG_MIT_1(:) - ecg_rec(:)));
fprintf("Erro máximo na conversão: %.10f\n", erro);

figure; plot(ECG_MIT_1(1:1:2000)), title('original');
figure; plot(ecg_rec(1:1:2000)), title('recuperado');
