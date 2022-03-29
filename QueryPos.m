function [result, status] = QueryPos
global scom;
fwrite(scom, [char(02),'RDP1/0',char(13),char(10)]);
out = strsplit(fgetl(scom),'\t');
status(1) = out(1);
result(1) = out(3);
fwrite(scom, [char(02),'RDP2/0',char(13),char(10)]);
out = strsplit(fgetl(scom),'\t');
status(2) = out(1);
result(2) = out(3);
return