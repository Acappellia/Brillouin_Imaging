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
set(uiHandles.inputXPos, 'String', pos(1));
set(uiHandles.inputYPos, 'String', pos(2));
if ((xstep - tolerance <= abs(xpos - xlastpos)) && (abs(xpos - xlastpos) <= xstep + tolerance)) || (xpos - xlastpos == 0)
    xlastpos = xpos;
else
    fprintf('Table movement cannot keep up! Try increasing the interval!\n');
    stop(mTimer);
    delete(mTimer);
    return
end

if (j < ycount)
    if (i < xcount)
        if (mod(j,2) == 0)
            SetPos('x',xpos + xstep);
        else
            SetPos('x',xpos - xstep);
        end
        % æ­¤å¤„æ?’å…¥ç›¸æœºçš„æ‹?æ‘„ä»¥å?Šå¤„ç?†å‡½æ•°
        i = i + 1;
        return
    end
    SetPos('y',ypos + ystep);
    % æ­¤å¤„æ?’å…¥ç›¸æœºçš„æ‹?æ‘„ä»¥å?Šå¤„ç?†å‡½æ•°
    j = j + 1;
    i = 1;
    return
end
stop(mTimer);
delete(mTimer);
clear i j xlastpos;
fprintf('SCAN COMPLETE\n')
return