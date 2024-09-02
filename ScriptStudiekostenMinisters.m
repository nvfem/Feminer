
clear
close all

%% Huurprijzen, groei genomen over 2021-2023
h_ams = [680 791 948];
h_utr = [564 621 708];
h_rot = [540 598 672];
h_lei = [432 447 518];
h_nij = [420 495 517];
h_ein = [442 453 502];
h_til = [387 467 493];
h_maa = [415 468 481];
h_grn = [391 448 480];
h_dlf = [420 411 469];
h_ens = [330 341 361];
h_wag = [349 327 359];

Yesilgoz = struct('stad',h_ams,'duur',6,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);
Keijzer = struct('stad',h_ams,'duur',10,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);
Hermans = struct('stad',h_ams,'duur',6,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);
Agema = struct('stad',h_utr,'duur',5,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);
Uitermark = struct('stad',h_ams,'duur',13,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);
Klever = struct('stad',h_rot,'duur',6,'duurstudie',4,'boete',[],'beurs',[],'huur',[],'totalekosten',[],'collegegeld',[]);

A = Agema;

% Basisbeurs neemt 9% toe per jaar (o.b.v toename van afgelopen jaar)
beurs = 300*12;             % basisbeurs per jaar
g_beurs = 1.0909;

% Gemiddelde stijging collegegeld afgelopen 10 jaar
collegegeld = [1906 1951 1984 2006 2060 2078 2143 2168 2209 2314 2530];
g_cg = [collegegeld(2:end)./collegegeld(1:end-1)-1];
g_cg = 1+mean(g_cg);

% Laat de langstudeerboete meegroeien met het collegegeld
boete = 3000;
g_boete = g_cg;

% Boete voor elk jaar berekenen
boete_pj = NaN(1,A.duur);
for i = 1:A.duur
    boete_pj(i) = boete*(g_boete^i);
end
if A.duur - A.duurstudie > 1
    boetes = boete_pj(A.duurstudie+2:end);
    A.boete = sum(boetes);
else
    A.boete = 0;
end

cg24 = collegegeld(end);                        % 2024-2025
cg_jaar = NaN(1,A.duur);
for i = 1:A.duur
    cg_jaar(i) = cg24*(g_cg^i);
end
A.collegegeld = sum(cg_jaar);

h_stad = A.stad;
g_huur = (h_stad(2:end)./h_stad(1:end-1)-1);
g_huur = 1 + mean(g_huur);

% Laat de huurprijs starten bij het verwachte bedrag in 2024
huur = h_stad(end)*g_huur*12;                                 % huur per jaar
huur_jaar = NaN(1,A.duur);
for i = 1:A.duur
    huur_jaar(i) = huur*(g_huur^i);
end
A.huur = sum(huur_jaar);

beurs_jaar = NaN(1,A.duurstudie);
for i = 1:A.duurstudie
    beurs_jaar(i) = beurs*(g_beurs^i);
end
A.beurs = sum(beurs_jaar);

A.totalekosten = A.collegegeld + A.huur + A.boete - A.beurs;
disp(A.totalekosten)





