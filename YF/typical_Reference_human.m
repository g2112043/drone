function Reference = Reference_human(agent)
%% reference class demo
% reference property ��Reference class�̃C���X�^���X�z��Ƃ��Ē�`
%1�@�ڂ�waypoint�C2�@�ڈȍ~�̓{���m�C�Ƃ�
    for i = 1:length(agent)
        clear Referenceh
        Reference.type=["human_input"];
        Reference.name=["human"];
        Reference.param={[]};
        agent(i).set_reference(Reference);
    end
end
