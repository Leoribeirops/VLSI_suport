function bin_txt_to_mat(txt_file, mat_file, var_name, total_bits, frac_bits)
% Converte arquivo .txt com binários para vetor decimal salvo em .mat
%
% txt_file    : arquivo com binários (ex: 'ecg_bin_output.txt')
% mat_file    : arquivo de saída .mat (ex: 'ecg_rec.mat')
% var_name    : nome da variável a ser criada (ex: 'ecg_rec')
% total_bits  : número total de bits (ex: 18)
% frac_bits   : número de bits fracionários (ex: 9)

    fid = fopen(txt_file, 'r');
    if fid == -1
        error('Erro ao abrir o arquivo: %s', txt_file);
    end

    values = [];
    while ~feof(fid)
        line = fgetl(fid);
        line = strtrim(line);
        if length(line) ~= total_bits
            warning('Linha ignorada (tamanho incorreto): %s', line);
            continue;
        end

        int_val = bin2dec(line);
        if line(1) == '1'
            int_val = int_val - 2^total_bits;
        end

        val = int_val / 2^frac_bits;
        values(end + 1) = val;
    end
    fclose(fid);

    S.(var_name) = values(:);  % vetor coluna
    save(mat_file, '-struct', 'S');
    fprintf('✔️ Arquivo "%s" gerado com a variável "%s" (%d amostras).\n', mat_file, var_name, length(values));
end
