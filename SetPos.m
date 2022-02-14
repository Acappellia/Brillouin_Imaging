function SetPos(axes, pos)
global scom;
out = 'm';
if ~isempty(find(axes == 'x', 1))
    out = [out,' x=',num2str(pos(1))];
    pos(1) = [];
end
if ~isempty(find(axes == 'y', 1))
    out = [out,' y=',num2str(pos(1))];
    pos(1) = [];
end
if ~isempty(find(axes == 'z', 1))
    out = [out,' z=',num2str(pos(1))];
end
fprintf(scom,out);
fscanf(scom);
return