function[ j ] = MapJoint( name )
    global data;

    for i=1:length(data)
        if strcmp(name, data(i).name)
          j=i;
        end
    end
end