function Reference = Reference_human(~,param)
%% reference class demo
% reference property ��Reference class�̃C���X�^���X�z��Ƃ��Ē�`
%1�@�ڂ�waypoint�C2�@�ڈȍ~�̓{���m�C�Ƃ�
        clear Referenceh
        Reference.type=["human_input"];
        Reference.name=["human"];
        id = param{2};
     if strcmp('conplex',param{1}.txt)
        refP = [2 0;2 10;8 0]';
        select_probability = [0.3;0.3;0.5];
    elseif strcmp('straight',param{1}.txt)
        refP =[1 0;1 10]';
        select_probability = [0.5;0.5];
    elseif strcmp('intersection',param{1}.txt)
        refP = [5 0;10 5;5 10;0 5]';
        select_probability = [0.25;0.25;0.25;0.25];
     end
        Reference.param={[refP],[select_probability],id,param{1}.node};

end
