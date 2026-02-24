%% Vettori per calcolare lo scarto
luxtelefono = [90 107 173 218 281 354 445];
luxnostro = [82 105 130 140 170 200 230];

differenza = luxtelefono-luxnostro;

%% Interpolazione dati
clc

% Dati di interpolazione e creazione valori 
y = [0.102 0.295]; % tensione
x = [0 518]; % lux
p = polyfit(x,y,length(x)-1);
portata_lux = (5-0.1)/(270000*11*10^(-9));
% lux = linspace(0,portata_lux,252)';
lux = linspace(0,portata_lux)

%% Estrazione cifre
portata_lux = (5-0.1)/(270000*11*10^(-9))*1/10;
lux = linspace(0,portata_lux,252)';

% Estraggo le centinaia e le metto in luxcent
luxcent = fix(lux/100);

% Estraggo le decine e le metto in luxdec
luxdec = fix((lux-luxcent*100)/10);

% Estraggo le unità e le metto in luxunit
luxunit = round(lux - luxcent*100 - luxdec*10);

% Aggiungo le prime 4 caselle con 0 0 0
luxcent = [zeros(4,1); luxcent];
luxdec = [zeros(4,1); luxdec];
luxunit = [zeros(4,1); luxunit];

% Alcune volte non è stato contato il riporto --> aggiusto i vari vettori 
for i=1:256
    if luxunit(i) >= 10
        luxunit(i) = 0;
        luxdec(i) = luxdec(i) + 1;
    end
    if luxdec(i) >= 10
        luxdec(i) = 0;
        luxcent(i) = luxcent(i) + 1;
    end
end

[luxcent luxdec luxunit]

%% Scrittura del file txt
%clc

delete LUT.txt
fileID = fopen('LUT.txt','w');
for i=1:length(luxcent)
    fprintf(fileID,'.db %d,%d,%d,%d\n', i, luxcent(i), luxdec(i), luxunit(i));
end
fclose(fileID);