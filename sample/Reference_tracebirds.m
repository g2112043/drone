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
                Reference.type=["trace_birds_pestbirds"];
                Reference.name=["trace_pestbirds"];
                Reference.param={""};
    end
end
