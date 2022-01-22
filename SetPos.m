function SetPos(axes, pos)
global scom;
out = 'm';
if contains(axes,'x')
    out = append(out,' x=',string(pos(1)));
    pos(1) = [];
end
if contains(axes,'y')
    out = append(out,' y=',string(pos(1)));
    pos(1) = [];
end
if contains(axes,'z')
    out = append(out,' z=',string(pos(1)));
end
fprintf(scom,out);
return