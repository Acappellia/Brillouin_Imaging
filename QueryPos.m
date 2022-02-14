function pos = QueryPos
global scom;
fprintf(scom, 'w x y z');
out = fscanf(scom);
pos = strsplit(out,' ');
pos(1) = [];
return