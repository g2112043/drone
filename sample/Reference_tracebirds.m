function Reference = Reference_tracebirds(id,Nb,tex,N,fp,want_falm,position,distance)
%% reference class demo
% reference property ��Reference class�̃C���X�^���X�z��Ƃ��Ē�`
%1�@�ڂ�waypoint�C2�@�ڈȍ~�̓{���m�C�Ƃ�
if tex==1
        if id>=Nb+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["trace_birds_drone"];
            Reference.name=["trace_drone"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        else
            clear Reference
            Reference.type=["trace_birds_pestbirds"];
            Reference.name=["trace_pestbirds"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        end
elseif tex==2
        if id>=Nb+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["trace_birds_drone"];
            Reference.name=["trace_drone"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        else
            clear Reference
            Reference.type=["trace_birds_pestbirds_Dis"];
            Reference.name=["trace_pestbirds"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        end
elseif tex==3
        if id>=Nb+1%�ŏI�@�̂͌��ɂȂ�\��Ȃ̂�sheep_ref�͂Ȃ�
            clear Reference
            Reference.type=["trace_birds_drone"];
            Reference.name=["trace_drone"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        else
            clear Reference
            Reference.type=["wheelchair_trace_birds_pestbirds_Dis"];
            Reference.name=["trace_pestbirds"];
            Reference.param{1}=N;
            Reference.param{2}=Nb;
            Reference.param{3}=distance;
            Reference.param{4}=fp;
            Reference.param{5}=want_falm(id);
            Reference.param{6}=position;
%             agent(i).set_reference(Reference);
        end
end
end
