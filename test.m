scom = instrfind('Type', 'serial', 'Port', 'COM1', 'Tag', '');
if isempty(scom)
    port = 'COM1';
    baudrate = '9600';
    scom = serial(port,'BaudRate',baudrate,'Parity','none','DataBits',8,'StopBits',1);
    scom.Terminator = 'CRLF';
    scom.InputBufferSize = 1024;
    scom.OutputBufferSize = 1024;
    scom.Timeout = 0.5;
else
    fclose(scom);
    scom = scom(1);
end
fopen(scom);
disp('OPENED');

%fprintf(scom, 'RDP1/0');
fwrite(scom, [char(02),'RPS2/2/0/0/100/0/0/0',char(13),char(10)]);
%fwrite(scom, [char(02),'RPS2/2/0/0/100/0/0/0']);
out = fgetl(scom);
out = strsplit(out,'\t');
disp(out(2));
fclose(scom);
disp('CLOSED');