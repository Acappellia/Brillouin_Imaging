function status = MovPos(axes, pos)
global scom;
if ~isempty(find(axes == 'x', 1))
    input = [char(02),'RPS1/2/0/0/',num2str(pos(1)),'/0/0/0',char(13),char(10)];
    pos(1) = [];
    fwrite(scom,input);
    out = strsplit(fgetl(scom),'\t');
    status(1) = out(1);
end
if ~isempty(find(axes == 'y', 1))
    input = [char(02),'RPS2/2/0/0/',num2str(pos(1)),'/0/0/0',char(13),char(10)];
    %pos(1) = [];
    fwrite(scom,input);
    out = strsplit(fgetl(scom),'\t');
    status(2) = out(1);
end
return

