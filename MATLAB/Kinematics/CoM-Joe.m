function [] = CoM()
    global data;
    global C;

    for i = 1:length(data)
        this = data(i);
        C = this.M * this.CoM;
    end
    
    % sum(C)/sum(M)
end