function status = MovPos(axes, pos)
global scom;
status = 0;
if ~isempty(find(axes == 'x', 1))
    input = [char(02),'RPS1/2/0/0/',num2str(pos(1)),'/0/0/0',newline,char(13)];
    pos(1) = [];
    fprintf(scom,input);
    out = strsplit(fscanf(scom),char(11));
    if(out(1) == 'E')
        status = 1;
    end
    if(out(1) == 'W')
        status = 2;
    end
end
if ~isempty(find(axes == 'y', 1))
    input = [char(02),'RPS2/2/0/0/',num2str(pos(1)),'/0/0/0',newline,char(13)];
    %pos(1) = [];
    fprintf(scom,input);
    out = strsplit(fscanf(scom),char(11));
    if(out(1) == 'E')
        status = 1;
    end
    if(out(1) == 'W')
        status = 2;
    end
end
return

