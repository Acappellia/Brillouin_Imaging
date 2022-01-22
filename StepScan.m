function StepScan(mTimer,~,uiHandles,interval,xcount,ycount,xstep,ystep,tolerance)

persistent i j xlastpos;
if isempty(i)
    i = 1;
end
if isempty(j)
    j = 0;
end

pos = QueryPos;
xpos = str2double(pos(1));
ypos = str2double(pos(2));
if isempty(xlastpos)
    xlastpos = xpos;
end
uiHandles.inputXPos.set('String', pos(1));
uiHandles.inputYPos.set('String', pos(2));
if ((xstep - tolerance <= abs(xpos - xlastpos)) && (abs(xpos - xlastpos) <= xstep + tolerance)) || (xpos - xlastpos == 0)
    xlastpos = xpos;
else
    fprintf('Table movement cannot keep up! Try increasing the interval!');
    mTimer.stop;
    return
end

if (j < ycount)
    if (i < xcount)
        if (mod(j,2) == 0)
            SetPos('x',xpos + xstep);
        else
            SetPos('x',xpos - xstep);
        end
        % 此处插入相机的拍摄以及处理函数
        i = i + 1;
        return
    end
    SetPos('y',ypos + ystep);
    % 此处插入相机的拍摄以及处理函数
    j = j + 1;
    i = 1;
    return
end
mTimer.stop;
fprintf('SCAN COMPLETE')
return