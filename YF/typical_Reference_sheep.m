function typical_Reference_sheep(agent,Na,num)
%% reference class demo
% reference property ��Reference class�̃C���X�^���X�z��Ƃ��Ē�`
%1�@�ڂ�waypoint�C2�@�ڈȍ~�̓{���m�C�Ƃ�
if num==1
    for i = 1:length(agent)
        if i>=length(agent)-Na+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["example_waypoint"];
            Reference.name=["point"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        else
            clear Referenceh
            Reference.type=["sheep_input"];
            Reference.name=["sheep"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        end
    end
elseif num==2
    for i = 1:length(agent)
        if i>=length(agent)-Na+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["example_waypoint"];
            Reference.name=["point"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        else
            clear Reference
            Reference.type=["sheep_Dis_input"];
            Reference.name=["sheep"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        end
    end
elseif num==3
    for i = 1:length(agent)
        if i>=length(agent)-Na+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["example_waypoint"];
            Reference.name=["point"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        else
            clear Reference
            Reference.type=["wheelchair_sheep_Dis_input"];
            Reference.name=["sheep"];
            Reference.param={[]};
            agent(i).set_reference(Reference);
        end
    end
    
end
end
