global scom

scom = instrfind('Type', 'serial', 'Port', 'COM3', 'Tag', '');
if isempty(scom)
    port = get(handles.inputPort,'String');
    baudrate = str2double(get(handles.inputBaudrate,'String'));
    scom = serial(port,'BaudRate',baudrate,'Parity','none','DataBits',8,'StopBits',1);
    scom.Terminator = 'CR';
    scom.InputBufferSize = 1024;
    scom.OutputBufferSize = 1024;
    scom.Timeout = 0.5;
else
    fclose(scom);
    scom = scom(1);
end
fopen(scom);
fprintf('Port Opened\n');


fprintf(scom, 'w x y z');
out = fscanf(scom);
pos = strsplit(out,' ');
pos(1) = [];

y = str2double(pos(2));
step = str2double('100');
pos2 = {'10100','100','0','100','111'};
SetPos('x',pos2);