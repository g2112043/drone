classdef DIRECT_ESTIMATOR < ESTIMATOR_CLASS
    % Directory generate the estimated state from the sensor output.
    % obj = DIRECT_ESTIMATOR(agent,~)
    properties
        % state
        result
        self
    end
    methods
        function obj = DIRECT_ESTIMATOR(self,~)
            obj.self = self;
            obj.result.state=state_copy(self.model.state);
        end
        function result=do(obj,varargin)
            % Copy field values corresponding to the field of obj.result.state (=model.state) only.
            % 【Input】
            % 【Output】void
            F = fieldnames(obj.result.state);
            for i = 1:length(F)
                if ~strcmp(F{i},'list') && ~strcmp(F{i},'num_list') && ~strcmp(F{i},'type')
                    if contains(F{i}, fieldnames(obj.self.sensor.result.state))
                        obj.result.state.set_state(F{i},obj.self.sensor.result.state.(F{i}));
                    end
                end
            end
            result=obj.result;
        end
        function show(obj)
            obj.result.state
        end
    end
end

