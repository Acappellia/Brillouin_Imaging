function count = IsBusy(hObject)
set(hObject,'Enable','off');
global scom;
t = 'B';
count = -1;
while (~isempty(find(t == 'B', 1)))
    fprintf(scom,'/');
    t = fscanf(scom);
    count = count + 1;
    pause(0.1);
end
set(hObject,'Enable','on');
return