function res = llegir_ulls(ruta)
    %obtenim una estructura 2x2 amb els valors continguts a l'arxiu
    %delimitats per espais
    res = reshape(dlmread(ruta,'', 1,0),[2,2])';
end