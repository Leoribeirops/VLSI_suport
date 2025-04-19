function decimal_mat_to_bin_txt(mat_file, var_name, txt_file, total_bits, frac_bits)
% Converte vetor decimal de um .mat para arquivo .txt em binário ponto fixo com sinal
%
% mat_file    : nome do arquivo .mat (ex: 'ecg_dec.mat')
% var_name    : nome da variável dentro do .mat (ex: 'ecg_dec')
% txt_file    : nome do arquivo .txt de saída (ex: 'ecg_bin_output.txt')
% total_bits  : total de bits da palavra (ex: 18)
% frac_bits   : número de bits fracionários (ex: 9)

    % Carrega o .mat
    S = load(mat_file);
    if ~isfield(S, var_name)
        error('Variável "%s" não encontrada em "%s".', var_name, mat_file);
    end
    data = S.(var_name);

    % Saturação
    min_val = -2^(total_bits - 1) / 2^frac_bits;
    max_val = (2^(total_bits - 1) - 1) / 2^frac_bits;

    % Abre o arquivo de saída
    fid = fopen(txt_file, 'w');
    if fid == -1
        error('Erro ao criar o arquivo: %s', txt_file);
    end

    for i = 1:length(data)
        val = min(max(data(i), min_val), max_val);
        fixed_val = round(val * 2^frac_bits);
        if fixed_val < 0
            fixed_val = fixed_val + 2^total_bits;
        end
        bin_str = dec2bin(fixed_val, total_bits);
        fprintf(fid, '%s\n', bin_str);
    end

    fclose(fid);
    fprintf('✔️ Arquivo "%s" gerado com sucesso com %d amostras.\n', txt_file, length(data));
end
