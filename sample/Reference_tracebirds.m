function Reference = Reference_tracebirds(id,Nb)
%% reference class demo
% reference property ��Reference class�̃C���X�^���X�z��Ƃ��Ē�`
    if id>=Nb+1%�����̓h���[���̕���
                clear Reference
                Reference.type=["trace_birds_drone"];
                Reference.name=["trace_drone"];
                Reference.param={""};
    else%�����͊Q���̕���
                clear Reference
                Reference.type=["wheelchair_trace_birds_pestbirds_Dis"];
                Reference.name=["trace_pestbirds"];
                Reference.param=100;
    end
end
