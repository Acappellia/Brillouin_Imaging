function [result, status] = QueryPos
global scom;
status = 0;
fprintf(scom, [char(02),'RDP1/0',newline,char(13)]);
out = strsplit(fscanf(scom),char(11));
if(out(1) == 'E')
    status = 1;
end
result(1) = out(3);
fprintf(scom, [char(02),'RDP2/0',newline,char(13)]);
out = strsplit(fscanf(scom),char(11));
if(out(1) == 'E')
    status = 1;
end
result(2) = out(3);
return